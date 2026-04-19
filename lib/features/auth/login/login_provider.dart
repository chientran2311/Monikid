import 'package:firebase_auth/firebase_auth.dart';
import 'package:monikid/core/config/storage_keys.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/storage/local_storage.dart';
import 'package:monikid/features/auth/auth_status.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/models/entities/auth/params/auth_param.dart';
import 'package:monikid/repositories/auth/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'login_state.dart';

part 'login_provider.g.dart';

@riverpod
class Login extends _$Login {
  late final Logger _logger;
  late final AuthRepository _authRepository;
  late final AppLocalStorage _localStorage;

  @override
  LoginState build() {
    _logger = getIt<Logger>();
    _authRepository = ref.read(authRepositoryProvider);
    _localStorage = getIt<AppLocalStorage>();
    return const LoginState();
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  void reset() {
    state = const LoginState();
  }

  Future<void> signIn({required String email, required String password}) async {
    final emailError = _validateEmail(email);
    if (emailError != null) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: emailError,
      );
      return;
    }

    final passwordError = _validatePassword(password);
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
      await ref.read(authSessionProvider.notifier).ensureAuthenticatedSession();
      await _localStorage.writeBool(
        key: StorageKeys.hasSignedInBefore,
        value: true,
      );
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
        return 'No user was found for this email address.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'The email or password is incorrect.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many failed attempts. Please try again later.';
      default:
        return e.message ?? 'An unexpected system error occurred.';
    }
  }

  String? _validateEmail(String value) {
    final trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      return 'Please enter your email address.';
    }

    final emailRegex = RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(trimmedValue)) {
      return 'Please enter a valid email address.';
    }

    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter your password.';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }

    return null;
  }
}
