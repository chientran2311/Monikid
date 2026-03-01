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

 String get expectedPinHash; String get currentPin; EnterPINCodeStatus get status; bool get isLoading; bool get isSuccess; bool get hasError;
/// Create a copy of EnterPINCodeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EnterPINCodeStateCopyWith<EnterPINCodeState> get copyWith => _$EnterPINCodeStateCopyWithImpl<EnterPINCodeState>(this as EnterPINCodeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EnterPINCodeState&&(identical(other.expectedPinHash, expectedPinHash) || other.expectedPinHash == expectedPinHash)&&(identical(other.currentPin, currentPin) || other.currentPin == currentPin)&&(identical(other.status, status) || other.status == status)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.hasError, hasError) || other.hasError == hasError));
}


@override
int get hashCode => Object.hash(runtimeType,expectedPinHash,currentPin,status,isLoading,isSuccess,hasError);

@override
String toString() {
  return 'EnterPINCodeState(expectedPinHash: $expectedPinHash, currentPin: $currentPin, status: $status, isLoading: $isLoading, isSuccess: $isSuccess, hasError: $hasError)';
}


}

/// @nodoc
abstract mixin class $EnterPINCodeStateCopyWith<$Res>  {
  factory $EnterPINCodeStateCopyWith(EnterPINCodeState value, $Res Function(EnterPINCodeState) _then) = _$EnterPINCodeStateCopyWithImpl;
@useResult
$Res call({
 String expectedPinHash, String currentPin, EnterPINCodeStatus status, bool isLoading, bool isSuccess, bool hasError
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
@pragma('vm:prefer-inline') @override $Res call({Object? expectedPinHash = null,Object? currentPin = null,Object? status = null,Object? isLoading = null,Object? isSuccess = null,Object? hasError = null,}) {
  return _then(_self.copyWith(
expectedPinHash: null == expectedPinHash ? _self.expectedPinHash : expectedPinHash // ignore: cast_nullable_to_non_nullable
as String,currentPin: null == currentPin ? _self.currentPin : currentPin // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EnterPINCodeStatus,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _EnterPINCodeState extends EnterPINCodeState {
  const _EnterPINCodeState({required this.expectedPinHash, this.currentPin = '', this.status = EnterPINCodeStatus.initial, this.isLoading = false, this.isSuccess = false, this.hasError = false}): super._();
  

@override final  String expectedPinHash;
@override@JsonKey() final  String currentPin;
@override@JsonKey() final  EnterPINCodeStatus status;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSuccess;
@override@JsonKey() final  bool hasError;

/// Create a copy of EnterPINCodeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EnterPINCodeStateCopyWith<_EnterPINCodeState> get copyWith => __$EnterPINCodeStateCopyWithImpl<_EnterPINCodeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EnterPINCodeState&&(identical(other.expectedPinHash, expectedPinHash) || other.expectedPinHash == expectedPinHash)&&(identical(other.currentPin, currentPin) || other.currentPin == currentPin)&&(identical(other.status, status) || other.status == status)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.hasError, hasError) || other.hasError == hasError));
}


@override
int get hashCode => Object.hash(runtimeType,expectedPinHash,currentPin,status,isLoading,isSuccess,hasError);

@override
String toString() {
  return 'EnterPINCodeState(expectedPinHash: $expectedPinHash, currentPin: $currentPin, status: $status, isLoading: $isLoading, isSuccess: $isSuccess, hasError: $hasError)';
}


}

/// @nodoc
abstract mixin class _$EnterPINCodeStateCopyWith<$Res> implements $EnterPINCodeStateCopyWith<$Res> {
  factory _$EnterPINCodeStateCopyWith(_EnterPINCodeState value, $Res Function(_EnterPINCodeState) _then) = __$EnterPINCodeStateCopyWithImpl;
@override @useResult
$Res call({
 String expectedPinHash, String currentPin, EnterPINCodeStatus status, bool isLoading, bool isSuccess, bool hasError
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
@override @pragma('vm:prefer-inline') $Res call({Object? expectedPinHash = null,Object? currentPin = null,Object? status = null,Object? isLoading = null,Object? isSuccess = null,Object? hasError = null,}) {
  return _then(_EnterPINCodeState(
expectedPinHash: null == expectedPinHash ? _self.expectedPinHash : expectedPinHash // ignore: cast_nullable_to_non_nullable
as String,currentPin: null == currentPin ? _self.currentPin : currentPin // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EnterPINCodeStatus,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
