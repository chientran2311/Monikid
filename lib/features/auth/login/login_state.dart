import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:monikid/features/auth/auth_field_error.dart';
import 'package:monikid/features/auth/auth_status.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default(AuthStatus.initial) AuthStatus status,
    String? errorMessage,
    @Default(AuthFieldError.none) AuthFieldError emailError,
    @Default(AuthFieldError.none) AuthFieldError passwordError,
  }) = _LoginState;

  const LoginState._();

  bool get isLoading => status == AuthStatus.isLoading;
  bool get isSuccess => status == AuthStatus.success;
  bool get hasFieldErrors =>
      emailError != AuthFieldError.none || passwordError != AuthFieldError.none;
}
