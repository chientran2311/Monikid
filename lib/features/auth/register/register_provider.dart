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

import 'register_state.dart';

part 'register_provider.g.dart';

@riverpod
class Register extends _$Register {
  late final AuthRepository _authRepository;
  late final Logger _logger;
  late final AppLocalStorage _localStorage;

  @override
  RegisterState build() {
    _authRepository = ref.read(authRepositoryProvider);
    _logger = getIt<Logger>();
    _localStorage = getIt<AppLocalStorage>();
    return const RegisterState();
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  void reset() {
    state = const RegisterState();
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
        errorMessage: 'Please complete all required fields.',
      );
      return;
    }

    final emailError = _validateEmail(trimmedEmail);
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

    final fullNameError = _validateFullName(trimmedFullName);
    if (fullNameError != null) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: fullNameError,
      );
      return;
    }

    final phoneError = _validatePhone(trimmedPhone);
    if (phoneError != null) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: phoneError,
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
      await ref.read(authSessionProvider.notifier).ensureAuthenticatedSession();
      await _localStorage.writeBool(
        key: StorageKeys.hasSignedInBefore,
        value: true,
      );
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
        return 'This email address is already registered.';
      case 'weak-password':
        return 'Password is too weak. Please use at least 6 characters.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      default:
        return e.message ?? 'An unexpected system error occurred.';
    }
  }

  String? _validateEmail(String value) {
    final emailRegex = RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  String? _validatePassword(String value) {
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    return null;
  }

  String? _validateFullName(String value) {
    if (value.length < 2) {
      return 'Full name must be at least 2 characters long.';
    }
    if (value.length > 50) {
      return 'Full name must be 50 characters or fewer.';
    }
    return null;
  }

  String? _validatePhone(String value) {
    if (value.isEmpty) {
      return null;
    }

    final phoneRegex = RegExp(r'^(0|\+84)\d{9,10}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number.';
    }

    return null;
  }
}
