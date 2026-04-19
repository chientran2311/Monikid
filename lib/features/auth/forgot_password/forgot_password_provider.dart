import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
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

  Future<void> submit(String email) async {
    final trimmedEmail = email.trim();
    final emailError = _validateEmail(trimmedEmail);
    if (emailError != null) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: emailError,
      );
      return;
    }

    state = state.copyWith(
      status: AuthStatus.isLoading,
      errorMessage: null,
    );

    try {
      _logger.i(
        'Forgot password provider sending reset email for $trimmedEmail',
      );
      await _authRepository.resetPassword(
        ResetPasswordParam(email: trimmedEmail),
      );
      state = state.copyWith(status: AuthStatus.success);
    } on FirebaseAuthException catch (e, stackTrace) {
      _logger.e(
        'Forgot password provider Firebase error',
        error: e,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.message ?? 'An unexpected system error occurred.',
      );
    } catch (e, stackTrace) {
      _logger.e(
        'Forgot password provider error',
        error: e,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter your email address.';
    }

    final emailRegex = RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address.';
    }

    return null;
  }
}
