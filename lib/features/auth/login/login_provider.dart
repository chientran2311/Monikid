import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/utils/validators.dart';
import 'package:monikid/features/auth/auth_status.dart';
import 'package:monikid/models/entities/auth/params/auth_param.dart';
import 'package:monikid/repositories/auth/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'login_state.dart';

part 'login_provider.g.dart';

@riverpod
class Login extends _$Login {
  late final Logger _logger;
  late final AuthRepository _authRepository;

  @override
  LoginState build() {
    _logger = getIt<Logger>();
    _authRepository = getIt<AuthRepository>();
    return const LoginState();
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  Future<void> signIn({required String email, required String password}) async {
    final emailError = Validators.email(email);
    if (emailError != null) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: emailError,
      );
      return;
    }

    final passwordError = Validators.password(password);
    if (passwordError != null) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: passwordError,
      );
      return;
    }

    state = state.copyWith(
      status: AuthStatus.isLoading,
      errorMessage: null,
    );

    try {
      _logger.i('Login provider signing in ${email.trim()}');
      await _authRepository.signIn(
        SignInParam(email: email.trim(), password: password),
      );
      state = state.copyWith(status: AuthStatus.success);
    } on FirebaseAuthException catch (e, stackTrace) {
      _logger.e(
        'Login provider Firebase error',
        error: e,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: _mapFirebaseError(e),
      );
    } catch (e, stackTrace) {
      _logger.e('Login provider error', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'Không tìm thấy người dùng với email này.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Email hoặc mật khẩu không chính xác.';
      case 'invalid-email':
        return 'Địa chỉ email không hợp lệ.';
      case 'user-disabled':
        return 'Tài khoản này đã bị vô hiệu hóa.';
      case 'too-many-requests':
        return 'Quá nhiều lần đăng nhập thất bại. Vui lòng thử lại sau.';
      default:
        return e.message ?? 'Đã xảy ra lỗi hệ thống.';
    }
  }
}
