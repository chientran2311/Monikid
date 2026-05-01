// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_scan_bill_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeScanBillState {

 HomeScanBillStatus get status; TransactionAiResult? get transactionAiResult; TransactionImageSelection? get scannedImage; String? get errorMessage;
/// Create a copy of HomeScanBillState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeScanBillStateCopyWith<HomeScanBillState> get copyWith => _$HomeScanBillStateCopyWithImpl<HomeScanBillState>(this as HomeScanBillState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeScanBillState&&(identical(other.status, status) || other.status == status)&&(identical(other.transactionAiResult, transactionAiResult) || other.transactionAiResult == transactionAiResult)&&(identical(other.scannedImage, scannedImage) || other.scannedImage == scannedImage)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,transactionAiResult,scannedImage,errorMessage);

@override
String toString() {
  return 'HomeScanBillState(status: $status, transactionAiResult: $transactionAiResult, scannedImage: $scannedImage, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $HomeScanBillStateCopyWith<$Res>  {
  factory $HomeScanBillStateCopyWith(HomeScanBillState value, $Res Function(HomeScanBillState) _then) = _$HomeScanBillStateCopyWithImpl;
@useResult
$Res call({
 HomeScanBillStatus status, TransactionAiResult? transactionAiResult, TransactionImageSelection? scannedImage, String? errorMessage
});


$TransactionAiResultCopyWith<$Res>? get transactionAiResult;

}
/// @nodoc
class _$HomeScanBillStateCopyWithImpl<$Res>
    implements $HomeScanBillStateCopyWith<$Res> {
  _$HomeScanBillStateCopyWithImpl(this._self, this._then);

  final HomeScanBillState _self;
  final $Res Function(HomeScanBillState) _then;

/// Create a copy of HomeScanBillState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? transactionAiResult = freezed,Object? scannedImage = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HomeScanBillStatus,transactionAiResult: freezed == transactionAiResult ? _self.transactionAiResult : transactionAiResult // ignore: cast_nullable_to_non_nullable
as TransactionAiResult?,scannedImage: freezed == scannedImage ? _self.scannedImage : scannedImage // ignore: cast_nullable_to_non_nullable
as TransactionImageSelection?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of HomeScanBillState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionAiResultCopyWith<$Res>? get transactionAiResult {
    if (_self.transactionAiResult == null) {
    return null;
  }

  return $TransactionAiResultCopyWith<$Res>(_self.transactionAiResult!, (value) {
    return _then(_self.copyWith(transactionAiResult: value));
  });
}
}


/// @nodoc


class _HomeScanBillState extends HomeScanBillState {
  const _HomeScanBillState({this.status = HomeScanBillStatus.idle, this.transactionAiResult, this.scannedImage, this.errorMessage}): super._();
  

@override@JsonKey() final  HomeScanBillStatus status;
@override final  TransactionAiResult? transactionAiResult;
@override final  TransactionImageSelection? scannedImage;
@override final  String? errorMessage;

/// Create a copy of HomeScanBillState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeScanBillStateCopyWith<_HomeScanBillState> get copyWith => __$HomeScanBillStateCopyWithImpl<_HomeScanBillState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeScanBillState&&(identical(other.status, status) || other.status == status)&&(identical(other.transactionAiResult, transactionAiResult) || other.transactionAiResult == transactionAiResult)&&(identical(other.scannedImage, scannedImage) || other.scannedImage == scannedImage)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,transactionAiResult,scannedImage,errorMessage);

@override
String toString() {
  return 'HomeScanBillState(status: $status, transactionAiResult: $transactionAiResult, scannedImage: $scannedImage, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$HomeScanBillStateCopyWith<$Res> implements $HomeScanBillStateCopyWith<$Res> {
  factory _$HomeScanBillStateCopyWith(_HomeScanBillState value, $Res Function(_HomeScanBillState) _then) = __$HomeScanBillStateCopyWithImpl;
@override @useResult
$Res call({
 HomeScanBillStatus status, TransactionAiResult? transactionAiResult, TransactionImageSelection? scannedImage, String? errorMessage
});


@override $TransactionAiResultCopyWith<$Res>? get transactionAiResult;

}
/// @nodoc
class __$HomeScanBillStateCopyWithImpl<$Res>
    implements _$HomeScanBillStateCopyWith<$Res> {
  __$HomeScanBillStateCopyWithImpl(this._self, this._then);

  final _HomeScanBillState _self;
  final $Res Function(_HomeScanBillState) _then;

/// Create a copy of HomeScanBillState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? transactionAiResult = freezed,Object? scannedImage = freezed,Object? errorMessage = freezed,}) {
  return _then(_HomeScanBillState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HomeScanBillStatus,transactionAiResult: freezed == transactionAiResult ? _self.transactionAiResult : transactionAiResult // ignore: cast_nullable_to_non_nullable
as TransactionAiResult?,scannedImage: freezed == scannedImage ? _self.scannedImage : scannedImage // ignore: cast_nullable_to_non_nullable
as TransactionImageSelection?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of HomeScanBillState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionAiResultCopyWith<$Res>? get transactionAiResult {
    if (_self.transactionAiResult == null) {
    return null;
  }

  return $TransactionAiResultCopyWith<$Res>(_self.transactionAiResult!, (value) {
    return _then(_self.copyWith(transactionAiResult: value));
  });
}
}

// dart format on
