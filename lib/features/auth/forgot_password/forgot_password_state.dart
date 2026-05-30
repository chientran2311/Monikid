import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/features/auth/auth_field_error.dart';
import 'package:monikid/features/auth/auth_status.dart';

part 'forgot_password_state.freezed.dart';

enum ForgotPasswordStep { email, done }

@freezed
abstract class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState({
    @Default(AuthStatus.initial) AuthStatus status,
    String? errorMessage,
    @Default(AuthFieldError.none) AuthFieldError emailError,
    @Default(ForgotPasswordStep.email) ForgotPasswordStep step,
  }) = _ForgotPasswordState;

  const ForgotPasswordState._();

  bool get isLoading => status == AuthStatus.isLoading;
  bool get isDone => step == ForgotPasswordStep.done;
}
