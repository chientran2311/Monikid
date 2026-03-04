// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignInParam _$SignInParamFromJson(Map<String, dynamic> json) => _SignInParam(
  email: json['email'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$SignInParamToJson(_SignInParam instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};

_SignUpParam _$SignUpParamFromJson(Map<String, dynamic> json) => _SignUpParam(
  email: json['email'] as String,
  password: json['password'] as String,
  fullName: json['fullName'] as String,
  phone: json['phone'] as String,
  role: json['role'] as String,
);

Map<String, dynamic> _$SignUpParamToJson(_SignUpParam instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'fullName': instance.fullName,
      'phone': instance.phone,
      'role': instance.role,
    };

_ResetPasswordParam _$ResetPasswordParamFromJson(Map<String, dynamic> json) =>
    _ResetPasswordParam(email: json['email'] as String);

Map<String, dynamic> _$ResetPasswordParamToJson(_ResetPasswordParam instance) =>
    <String, dynamic>{'email': instance.email};
