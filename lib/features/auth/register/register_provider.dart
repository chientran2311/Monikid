import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/utils/validators.dart';
import 'package:monikid/features/auth/auth_status.dart';
import 'package:monikid/models/entities/auth/params/auth_param.dart';
import 'package:monikid/repositories/auth/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'register_state.dart';

part 'register_provider.g.dart';

@riverpod
class Register extends _$Register {
  late final AuthRepository _authRepository;
  late final Logger _logger;

  @override
  RegisterState build() {
    _authRepository = getIt<AuthRepository>();
    _logger = getIt<Logger>();
    return const RegisterState();
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String role,
  }) async {
    final trimmedFullName = fullName.trim();
    final trimmedEmail = email.trim();
    final trimmedPhone = phone.trim();

    if (trimmedFullName.isEmpty || trimmedEmail.isEmpty || password.isEmpty) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Vui lòng nhập đầy đủ thông tin bắt buộc.',
      );
      return;
    }

    final emailError = Validators.email(trimmedEmail);
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
      _logger.i('Register provider signing up $trimmedEmail');
      await _authRepository.signUp(
        SignUpParam(
          email: trimmedEmail,
          password: password,
          fullName: trimmedFullName,
          phone: trimmedPhone,
          role: role,
        ),
      );
      state = state.copyWith(status: AuthStatus.success);
    } on FirebaseAuthException catch (e, stackTrace) {
      _logger.e(
        'Register provider Firebase error',
        error: e,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: _mapFirebaseError(e),
      );
    } catch (e, stackTrace) {
      _logger.e('Register provider error', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'Email này đã được đăng ký.';
      case 'weak-password':
        return 'Mật khẩu quá yếu. Vui lòng sử dụng ít nhất 6 ký tự.';
      case 'invalid-email':
        return 'Địa chỉ email không hợp lệ.';
      default:
        return e.message ?? 'Đã xảy ra lỗi hệ thống.';
    }
  }
}
