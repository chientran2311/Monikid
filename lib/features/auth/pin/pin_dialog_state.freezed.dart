// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pin_dialog_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PinDialogState {

 PinDialogMode get mode; String get expectedPin;// Dùng cho mode verify
 String get firstPin;// Lưu mã PIN lần 1 (cho mode setup)
 String get currentPin;// Mã PIN đang nhập
 bool get isConfirming;// Đang ở bước xác nhận lại (setup)
 bool get hasError;// Đang ở trạng thái lỗi (rung)
 bool get isSuccess;// Xử lý thành công
 bool get isLoading;// Đang xử lý
 bool get isPinCreated;
/// Create a copy of PinDialogState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PinDialogStateCopyWith<PinDialogState> get copyWith => _$PinDialogStateCopyWithImpl<PinDialogState>(this as PinDialogState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PinDialogState&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.expectedPin, expectedPin) || other.expectedPin == expectedPin)&&(identical(other.firstPin, firstPin) || other.firstPin == firstPin)&&(identical(other.currentPin, currentPin) || other.currentPin == currentPin)&&(identical(other.isConfirming, isConfirming) || other.isConfirming == isConfirming)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isPinCreated, isPinCreated) || other.isPinCreated == isPinCreated));
}


@override
int get hashCode => Object.hash(runtimeType,mode,expectedPin,firstPin,currentPin,isConfirming,hasError,isSuccess,isLoading,isPinCreated);

@override
String toString() {
  return 'PinDialogState(mode: $mode, expectedPin: $expectedPin, firstPin: $firstPin, currentPin: $currentPin, isConfirming: $isConfirming, hasError: $hasError, isSuccess: $isSuccess, isLoading: $isLoading, isPinCreated: $isPinCreated)';
}


}

/// @nodoc
abstract mixin class $PinDialogStateCopyWith<$Res>  {
  factory $PinDialogStateCopyWith(PinDialogState value, $Res Function(PinDialogState) _then) = _$PinDialogStateCopyWithImpl;
@useResult
$Res call({
 PinDialogMode mode, String expectedPin, String firstPin, String currentPin, bool isConfirming, bool hasError, bool isSuccess, bool isLoading, bool isPinCreated
});




}
/// @nodoc
class _$PinDialogStateCopyWithImpl<$Res>
    implements $PinDialogStateCopyWith<$Res> {
  _$PinDialogStateCopyWithImpl(this._self, this._then);

  final PinDialogState _self;
  final $Res Function(PinDialogState) _then;

/// Create a copy of PinDialogState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? expectedPin = null,Object? firstPin = null,Object? currentPin = null,Object? isConfirming = null,Object? hasError = null,Object? isSuccess = null,Object? isLoading = null,Object? isPinCreated = null,}) {
  return _then(_self.copyWith(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as PinDialogMode,expectedPin: null == expectedPin ? _self.expectedPin : expectedPin // ignore: cast_nullable_to_non_nullable
as String,firstPin: null == firstPin ? _self.firstPin : firstPin // ignore: cast_nullable_to_non_nullable
as String,currentPin: null == currentPin ? _self.currentPin : currentPin // ignore: cast_nullable_to_non_nullable
as String,isConfirming: null == isConfirming ? _self.isConfirming : isConfirming // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isPinCreated: null == isPinCreated ? _self.isPinCreated : isPinCreated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _PinDialogState implements PinDialogState {
  const _PinDialogState({required this.mode, this.expectedPin = '', this.firstPin = '', this.currentPin = '', this.isConfirming = false, this.hasError = false, this.isSuccess = false, this.isLoading = false, this.isPinCreated = false});
  

@override final  PinDialogMode mode;
@override@JsonKey() final  String expectedPin;
// Dùng cho mode verify
@override@JsonKey() final  String firstPin;
// Lưu mã PIN lần 1 (cho mode setup)
@override@JsonKey() final  String currentPin;
// Mã PIN đang nhập
@override@JsonKey() final  bool isConfirming;
// Đang ở bước xác nhận lại (setup)
@override@JsonKey() final  bool hasError;
// Đang ở trạng thái lỗi (rung)
@override@JsonKey() final  bool isSuccess;
// Xử lý thành công
@override@JsonKey() final  bool isLoading;
// Đang xử lý
@override@JsonKey() final  bool isPinCreated;

/// Create a copy of PinDialogState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PinDialogStateCopyWith<_PinDialogState> get copyWith => __$PinDialogStateCopyWithImpl<_PinDialogState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PinDialogState&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.expectedPin, expectedPin) || other.expectedPin == expectedPin)&&(identical(other.firstPin, firstPin) || other.firstPin == firstPin)&&(identical(other.currentPin, currentPin) || other.currentPin == currentPin)&&(identical(other.isConfirming, isConfirming) || other.isConfirming == isConfirming)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isPinCreated, isPinCreated) || other.isPinCreated == isPinCreated));
}


@override
int get hashCode => Object.hash(runtimeType,mode,expectedPin,firstPin,currentPin,isConfirming,hasError,isSuccess,isLoading,isPinCreated);

@override
String toString() {
  return 'PinDialogState(mode: $mode, expectedPin: $expectedPin, firstPin: $firstPin, currentPin: $currentPin, isConfirming: $isConfirming, hasError: $hasError, isSuccess: $isSuccess, isLoading: $isLoading, isPinCreated: $isPinCreated)';
}


}

/// @nodoc
abstract mixin class _$PinDialogStateCopyWith<$Res> implements $PinDialogStateCopyWith<$Res> {
  factory _$PinDialogStateCopyWith(_PinDialogState value, $Res Function(_PinDialogState) _then) = __$PinDialogStateCopyWithImpl;
@override @useResult
$Res call({
 PinDialogMode mode, String expectedPin, String firstPin, String currentPin, bool isConfirming, bool hasError, bool isSuccess, bool isLoading, bool isPinCreated
});




}
/// @nodoc
class __$PinDialogStateCopyWithImpl<$Res>
    implements _$PinDialogStateCopyWith<$Res> {
  __$PinDialogStateCopyWithImpl(this._self, this._then);

  final _PinDialogState _self;
  final $Res Function(_PinDialogState) _then;

/// Create a copy of PinDialogState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? expectedPin = null,Object? firstPin = null,Object? currentPin = null,Object? isConfirming = null,Object? hasError = null,Object? isSuccess = null,Object? isLoading = null,Object? isPinCreated = null,}) {
  return _then(_PinDialogState(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as PinDialogMode,expectedPin: null == expectedPin ? _self.expectedPin : expectedPin // ignore: cast_nullable_to_non_nullable
as String,firstPin: null == firstPin ? _self.firstPin : firstPin // ignore: cast_nullable_to_non_nullable
as String,currentPin: null == currentPin ? _self.currentPin : currentPin // ignore: cast_nullable_to_non_nullable
as String,isConfirming: null == isConfirming ? _self.isConfirming : isConfirming // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isPinCreated: null == isPinCreated ? _self.isPinCreated : isPinCreated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
