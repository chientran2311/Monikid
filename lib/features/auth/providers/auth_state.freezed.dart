// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppAuthState {

 AuthStatus get status; User? get user; String? get errorMessage; bool get isLoading; bool get isFirstTime;
/// Create a copy of AppAuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppAuthStateCopyWith<AppAuthState> get copyWith => _$AppAuthStateCopyWithImpl<AppAuthState>(this as AppAuthState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppAuthState&&(identical(other.status, status) || other.status == status)&&(identical(other.user, user) || other.user == user)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isFirstTime, isFirstTime) || other.isFirstTime == isFirstTime));
}


@override
int get hashCode => Object.hash(runtimeType,status,user,errorMessage,isLoading,isFirstTime);

@override
String toString() {
  return 'AppAuthState(status: $status, user: $user, errorMessage: $errorMessage, isLoading: $isLoading, isFirstTime: $isFirstTime)';
}


}

/// @nodoc
abstract mixin class $AppAuthStateCopyWith<$Res>  {
  factory $AppAuthStateCopyWith(AppAuthState value, $Res Function(AppAuthState) _then) = _$AppAuthStateCopyWithImpl;
@useResult
$Res call({
 AuthStatus status, User? user, String? errorMessage, bool isLoading, bool isFirstTime
});




}
/// @nodoc
class _$AppAuthStateCopyWithImpl<$Res>
    implements $AppAuthStateCopyWith<$Res> {
  _$AppAuthStateCopyWithImpl(this._self, this._then);

  final AppAuthState _self;
  final $Res Function(AppAuthState) _then;

/// Create a copy of AppAuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? user = freezed,Object? errorMessage = freezed,Object? isLoading = null,Object? isFirstTime = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuthStatus,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isFirstTime: null == isFirstTime ? _self.isFirstTime : isFirstTime // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _AppAuthState extends AppAuthState {
  const _AppAuthState({this.status = AuthStatus.initial, this.user, this.errorMessage, this.isLoading = false, this.isFirstTime = false}): super._();
  

@override@JsonKey() final  AuthStatus status;
@override final  User? user;
@override final  String? errorMessage;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isFirstTime;

/// Create a copy of AppAuthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppAuthStateCopyWith<_AppAuthState> get copyWith => __$AppAuthStateCopyWithImpl<_AppAuthState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppAuthState&&(identical(other.status, status) || other.status == status)&&(identical(other.user, user) || other.user == user)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isFirstTime, isFirstTime) || other.isFirstTime == isFirstTime));
}


@override
int get hashCode => Object.hash(runtimeType,status,user,errorMessage,isLoading,isFirstTime);

@override
String toString() {
  return 'AppAuthState(status: $status, user: $user, errorMessage: $errorMessage, isLoading: $isLoading, isFirstTime: $isFirstTime)';
}


}

/// @nodoc
abstract mixin class _$AppAuthStateCopyWith<$Res> implements $AppAuthStateCopyWith<$Res> {
  factory _$AppAuthStateCopyWith(_AppAuthState value, $Res Function(_AppAuthState) _then) = __$AppAuthStateCopyWithImpl;
@override @useResult
$Res call({
 AuthStatus status, User? user, String? errorMessage, bool isLoading, bool isFirstTime
});




}
/// @nodoc
class __$AppAuthStateCopyWithImpl<$Res>
    implements _$AppAuthStateCopyWith<$Res> {
  __$AppAuthStateCopyWithImpl(this._self, this._then);

  final _AppAuthState _self;
  final $Res Function(_AppAuthState) _then;

/// Create a copy of AppAuthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? user = freezed,Object? errorMessage = freezed,Object? isLoading = null,Object? isFirstTime = null,}) {
  return _then(_AppAuthState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuthStatus,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isFirstTime: null == isFirstTime ? _self.isFirstTime : isFirstTime // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
