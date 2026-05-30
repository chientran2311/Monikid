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

  void validateEmail(String value) {
    state = state.copyWith(
      emailError: AuthFieldValidator.email(value),
      errorMessage: null,
    );
  }

  void validatePassword(String value) {
    state = state.copyWith(
      passwordError: AuthFieldValidator.password(value),
      errorMessage: null,
    );
  }

  Future<void> signIn({required String email, required String password}) async {
    if (state.hasFieldErrors) return;

    state = state.copyWith(status: AuthStatus.isLoading, errorMessage: null);

    _logger.i('Login provider signing in ${email.trim()}');
    final result = await _authRepository.signIn(
      SignInParam(email: email.trim(), password: password),
    );

    if (result.isFailure) {
      _logger.e('Login provider error: ${result.error}');
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
