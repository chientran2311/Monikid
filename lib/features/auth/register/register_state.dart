import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/features/auth/auth_status.dart';

part 'register_state.freezed.dart';

@freezed
abstract class RegisterState with _$RegisterState {
  const factory RegisterState({
    @Default(AuthStatus.initial) AuthStatus status,
    String? errorMessage,
  }) = _RegisterState;

  const RegisterState._();

  bool get isLoading => status == AuthStatus.isLoading;
  bool get isSuccess => status == AuthStatus.success;
}
