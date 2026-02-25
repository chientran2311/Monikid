// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_param.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignInParam {

 String get email; String get password; String get selectedRole;
/// Create a copy of SignInParam
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignInParamCopyWith<SignInParam> get copyWith => _$SignInParamCopyWithImpl<SignInParam>(this as SignInParam, _$identity);

  /// Serializes this SignInParam to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInParam&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.selectedRole, selectedRole) || other.selectedRole == selectedRole));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password,selectedRole);

@override
String toString() {
  return 'SignInParam(email: $email, password: $password, selectedRole: $selectedRole)';
}


}

/// @nodoc
abstract mixin class $SignInParamCopyWith<$Res>  {
  factory $SignInParamCopyWith(SignInParam value, $Res Function(SignInParam) _then) = _$SignInParamCopyWithImpl;
@useResult
$Res call({
 String email, String password, String selectedRole
});




}
/// @nodoc
class _$SignInParamCopyWithImpl<$Res>
    implements $SignInParamCopyWith<$Res> {
  _$SignInParamCopyWithImpl(this._self, this._then);

  final SignInParam _self;
  final $Res Function(SignInParam) _then;

/// Create a copy of SignInParam
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,Object? selectedRole = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,selectedRole: null == selectedRole ? _self.selectedRole : selectedRole // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SignInParam implements SignInParam {
  const _SignInParam({required this.email, required this.password, required this.selectedRole});
  factory _SignInParam.fromJson(Map<String, dynamic> json) => _$SignInParamFromJson(json);

@override final  String email;
@override final  String password;
@override final  String selectedRole;

/// Create a copy of SignInParam
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignInParamCopyWith<_SignInParam> get copyWith => __$SignInParamCopyWithImpl<_SignInParam>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignInParamToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignInParam&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.selectedRole, selectedRole) || other.selectedRole == selectedRole));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password,selectedRole);

@override
String toString() {
  return 'SignInParam(email: $email, password: $password, selectedRole: $selectedRole)';
}


}

/// @nodoc
abstract mixin class _$SignInParamCopyWith<$Res> implements $SignInParamCopyWith<$Res> {
  factory _$SignInParamCopyWith(_SignInParam value, $Res Function(_SignInParam) _then) = __$SignInParamCopyWithImpl;
@override @useResult
$Res call({
 String email, String password, String selectedRole
});




}
/// @nodoc
class __$SignInParamCopyWithImpl<$Res>
    implements _$SignInParamCopyWith<$Res> {
  __$SignInParamCopyWithImpl(this._self, this._then);

  final _SignInParam _self;
  final $Res Function(_SignInParam) _then;

/// Create a copy of SignInParam
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? selectedRole = null,}) {
  return _then(_SignInParam(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,selectedRole: null == selectedRole ? _self.selectedRole : selectedRole // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SignUpParam {

 String get email; String get password; String get fullName; String get phone; String get role;
/// Create a copy of SignUpParam
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpParamCopyWith<SignUpParam> get copyWith => _$SignUpParamCopyWithImpl<SignUpParam>(this as SignUpParam, _$identity);

  /// Serializes this SignUpParam to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpParam&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password,fullName,phone,role);

@override
String toString() {
  return 'SignUpParam(email: $email, password: $password, fullName: $fullName, phone: $phone, role: $role)';
}


}

/// @nodoc
abstract mixin class $SignUpParamCopyWith<$Res>  {
  factory $SignUpParamCopyWith(SignUpParam value, $Res Function(SignUpParam) _then) = _$SignUpParamCopyWithImpl;
@useResult
$Res call({
 String email, String password, String fullName, String phone, String role
});




}
/// @nodoc
class _$SignUpParamCopyWithImpl<$Res>
    implements $SignUpParamCopyWith<$Res> {
  _$SignUpParamCopyWithImpl(this._self, this._then);

  final SignUpParam _self;
  final $Res Function(SignUpParam) _then;

/// Create a copy of SignUpParam
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,Object? fullName = null,Object? phone = null,Object? role = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SignUpParam implements SignUpParam {
  const _SignUpParam({required this.email, required this.password, required this.fullName, required this.phone, required this.role});
  factory _SignUpParam.fromJson(Map<String, dynamic> json) => _$SignUpParamFromJson(json);

@override final  String email;
@override final  String password;
@override final  String fullName;
@override final  String phone;
@override final  String role;

/// Create a copy of SignUpParam
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignUpParamCopyWith<_SignUpParam> get copyWith => __$SignUpParamCopyWithImpl<_SignUpParam>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignUpParamToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignUpParam&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password,fullName,phone,role);

@override
String toString() {
  return 'SignUpParam(email: $email, password: $password, fullName: $fullName, phone: $phone, role: $role)';
}


}

/// @nodoc
abstract mixin class _$SignUpParamCopyWith<$Res> implements $SignUpParamCopyWith<$Res> {
  factory _$SignUpParamCopyWith(_SignUpParam value, $Res Function(_SignUpParam) _then) = __$SignUpParamCopyWithImpl;
@override @useResult
$Res call({
 String email, String password, String fullName, String phone, String role
});




}
/// @nodoc
class __$SignUpParamCopyWithImpl<$Res>
    implements _$SignUpParamCopyWith<$Res> {
  __$SignUpParamCopyWithImpl(this._self, this._then);

  final _SignUpParam _self;
  final $Res Function(_SignUpParam) _then;

/// Create a copy of SignUpParam
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? fullName = null,Object? phone = null,Object? role = null,}) {
  return _then(_SignUpParam(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ResetPasswordParam {

 String get email;
/// Create a copy of ResetPasswordParam
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResetPasswordParamCopyWith<ResetPasswordParam> get copyWith => _$ResetPasswordParamCopyWithImpl<ResetPasswordParam>(this as ResetPasswordParam, _$identity);

  /// Serializes this ResetPasswordParam to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordParam&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'ResetPasswordParam(email: $email)';
}


}

/// @nodoc
abstract mixin class $ResetPasswordParamCopyWith<$Res>  {
  factory $ResetPasswordParamCopyWith(ResetPasswordParam value, $Res Function(ResetPasswordParam) _then) = _$ResetPasswordParamCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$ResetPasswordParamCopyWithImpl<$Res>
    implements $ResetPasswordParamCopyWith<$Res> {
  _$ResetPasswordParamCopyWithImpl(this._self, this._then);

  final ResetPasswordParam _self;
  final $Res Function(ResetPasswordParam) _then;

/// Create a copy of ResetPasswordParam
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ResetPasswordParam implements ResetPasswordParam {
  const _ResetPasswordParam({required this.email});
  factory _ResetPasswordParam.fromJson(Map<String, dynamic> json) => _$ResetPasswordParamFromJson(json);

@override final  String email;

/// Create a copy of ResetPasswordParam
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResetPasswordParamCopyWith<_ResetPasswordParam> get copyWith => __$ResetPasswordParamCopyWithImpl<_ResetPasswordParam>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResetPasswordParamToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetPasswordParam&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'ResetPasswordParam(email: $email)';
}


}

/// @nodoc
abstract mixin class _$ResetPasswordParamCopyWith<$Res> implements $ResetPasswordParamCopyWith<$Res> {
  factory _$ResetPasswordParamCopyWith(_ResetPasswordParam value, $Res Function(_ResetPasswordParam) _then) = __$ResetPasswordParamCopyWithImpl;
@override @useResult
$Res call({
 String email
});




}
/// @nodoc
class __$ResetPasswordParamCopyWithImpl<$Res>
    implements _$ResetPasswordParamCopyWith<$Res> {
  __$ResetPasswordParamCopyWithImpl(this._self, this._then);

  final _ResetPasswordParam _self;
  final $Res Function(_ResetPasswordParam) _then;

/// Create a copy of ResetPasswordParam
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(_ResetPasswordParam(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
