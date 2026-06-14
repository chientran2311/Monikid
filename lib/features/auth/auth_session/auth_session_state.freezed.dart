// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_session_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthSessionState {

 AuthStatus get status; User? get firebaseUser; UserModel? get account; PinVerificationStatus get pinVerificationStatus; String? get errorMessage;// Whether a PIN hash exists in secure storage for this user.
// Populated when auth resolves; used by the router to route correctly
// if the user ends up on an auth screen while already authenticated.
 bool get hasPinCode;
/// Create a copy of AuthSessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthSessionStateCopyWith<AuthSessionState> get copyWith => _$AuthSessionStateCopyWithImpl<AuthSessionState>(this as AuthSessionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthSessionState&&(identical(other.status, status) || other.status == status)&&(identical(other.firebaseUser, firebaseUser) || other.firebaseUser == firebaseUser)&&(identical(other.account, account) || other.account == account)&&(identical(other.pinVerificationStatus, pinVerificationStatus) || other.pinVerificationStatus == pinVerificationStatus)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.hasPinCode, hasPinCode) || other.hasPinCode == hasPinCode));
}


@override
int get hashCode => Object.hash(runtimeType,status,firebaseUser,account,pinVerificationStatus,errorMessage,hasPinCode);

@override
String toString() {
  return 'AuthSessionState(status: $status, firebaseUser: $firebaseUser, account: $account, pinVerificationStatus: $pinVerificationStatus, errorMessage: $errorMessage, hasPinCode: $hasPinCode)';
}


}

/// @nodoc
abstract mixin class $AuthSessionStateCopyWith<$Res>  {
  factory $AuthSessionStateCopyWith(AuthSessionState value, $Res Function(AuthSessionState) _then) = _$AuthSessionStateCopyWithImpl;
@useResult
$Res call({
 AuthStatus status, User? firebaseUser, UserModel? account, PinVerificationStatus pinVerificationStatus, String? errorMessage, bool hasPinCode
});


$UserModelCopyWith<$Res>? get account;

}
/// @nodoc
class _$AuthSessionStateCopyWithImpl<$Res>
    implements $AuthSessionStateCopyWith<$Res> {
  _$AuthSessionStateCopyWithImpl(this._self, this._then);

  final AuthSessionState _self;
  final $Res Function(AuthSessionState) _then;

/// Create a copy of AuthSessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? firebaseUser = freezed,Object? account = freezed,Object? pinVerificationStatus = null,Object? errorMessage = freezed,Object? hasPinCode = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuthStatus,firebaseUser: freezed == firebaseUser ? _self.firebaseUser : firebaseUser // ignore: cast_nullable_to_non_nullable
as User?,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as UserModel?,pinVerificationStatus: null == pinVerificationStatus ? _self.pinVerificationStatus : pinVerificationStatus // ignore: cast_nullable_to_non_nullable
as PinVerificationStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,hasPinCode: null == hasPinCode ? _self.hasPinCode : hasPinCode // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of AuthSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res>? get account {
    if (_self.account == null) {
    return null;
  }

  return $UserModelCopyWith<$Res>(_self.account!, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}


/// @nodoc


class _AuthSessionState extends AuthSessionState {
  const _AuthSessionState({this.status = AuthStatus.initial, this.firebaseUser, this.account, this.pinVerificationStatus = PinVerificationStatus.unknown, this.errorMessage, this.hasPinCode = false}): super._();
  

@override@JsonKey() final  AuthStatus status;
@override final  User? firebaseUser;
@override final  UserModel? account;
@override@JsonKey() final  PinVerificationStatus pinVerificationStatus;
@override final  String? errorMessage;
// Whether a PIN hash exists in secure storage for this user.
// Populated when auth resolves; used by the router to route correctly
// if the user ends up on an auth screen while already authenticated.
@override@JsonKey() final  bool hasPinCode;

/// Create a copy of AuthSessionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthSessionStateCopyWith<_AuthSessionState> get copyWith => __$AuthSessionStateCopyWithImpl<_AuthSessionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthSessionState&&(identical(other.status, status) || other.status == status)&&(identical(other.firebaseUser, firebaseUser) || other.firebaseUser == firebaseUser)&&(identical(other.account, account) || other.account == account)&&(identical(other.pinVerificationStatus, pinVerificationStatus) || other.pinVerificationStatus == pinVerificationStatus)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.hasPinCode, hasPinCode) || other.hasPinCode == hasPinCode));
}


@override
int get hashCode => Object.hash(runtimeType,status,firebaseUser,account,pinVerificationStatus,errorMessage,hasPinCode);

@override
String toString() {
  return 'AuthSessionState(status: $status, firebaseUser: $firebaseUser, account: $account, pinVerificationStatus: $pinVerificationStatus, errorMessage: $errorMessage, hasPinCode: $hasPinCode)';
}


}

/// @nodoc
abstract mixin class _$AuthSessionStateCopyWith<$Res> implements $AuthSessionStateCopyWith<$Res> {
  factory _$AuthSessionStateCopyWith(_AuthSessionState value, $Res Function(_AuthSessionState) _then) = __$AuthSessionStateCopyWithImpl;
@override @useResult
$Res call({
 AuthStatus status, User? firebaseUser, UserModel? account, PinVerificationStatus pinVerificationStatus, String? errorMessage, bool hasPinCode
});


@override $UserModelCopyWith<$Res>? get account;

}
/// @nodoc
class __$AuthSessionStateCopyWithImpl<$Res>
    implements _$AuthSessionStateCopyWith<$Res> {
  __$AuthSessionStateCopyWithImpl(this._self, this._then);

  final _AuthSessionState _self;
  final $Res Function(_AuthSessionState) _then;

/// Create a copy of AuthSessionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? firebaseUser = freezed,Object? account = freezed,Object? pinVerificationStatus = null,Object? errorMessage = freezed,Object? hasPinCode = null,}) {
  return _then(_AuthSessionState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuthStatus,firebaseUser: freezed == firebaseUser ? _self.firebaseUser : firebaseUser // ignore: cast_nullable_to_non_nullable
as User?,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as UserModel?,pinVerificationStatus: null == pinVerificationStatus ? _self.pinVerificationStatus : pinVerificationStatus // ignore: cast_nullable_to_non_nullable
as PinVerificationStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,hasPinCode: null == hasPinCode ? _self.hasPinCode : hasPinCode // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of AuthSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res>? get account {
    if (_self.account == null) {
    return null;
  }

  return $UserModelCopyWith<$Res>(_self.account!, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}

// dart format on
