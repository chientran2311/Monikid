import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/features/auth/auth_status.dart';

part 'forgot_password_state.freezed.dart';

@freezed
abstract class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState({
    @Default(AuthStatus.initial) AuthStatus status,
    String? errorMessage,
  }) = _ForgotPasswordState;

  const ForgotPasswordState._();

  bool get isLoading => status == AuthStatus.isLoading;
  bool get isSuccess => status == AuthStatus.success;
}
