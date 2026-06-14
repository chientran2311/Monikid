import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:monikid/core/config/storage_keys.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/storage/local_storage.dart';
import 'package:monikid/features/auth/auth_field_validator.dart';
import 'package:monikid/features/auth/auth_status.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/models/entities/auth/params/auth_param.dart';
import 'package:monikid/repositories/auth/auth_repository.dart';

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

  void validateEmail(String value) {
    state = state.copyWith(
      emailError: AuthFieldValidator.email(value),
      errorMessage: null,
    );
  }

  void validateUsername(String value) {
    state = state.copyWith(
      usernameError: AuthFieldValidator.username(value),
      errorMessage: null,
    );
  }

  void validatePassword(String value) {
    state = state.copyWith(
      passwordError: AuthFieldValidator.password(value),
      errorMessage: null,
    );
  }

  void validateConfirmPassword(String confirm, String password) {
    state = state.copyWith(
      confirmPasswordError: AuthFieldValidator.confirmPassword(confirm, password),
      errorMessage: null,
    );
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    required String role,
  }) async {
    if (state.hasFieldErrors) return;

    final trimmedEmail = email.trim();
    final trimmedFullName = fullName.trim();

    state = state.copyWith(status: AuthStatus.isLoading, errorMessage: null);

    _logger.i('Register provider signing up $trimmedEmail');
    final result = await _authRepository.signUp(
      SignUpParam(
        email: trimmedEmail,
        password: password,
        fullName: trimmedFullName,
        role: role,
      ),
    );

    if (result.isFailure) {
      _logger.e('Register provider error: ${result.error}');
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: result.error!.message,
      );
      return;
    }

    await ref.read(authSessionProvider.notifier).ensureAuthenticatedSession();
    await _localStorage.writeBool(
      key: StorageKeys.hasSignedInBefore,
      value: true,
    );
  }


}
