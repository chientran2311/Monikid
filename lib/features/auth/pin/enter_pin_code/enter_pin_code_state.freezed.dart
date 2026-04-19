// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'enter_pin_code_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EnterPINCodeState {

 String get currentPin; EnterPINCodeStatus get status; bool get isLoading; int get failedCount; DateTime? get lockedUntil; int get remainingLockSeconds; String? get errorMessage;
/// Create a copy of EnterPINCodeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EnterPINCodeStateCopyWith<EnterPINCodeState> get copyWith => _$EnterPINCodeStateCopyWithImpl<EnterPINCodeState>(this as EnterPINCodeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EnterPINCodeState&&(identical(other.currentPin, currentPin) || other.currentPin == currentPin)&&(identical(other.status, status) || other.status == status)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.failedCount, failedCount) || other.failedCount == failedCount)&&(identical(other.lockedUntil, lockedUntil) || other.lockedUntil == lockedUntil)&&(identical(other.remainingLockSeconds, remainingLockSeconds) || other.remainingLockSeconds == remainingLockSeconds)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,currentPin,status,isLoading,failedCount,lockedUntil,remainingLockSeconds,errorMessage);

@override
String toString() {
  return 'EnterPINCodeState(currentPin: $currentPin, status: $status, isLoading: $isLoading, failedCount: $failedCount, lockedUntil: $lockedUntil, remainingLockSeconds: $remainingLockSeconds, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $EnterPINCodeStateCopyWith<$Res>  {
  factory $EnterPINCodeStateCopyWith(EnterPINCodeState value, $Res Function(EnterPINCodeState) _then) = _$EnterPINCodeStateCopyWithImpl;
@useResult
$Res call({
 String currentPin, EnterPINCodeStatus status, bool isLoading, int failedCount, DateTime? lockedUntil, int remainingLockSeconds, String? errorMessage
});




}
/// @nodoc
class _$EnterPINCodeStateCopyWithImpl<$Res>
    implements $EnterPINCodeStateCopyWith<$Res> {
  _$EnterPINCodeStateCopyWithImpl(this._self, this._then);

  final EnterPINCodeState _self;
  final $Res Function(EnterPINCodeState) _then;

/// Create a copy of EnterPINCodeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentPin = null,Object? status = null,Object? isLoading = null,Object? failedCount = null,Object? lockedUntil = freezed,Object? remainingLockSeconds = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
currentPin: null == currentPin ? _self.currentPin : currentPin // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EnterPINCodeStatus,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,failedCount: null == failedCount ? _self.failedCount : failedCount // ignore: cast_nullable_to_non_nullable
as int,lockedUntil: freezed == lockedUntil ? _self.lockedUntil : lockedUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,remainingLockSeconds: null == remainingLockSeconds ? _self.remainingLockSeconds : remainingLockSeconds // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _EnterPINCodeState extends EnterPINCodeState {
  const _EnterPINCodeState({this.currentPin = '', this.status = EnterPINCodeStatus.initial, this.isLoading = false, this.failedCount = 0, this.lockedUntil, this.remainingLockSeconds = 0, this.errorMessage}): super._();
  

@override@JsonKey() final  String currentPin;
@override@JsonKey() final  EnterPINCodeStatus status;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  int failedCount;
@override final  DateTime? lockedUntil;
@override@JsonKey() final  int remainingLockSeconds;
@override final  String? errorMessage;

/// Create a copy of EnterPINCodeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EnterPINCodeStateCopyWith<_EnterPINCodeState> get copyWith => __$EnterPINCodeStateCopyWithImpl<_EnterPINCodeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EnterPINCodeState&&(identical(other.currentPin, currentPin) || other.currentPin == currentPin)&&(identical(other.status, status) || other.status == status)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.failedCount, failedCount) || other.failedCount == failedCount)&&(identical(other.lockedUntil, lockedUntil) || other.lockedUntil == lockedUntil)&&(identical(other.remainingLockSeconds, remainingLockSeconds) || other.remainingLockSeconds == remainingLockSeconds)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,currentPin,status,isLoading,failedCount,lockedUntil,remainingLockSeconds,errorMessage);

@override
String toString() {
  return 'EnterPINCodeState(currentPin: $currentPin, status: $status, isLoading: $isLoading, failedCount: $failedCount, lockedUntil: $lockedUntil, remainingLockSeconds: $remainingLockSeconds, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$EnterPINCodeStateCopyWith<$Res> implements $EnterPINCodeStateCopyWith<$Res> {
  factory _$EnterPINCodeStateCopyWith(_EnterPINCodeState value, $Res Function(_EnterPINCodeState) _then) = __$EnterPINCodeStateCopyWithImpl;
@override @useResult
$Res call({
 String currentPin, EnterPINCodeStatus status, bool isLoading, int failedCount, DateTime? lockedUntil, int remainingLockSeconds, String? errorMessage
});




}
/// @nodoc
class __$EnterPINCodeStateCopyWithImpl<$Res>
    implements _$EnterPINCodeStateCopyWith<$Res> {
  __$EnterPINCodeStateCopyWithImpl(this._self, this._then);

  final _EnterPINCodeState _self;
  final $Res Function(_EnterPINCodeState) _then;

/// Create a copy of EnterPINCodeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentPin = null,Object? status = null,Object? isLoading = null,Object? failedCount = null,Object? lockedUntil = freezed,Object? remainingLockSeconds = null,Object? errorMessage = freezed,}) {
  return _then(_EnterPINCodeState(
currentPin: null == currentPin ? _self.currentPin : currentPin // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EnterPINCodeStatus,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,failedCount: null == failedCount ? _self.failedCount : failedCount // ignore: cast_nullable_to_non_nullable
as int,lockedUntil: freezed == lockedUntil ? _self.lockedUntil : lockedUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,remainingLockSeconds: null == remainingLockSeconds ? _self.remainingLockSeconds : remainingLockSeconds // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
