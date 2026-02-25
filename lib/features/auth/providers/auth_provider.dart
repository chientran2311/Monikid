import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

import 'auth_state.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/domain/params/auth_param.dart';
import 'package:monikid/repositories/auth/auth_repository.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  StreamSubscription<User?>? _authSubscription;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late final AuthRepository _authRepository;
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 50,
      colors: true,
      printEmojis: true,
    ),
  );

  @override
  AppAuthState build() {
    // Initialize repository via GetIt
    _authRepository = getIt<AuthRepository>();

    // Cleanup khi provider bị dispose
    ref.onDispose(() {
      _authSubscription?.cancel();
    });

    // Khởi tạo và lắng nghe auth changes
    _initAuthListener();

    // Check session hiện tại (async)
    _checkCurrentSession();

    return const AppAuthState(status: AuthStatus.initial);
  }

  /// Kiểm tra session hiện tại khi khởi động (Async)
  Future<void> _checkCurrentSession() async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        // Fetch role
        final role = await _authRepository.getUserRole(currentUser.uid);
        state = AppAuthState(
          status: AuthStatus.authenticated,
          user: currentUser,
          userRole: role,
        );
      } else {
        state = const AppAuthState(status: AuthStatus.unauthenticated);
      }
    } catch (e) {
      // Firebase chưa khởi tạo hoặc lỗi mạng
      state = const AppAuthState(status: AuthStatus.initial);
    }
  }

  /// Lắng nghe thay đổi auth state từ Firebase
  void _initAuthListener() {
    try {
      _authSubscription = _firebaseAuth.authStateChanges().listen((
        User? user,
      ) async {
        if (user != null) {
          // Fetch the role when session restores via stream
          final role = await _authRepository.getUserRole(user.uid);
          state = AppAuthState(
            status: AuthStatus.authenticated,
            user: user,
            userRole: role,
          );
        } else {
          state = const AppAuthState(status: AuthStatus.unauthenticated);
        }
      });
    } catch (e) {
      // Firebase chưa khởi tạo - bỏ qua
    }
  }

  // ============================================================================
  // PUBLIC METHODS
  // ============================================================================

  /// Đăng nhập với email và password thông qua Param
  Future<void> validateUser(SignInParam param) async {
    // Set loading state
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      _logger.i('🔐 Auth Provider: Validating user ${param.email}');

      final response = await _authRepository.signIn(param);

      _logger.i('✅ Auth Provider: Validation successful');

      state = AppAuthState(
        status: AuthStatus.authenticated,
        user: response.user,
        userRole: response.role,
        isLoading: false,
      );
    } catch (e, stackTrace) {
      _logger.e(
        '❌ Auth Provider: Validation error',
        error: e,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        isLoading: false,
        errorMessage: e is FirebaseAuthException
            ? _getFriendlyErrorMessage(e)
            : e.toString().replaceAll('Exception: ', ''),
      );
      rethrow;
    }
  }

  /// Đăng ký người dùng mới với Param
  Future<void> registerUser(SignUpParam param) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      _logger.i('📝 Auth Provider: Registering user ${param.email}');

      // Gọi repository để tạo auth account VÀ sync Firestore
      final response = await _authRepository.signUp(param);

      _logger.i('✅ Auth Provider: Registration successful');

      state = AppAuthState(
        status: AuthStatus.authenticated,
        user: response.user,
        userRole: response.role,
        isLoading: false,
      );
    } catch (e, stackTrace) {
      _logger.e(
        '❌ Auth Provider: Registration error',
        error: e,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        isLoading: false,
        errorMessage: e is FirebaseAuthException
            ? _getFriendlyErrorMessage(e)
            : e.toString().replaceAll('Exception: ', ''),
      );
      rethrow;
    }
  }

  String _getFriendlyErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'Không tìm thấy người dùng với email này.';
      case 'wrong-password':
        return 'Mật khẩu không chính xác.';
      case 'invalid-email':
        return 'Địa chỉ email không hợp lệ.';
      case 'user-disabled':
        return 'Tài khoản này đã bị vô hiệu hóa.';
      case 'email-already-in-use':
        return 'Email này đã được đăng ký.';
      case 'weak-password':
        return 'Mật khẩu quá yếu. Vui lòng sử dụng ít nhất 6 ký tự.';
      default:
        return e.message ?? 'Đã xảy ra lỗi hệ thống.';
    }
  }

  /// Đăng xuất
  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);

    try {
      _logger.i('🚪 Auth Provider: Signing out');
      await _authRepository.signOut();
      state = const AppAuthState(status: AuthStatus.unauthenticated);
      _logger.i('✅ Auth Provider: Sign out successful');
    } catch (e, stackTrace) {
      _logger.e(
        '❌ Auth Provider: Sign out failed',
        error: e,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
      rethrow;
    }
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  /// Reset state về initial (dùng khi cần re-check auth)
  void reset() {
    state = const AppAuthState(status: AuthStatus.initial);
    _checkCurrentSession();
  }

  /// Gửi email đặt lại mật khẩu bằng Param
  Future<void> resetUserPassword(ResetPasswordParam param) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      _logger.i('📧 Auth Provider: Sending password reset for ${param.email}');
      await _authRepository.resetPassword(param);
      _logger.i('✅ Auth Provider: Password reset email sent');
      state = state.copyWith(isLoading: false);
    } catch (e, stackTrace) {
      _logger.e(
        '❌ Auth Provider: Reset password error',
        error: e,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
      rethrow;
    }
  }
}
