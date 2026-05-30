// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginState {

 AuthStatus get status; String? get errorMessage; AuthFieldError get emailError; AuthFieldError get passwordError;
/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginStateCopyWith<LoginState> get copyWith => _$LoginStateCopyWithImpl<LoginState>(this as LoginState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,emailError,passwordError);

@override
String toString() {
  return 'LoginState(status: $status, errorMessage: $errorMessage, emailError: $emailError, passwordError: $passwordError)';
}


}

/// @nodoc
abstract mixin class $LoginStateCopyWith<$Res>  {
  factory $LoginStateCopyWith(LoginState value, $Res Function(LoginState) _then) = _$LoginStateCopyWithImpl;
@useResult
$Res call({
 AuthStatus status, String? errorMessage, AuthFieldError emailError, AuthFieldError passwordError
});




}
/// @nodoc
class _$LoginStateCopyWithImpl<$Res>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._self, this._then);

  final LoginState _self;
  final $Res Function(LoginState) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorMessage = freezed,Object? emailError = null,Object? passwordError = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuthStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,emailError: null == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as AuthFieldError,passwordError: null == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as AuthFieldError,
  ));
}

}


/// @nodoc


class _LoginState extends LoginState {
  const _LoginState({this.status = AuthStatus.initial, this.errorMessage, this.emailError = AuthFieldError.none, this.passwordError = AuthFieldError.none}): super._();
  

@override@JsonKey() final  AuthStatus status;
@override final  String? errorMessage;
@override@JsonKey() final  AuthFieldError emailError;
@override@JsonKey() final  AuthFieldError passwordError;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginStateCopyWith<_LoginState> get copyWith => __$LoginStateCopyWithImpl<_LoginState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,emailError,passwordError);

@override
String toString() {
  return 'LoginState(status: $status, errorMessage: $errorMessage, emailError: $emailError, passwordError: $passwordError)';
}


}

/// @nodoc
abstract mixin class _$LoginStateCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$LoginStateCopyWith(_LoginState value, $Res Function(_LoginState) _then) = __$LoginStateCopyWithImpl;
@override @useResult
$Res call({
 AuthStatus status, String? errorMessage, AuthFieldError emailError, AuthFieldError passwordError
});




}
/// @nodoc
class __$LoginStateCopyWithImpl<$Res>
    implements _$LoginStateCopyWith<$Res> {
  __$LoginStateCopyWithImpl(this._self, this._then);

  final _LoginState _self;
  final $Res Function(_LoginState) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorMessage = freezed,Object? emailError = null,Object? passwordError = null,}) {
  return _then(_LoginState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuthStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,emailError: null == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as AuthFieldError,passwordError: null == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as AuthFieldError,
  ));
}


}

// dart format on
