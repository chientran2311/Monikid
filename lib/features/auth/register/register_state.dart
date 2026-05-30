import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:monikid/features/auth/auth_field_error.dart';
import 'package:monikid/features/auth/auth_status.dart';

part 'register_state.freezed.dart';

@freezed
abstract class RegisterState with _$RegisterState {
  const factory RegisterState({
    @Default(AuthStatus.initial) AuthStatus status,
    String? errorMessage,
    @Default(AuthFieldError.none) AuthFieldError emailError,
    @Default(AuthFieldError.none) AuthFieldError usernameError,
    @Default(AuthFieldError.none) AuthFieldError phoneError,
    @Default(AuthFieldError.none) AuthFieldError passwordError,
    @Default(AuthFieldError.none) AuthFieldError confirmPasswordError,
  }) = _RegisterState;

  const RegisterState._();

  bool get isLoading => status == AuthStatus.isLoading;
  bool get isSuccess => status == AuthStatus.success;
  bool get hasFieldErrors =>
      emailError != AuthFieldError.none ||
      usernameError != AuthFieldError.none ||
      phoneError != AuthFieldError.none ||
      passwordError != AuthFieldError.none ||
      confirmPasswordError != AuthFieldError.none;
}
