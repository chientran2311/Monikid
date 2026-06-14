// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegisterState {

 AuthStatus get status; String? get errorMessage; AuthFieldError get emailError; AuthFieldError get usernameError; AuthFieldError get passwordError; AuthFieldError get confirmPasswordError;
/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterStateCopyWith<RegisterState> get copyWith => _$RegisterStateCopyWithImpl<RegisterState>(this as RegisterState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.usernameError, usernameError) || other.usernameError == usernameError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.confirmPasswordError, confirmPasswordError) || other.confirmPasswordError == confirmPasswordError));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,emailError,usernameError,passwordError,confirmPasswordError);

@override
String toString() {
  return 'RegisterState(status: $status, errorMessage: $errorMessage, emailError: $emailError, usernameError: $usernameError, passwordError: $passwordError, confirmPasswordError: $confirmPasswordError)';
}


}

/// @nodoc
abstract mixin class $RegisterStateCopyWith<$Res>  {
  factory $RegisterStateCopyWith(RegisterState value, $Res Function(RegisterState) _then) = _$RegisterStateCopyWithImpl;
@useResult
$Res call({
 AuthStatus status, String? errorMessage, AuthFieldError emailError, AuthFieldError usernameError, AuthFieldError passwordError, AuthFieldError confirmPasswordError
});




}
/// @nodoc
class _$RegisterStateCopyWithImpl<$Res>
    implements $RegisterStateCopyWith<$Res> {
  _$RegisterStateCopyWithImpl(this._self, this._then);

  final RegisterState _self;
  final $Res Function(RegisterState) _then;

/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorMessage = freezed,Object? emailError = null,Object? usernameError = null,Object? passwordError = null,Object? confirmPasswordError = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuthStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,emailError: null == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as AuthFieldError,usernameError: null == usernameError ? _self.usernameError : usernameError // ignore: cast_nullable_to_non_nullable
as AuthFieldError,passwordError: null == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as AuthFieldError,confirmPasswordError: null == confirmPasswordError ? _self.confirmPasswordError : confirmPasswordError // ignore: cast_nullable_to_non_nullable
as AuthFieldError,
  ));
}

}


/// @nodoc


class _RegisterState extends RegisterState {
  const _RegisterState({this.status = AuthStatus.initial, this.errorMessage, this.emailError = AuthFieldError.none, this.usernameError = AuthFieldError.none, this.passwordError = AuthFieldError.none, this.confirmPasswordError = AuthFieldError.none}): super._();
  

@override@JsonKey() final  AuthStatus status;
@override final  String? errorMessage;
@override@JsonKey() final  AuthFieldError emailError;
@override@JsonKey() final  AuthFieldError usernameError;
@override@JsonKey() final  AuthFieldError passwordError;
@override@JsonKey() final  AuthFieldError confirmPasswordError;

/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterStateCopyWith<_RegisterState> get copyWith => __$RegisterStateCopyWithImpl<_RegisterState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.usernameError, usernameError) || other.usernameError == usernameError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.confirmPasswordError, confirmPasswordError) || other.confirmPasswordError == confirmPasswordError));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,emailError,usernameError,passwordError,confirmPasswordError);

@override
String toString() {
  return 'RegisterState(status: $status, errorMessage: $errorMessage, emailError: $emailError, usernameError: $usernameError, passwordError: $passwordError, confirmPasswordError: $confirmPasswordError)';
}


}

/// @nodoc
abstract mixin class _$RegisterStateCopyWith<$Res> implements $RegisterStateCopyWith<$Res> {
  factory _$RegisterStateCopyWith(_RegisterState value, $Res Function(_RegisterState) _then) = __$RegisterStateCopyWithImpl;
@override @useResult
$Res call({
 AuthStatus status, String? errorMessage, AuthFieldError emailError, AuthFieldError usernameError, AuthFieldError passwordError, AuthFieldError confirmPasswordError
});




}
/// @nodoc
class __$RegisterStateCopyWithImpl<$Res>
    implements _$RegisterStateCopyWith<$Res> {
  __$RegisterStateCopyWithImpl(this._self, this._then);

  final _RegisterState _self;
  final $Res Function(_RegisterState) _then;

/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorMessage = freezed,Object? emailError = null,Object? usernameError = null,Object? passwordError = null,Object? confirmPasswordError = null,}) {
  return _then(_RegisterState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuthStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,emailError: null == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as AuthFieldError,usernameError: null == usernameError ? _self.usernameError : usernameError // ignore: cast_nullable_to_non_nullable
as AuthFieldError,passwordError: null == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as AuthFieldError,confirmPasswordError: null == confirmPasswordError ? _self.confirmPasswordError : confirmPasswordError // ignore: cast_nullable_to_non_nullable
as AuthFieldError,
  ));
}


}

// dart format on
