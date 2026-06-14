import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_param.freezed.dart';
part 'auth_param.g.dart';

@freezed
abstract class SignInParam with _$SignInParam {
  const factory SignInParam({required String email, required String password}) =
      _SignInParam;

  factory SignInParam.fromJson(Map<String, dynamic> json) =>
      _$SignInParamFromJson(json);
}

@freezed
abstract class SignUpParam with _$SignUpParam {
  const factory SignUpParam({
    required String email,
    required String password,
    required String fullName,
    required String role,
  }) = _SignUpParam;

  factory SignUpParam.fromJson(Map<String, dynamic> json) =>
      _$SignUpParamFromJson(json);
}

@freezed
abstract class ResetPasswordParam with _$ResetPasswordParam {
  const factory ResetPasswordParam({required String email}) =
      _ResetPasswordParam;

  factory ResetPasswordParam.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordParamFromJson(json);
}
