import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/auth_field_error.dart';
import 'package:monikid/features/auth/auth_field_validator.dart';
import 'package:monikid/features/auth/auth_status.dart';
import 'package:monikid/models/entities/auth/params/auth_param.dart';
import 'package:monikid/repositories/auth/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'forgot_password_state.dart';

part 'forgot_password_provider.g.dart';

@riverpod
class ForgotPassword extends _$ForgotPassword {
  late final AuthRepository _authRepository;
  late final Logger _logger;

  @override
  ForgotPasswordState build() {
    _authRepository = ref.read(authRepositoryProvider);
    _logger = getIt<Logger>();
    return const ForgotPasswordState();
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  void validateEmail(String email) {
    final trimmedEmail = email.trim();
    final fieldError = AuthFieldValidator.email(trimmedEmail);
    state = state.copyWith(emailError: fieldError);
  }

  Future<void> submit(String email) async {
    final trimmedEmail = email.trim();
    final fieldError = AuthFieldValidator.email(trimmedEmail);
    if (fieldError != AuthFieldError.none) {
      state = state.copyWith(
        status: AuthStatus.error,
        emailError: fieldError,
      );
      return;
    }

    state = state.copyWith(
      status: AuthStatus.isLoading,
      errorMessage: null,
      emailError: AuthFieldError.none,
    );

    try {
      _logger.i('Sending password reset link for $trimmedEmail');
      await _authRepository.resetPassword(
        ResetPasswordParam(email: trimmedEmail),
      );
      state = state.copyWith(
        status: AuthStatus.success,
        step: ForgotPasswordStep.done,
      );
    } on FirebaseAuthException catch (e, stackTrace) {
      _logger.e(
        'Forgot password Firebase error',
        error: e,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.message ?? 'An unexpected system error occurred.',
      );
    } catch (e, stackTrace) {
      _logger.e(
        'Forgot password error',
        error: e,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }
}
