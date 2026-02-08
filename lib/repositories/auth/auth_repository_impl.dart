import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'auth_repository.dart';

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
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      _logger.i('🔐 Attempting sign in for email: $email');
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _logger.i('✅ Sign in successful for uid: ${credential.user?.uid}');
      return credential;
    } catch (e) {
      _logger.e('❌ Sign in failed: $e');
      rethrow;
    }
  }

  // 4. Hàm Đăng ký & Đồng bộ Storage (Ví 1.000.000đ)
  @override
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String role,
  }) async {
    try {
      _logger.i('📝 Starting sign up process for email: $email');
      _logger.d('Sign up details - Name: $fullName, Phone: $phone, Role: $role');
      
      // A. Tạo tài khoản trên Authentication
      _logger.i('🔐 Creating Firebase Auth account...');
      UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final String uid = credential.user!.uid;
      _logger.i('✅ Auth account created with UID: $uid');

      // B. Đồng bộ hóa Storage/Database ngay lập tức (Thay thế Trigger SQL cũ)
      _logger.i('💾 Syncing user data to Firestore...');
      
      final userData = {
        'uid': uid,
        'email': email,
        'full_name': fullName,
        'phone': phone,
        'role': role,
        'avatar_url': "https://i.pravatar.cc/150?img=11",
        'created_at': FieldValue.serverTimestamp(),
        'wallet': {
          'balance': 1000000.0, // Khởi tạo 1 triệu VND
          'currency': 'VND',
          'is_locked': false,
        },
        // Chỉ khởi tạo bank_account nếu là phụ huynh
        if (role == 'parent') 'bank_account': {
          'account_number': 'BK-${DateTime.now().millisecondsSinceEpoch}',
          'bank_balance': 1000000.0,
          'is_verified': true,
        }
      };
      
      _logger.d('User data to save: $userData');
      
      await _firestore.collection('users').doc(uid).set(userData);
      
      _logger.i('✅ Firestore sync completed successfully!');
      _logger.i('💰 Wallet initialized with 1,000,000 VND');
      if (role == 'parent') {
        _logger.i('🏦 Bank account created for parent');
      }
      
      return credential;
    } on FirebaseAuthException catch (e) {
      _logger.e('❌ Firebase Auth Error: ${e.code} - ${e.message}');
      rethrow;
    } on FirebaseException catch (e) {
      _logger.e('❌ Firestore Error: ${e.code} - ${e.message}');
      rethrow;
    } catch (e, stackTrace) {
      _logger.e('❌ Unexpected error during sign up', error: e, stackTrace: stackTrace);
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
}