import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default('parent') String selectedRole,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _LoginState;
}
