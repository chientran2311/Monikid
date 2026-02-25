import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'auth_repository.dart';
import 'package:monikid/features/auth/domain/params/auth_param.dart';
import 'package:monikid/features/auth/domain/responses/auth_response.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 50,
      colors: true,
      printEmojis: true,
    ),
  );

  // Inject Firebase instances thông qua Module của bạn
  AuthRepositoryImpl(this._firebaseAuth, this._firestore);

  // 1. Getter: Lấy user hiện tại
  @override
  User? get currentUser => _firebaseAuth.currentUser;

  // 2. Getter: Lắng nghe trạng thái đăng nhập
  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // 3. Hàm Đăng nhập
  @override
  Future<AuthResponse> signIn(SignInParam param) async {
    try {
      _logger.i('🔐 Attempting sign in for email: ${param.email}');
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: param.email,
        password: param.password,
      );

      if (credential.user == null) {
        throw Exception('Sign in failed. No user found.');
      }

      _logger.i('✅ Sign in successful for uid: ${credential.user?.uid}');

      // Fetch user role
      final role = await getUserRole(credential.user!.uid);
      _logger.i('✅ Fetched role: $role');

      if (role != null && role != param.selectedRole) {
        // Role mismatch - sign out and throw error
        await _firebaseAuth.signOut();
        throw Exception('Tài khoản này không đăng ký với vai trò đã chọn.');
      }

      return AuthResponse(user: credential.user!, role: role);
    } catch (e) {
      _logger.e('❌ Sign in failed: $e');
      rethrow;
    }
  }

  // 4. Hàm Đăng ký & Đồng bộ Storage (Ví 1.000.000đ)
  @override
  Future<AuthResponse> signUp(SignUpParam param) async {
    try {
      _logger.i('📝 Starting sign up process for email: ${param.email}');
      _logger.d(
        'Sign up details - Name: ${param.fullName}, Phone: ${param.phone}, Role: ${param.role}',
      );

      // A. Tạo tài khoản trên Authentication
      _logger.i('🔐 Creating Firebase Auth account...');
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: param.email,
            password: param.password,
          );

      if (credential.user == null) {
        throw Exception('Sign up failed. No user found.');
      }

      final String uid = credential.user!.uid;
      _logger.i('✅ Auth account created with UID: $uid');

      await credential.user!.updateDisplayName(param.fullName);
      await credential.user!.reload();

      // B. Đồng bộ hóa Storage/Database ngay lập tức (Thay thế Trigger SQL cũ)
      _logger.i('💾 Syncing user data to Firestore...');

      final userData = {
        'uid': uid,
        'email': param.email,
        'full_name': param.fullName,
        'phone': param.phone,
        'role': param.role,
        'avatar_url': "https://i.pravatar.cc/150?img=11",
        'created_at': FieldValue.serverTimestamp(),
        'wallet': {
          'balance': 1000000.0, // Khởi tạo 1 triệu VND
          'currency': 'VND',
          'is_locked': false,
        },
        // Chỉ khởi tạo bank_account nếu là phụ huynh
        if (param.role == 'parent')
          'bank_account': {
            'account_number': 'BK-${DateTime.now().millisecondsSinceEpoch}',
            'bank_balance': 1000000.0,
            'is_verified': true,
          },
      };

      _logger.d('User data to save: $userData');

      await _firestore.collection('users').doc(uid).set(userData);

      _logger.i('✅ Firestore sync completed successfully!');
      _logger.i('💰 Wallet initialized with 1,000,000 VND');
      if (param.role == 'parent') {
        _logger.i('🏦 Bank account created for parent');
      }

      final updatedUser = _firebaseAuth.currentUser!;

      return AuthResponse(user: updatedUser, role: param.role);
    } on FirebaseAuthException catch (e) {
      _logger.e('❌ Firebase Auth Error: ${e.code} - ${e.message}');
      rethrow;
    } on FirebaseException catch (e) {
      _logger.e('❌ Firestore Error: ${e.code} - ${e.message}');
      rethrow;
    } catch (e, stackTrace) {
      _logger.e(
        '❌ Unexpected error during sign up',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  // 5. Hàm Đăng xuất
  @override
  Future<void> signOut() async {
    try {
      _logger.i('🚪 Signing out user: ${_firebaseAuth.currentUser?.email}');
      await _firebaseAuth.signOut();
      _logger.i('✅ Sign out successful');
    } catch (e) {
      _logger.e('❌ Sign out failed: $e');
      rethrow;
    }
  }

  // 6. Hàm Reset Password (gửi email đặt lại mật khẩu qua Firebase)
  @override
  Future<void> resetPassword(ResetPasswordParam param) async {
    try {
      _logger.i('📧 Sending password reset email to: ${param.email}');
      await _firebaseAuth.sendPasswordResetEmail(email: param.email);
      _logger.i('✅ Password reset email sent successfully');
    } on FirebaseAuthException catch (e) {
      _logger.e('❌ Reset password failed: ${e.code} - ${e.message}');
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'Không tìm thấy tài khoản với email này.';
          break;
        case 'invalid-email':
          errorMessage = 'Địa chỉ email không hợp lệ.';
          break;
        case 'too-many-requests':
          errorMessage = 'Quá nhiều yêu cầu. Vui lòng thử lại sau.';
          break;
        default:
          errorMessage =
              e.message ?? 'Đã xảy ra lỗi khi gửi email đặt lại mật khẩu.';
      }
      throw Exception(errorMessage);
    } catch (e) {
      _logger.e('❌ Reset password failed: $e');
      throw Exception('Lỗi hệ thống: ${e.toString()}');
    }
  }

  // 7. Lấy role của user từ Firestore
  @override
  Future<String?> getUserRole(String uid) async {
    try {
      _logger.i('👤 Fetching user role for uid: $uid');
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        final role = doc.data()?['role'] as String?;
        _logger.i('✅ User role: $role');
        return role;
      }
      _logger.w('⚠️ User document not found for uid: $uid');
      return null;
    } catch (e) {
      _logger.e('❌ getUserRole failed: $e');
      rethrow;
    }
  }
}
