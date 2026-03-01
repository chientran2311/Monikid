// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 're_enter_pin_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReEnterPINState {

 String get pinCodeHash; String get currentPin; ReEnterPINCodeStatus get status; bool get isLoading; bool get isSuccess; bool get hasError;
/// Create a copy of ReEnterPINState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReEnterPINStateCopyWith<ReEnterPINState> get copyWith => _$ReEnterPINStateCopyWithImpl<ReEnterPINState>(this as ReEnterPINState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReEnterPINState&&(identical(other.pinCodeHash, pinCodeHash) || other.pinCodeHash == pinCodeHash)&&(identical(other.currentPin, currentPin) || other.currentPin == currentPin)&&(identical(other.status, status) || other.status == status)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.hasError, hasError) || other.hasError == hasError));
}


@override
int get hashCode => Object.hash(runtimeType,pinCodeHash,currentPin,status,isLoading,isSuccess,hasError);

@override
String toString() {
  return 'ReEnterPINState(pinCodeHash: $pinCodeHash, currentPin: $currentPin, status: $status, isLoading: $isLoading, isSuccess: $isSuccess, hasError: $hasError)';
}


}

/// @nodoc
abstract mixin class $ReEnterPINStateCopyWith<$Res>  {
  factory $ReEnterPINStateCopyWith(ReEnterPINState value, $Res Function(ReEnterPINState) _then) = _$ReEnterPINStateCopyWithImpl;
@useResult
$Res call({
 String pinCodeHash, String currentPin, ReEnterPINCodeStatus status, bool isLoading, bool isSuccess, bool hasError
});




}
/// @nodoc
class _$ReEnterPINStateCopyWithImpl<$Res>
    implements $ReEnterPINStateCopyWith<$Res> {
  _$ReEnterPINStateCopyWithImpl(this._self, this._then);

  final ReEnterPINState _self;
  final $Res Function(ReEnterPINState) _then;

/// Create a copy of ReEnterPINState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pinCodeHash = null,Object? currentPin = null,Object? status = null,Object? isLoading = null,Object? isSuccess = null,Object? hasError = null,}) {
  return _then(_self.copyWith(
pinCodeHash: null == pinCodeHash ? _self.pinCodeHash : pinCodeHash // ignore: cast_nullable_to_non_nullable
as String,currentPin: null == currentPin ? _self.currentPin : currentPin // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReEnterPINCodeStatus,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _ReEnterPINState extends ReEnterPINState {
  const _ReEnterPINState({required this.pinCodeHash, this.currentPin = '', this.status = ReEnterPINCodeStatus.initial, this.isLoading = false, this.isSuccess = false, this.hasError = false}): super._();
  

@override final  String pinCodeHash;
@override@JsonKey() final  String currentPin;
@override@JsonKey() final  ReEnterPINCodeStatus status;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSuccess;
@override@JsonKey() final  bool hasError;

/// Create a copy of ReEnterPINState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReEnterPINStateCopyWith<_ReEnterPINState> get copyWith => __$ReEnterPINStateCopyWithImpl<_ReEnterPINState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReEnterPINState&&(identical(other.pinCodeHash, pinCodeHash) || other.pinCodeHash == pinCodeHash)&&(identical(other.currentPin, currentPin) || other.currentPin == currentPin)&&(identical(other.status, status) || other.status == status)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.hasError, hasError) || other.hasError == hasError));
}


@override
int get hashCode => Object.hash(runtimeType,pinCodeHash,currentPin,status,isLoading,isSuccess,hasError);

@override
String toString() {
  return 'ReEnterPINState(pinCodeHash: $pinCodeHash, currentPin: $currentPin, status: $status, isLoading: $isLoading, isSuccess: $isSuccess, hasError: $hasError)';
}


}

/// @nodoc
abstract mixin class _$ReEnterPINStateCopyWith<$Res> implements $ReEnterPINStateCopyWith<$Res> {
  factory _$ReEnterPINStateCopyWith(_ReEnterPINState value, $Res Function(_ReEnterPINState) _then) = __$ReEnterPINStateCopyWithImpl;
@override @useResult
$Res call({
 String pinCodeHash, String currentPin, ReEnterPINCodeStatus status, bool isLoading, bool isSuccess, bool hasError
});




}
/// @nodoc
class __$ReEnterPINStateCopyWithImpl<$Res>
    implements _$ReEnterPINStateCopyWith<$Res> {
  __$ReEnterPINStateCopyWithImpl(this._self, this._then);

  final _ReEnterPINState _self;
  final $Res Function(_ReEnterPINState) _then;

/// Create a copy of ReEnterPINState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pinCodeHash = null,Object? currentPin = null,Object? status = null,Object? isLoading = null,Object? isSuccess = null,Object? hasError = null,}) {
  return _then(_ReEnterPINState(
pinCodeHash: null == pinCodeHash ? _self.pinCodeHash : pinCodeHash // ignore: cast_nullable_to_non_nullable
as String,currentPin: null == currentPin ? _self.currentPin : currentPin // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReEnterPINCodeStatus,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
