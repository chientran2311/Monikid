// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'receipt_ocr_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReceiptOcrResult {

 String get rawText; int? get amountMinor; DateTime? get transactionDate; String? get merchantName; double? get confidence;
/// Create a copy of ReceiptOcrResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiptOcrResultCopyWith<ReceiptOcrResult> get copyWith => _$ReceiptOcrResultCopyWithImpl<ReceiptOcrResult>(this as ReceiptOcrResult, _$identity);

  /// Serializes this ReceiptOcrResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiptOcrResult&&(identical(other.rawText, rawText) || other.rawText == rawText)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor)&&(identical(other.transactionDate, transactionDate) || other.transactionDate == transactionDate)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rawText,amountMinor,transactionDate,merchantName,confidence);

@override
String toString() {
  return 'ReceiptOcrResult(rawText: $rawText, amountMinor: $amountMinor, transactionDate: $transactionDate, merchantName: $merchantName, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class $ReceiptOcrResultCopyWith<$Res>  {
  factory $ReceiptOcrResultCopyWith(ReceiptOcrResult value, $Res Function(ReceiptOcrResult) _then) = _$ReceiptOcrResultCopyWithImpl;
@useResult
$Res call({
 String rawText, int? amountMinor, DateTime? transactionDate, String? merchantName, double? confidence
});




}
/// @nodoc
class _$ReceiptOcrResultCopyWithImpl<$Res>
    implements $ReceiptOcrResultCopyWith<$Res> {
  _$ReceiptOcrResultCopyWithImpl(this._self, this._then);

  final ReceiptOcrResult _self;
  final $Res Function(ReceiptOcrResult) _then;

/// Create a copy of ReceiptOcrResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rawText = null,Object? amountMinor = freezed,Object? transactionDate = freezed,Object? merchantName = freezed,Object? confidence = freezed,}) {
  return _then(_self.copyWith(
rawText: null == rawText ? _self.rawText : rawText // ignore: cast_nullable_to_non_nullable
as String,amountMinor: freezed == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int?,transactionDate: freezed == transactionDate ? _self.transactionDate : transactionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,merchantName: freezed == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String?,confidence: freezed == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ReceiptOcrResult implements ReceiptOcrResult {
  const _ReceiptOcrResult({required this.rawText, this.amountMinor, this.transactionDate, this.merchantName, this.confidence});
  factory _ReceiptOcrResult.fromJson(Map<String, dynamic> json) => _$ReceiptOcrResultFromJson(json);

@override final  String rawText;
@override final  int? amountMinor;
@override final  DateTime? transactionDate;
@override final  String? merchantName;
@override final  double? confidence;

/// Create a copy of ReceiptOcrResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReceiptOcrResultCopyWith<_ReceiptOcrResult> get copyWith => __$ReceiptOcrResultCopyWithImpl<_ReceiptOcrResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReceiptOcrResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReceiptOcrResult&&(identical(other.rawText, rawText) || other.rawText == rawText)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor)&&(identical(other.transactionDate, transactionDate) || other.transactionDate == transactionDate)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rawText,amountMinor,transactionDate,merchantName,confidence);

@override
String toString() {
  return 'ReceiptOcrResult(rawText: $rawText, amountMinor: $amountMinor, transactionDate: $transactionDate, merchantName: $merchantName, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class _$ReceiptOcrResultCopyWith<$Res> implements $ReceiptOcrResultCopyWith<$Res> {
  factory _$ReceiptOcrResultCopyWith(_ReceiptOcrResult value, $Res Function(_ReceiptOcrResult) _then) = __$ReceiptOcrResultCopyWithImpl;
@override @useResult
$Res call({
 String rawText, int? amountMinor, DateTime? transactionDate, String? merchantName, double? confidence
});




}
/// @nodoc
class __$ReceiptOcrResultCopyWithImpl<$Res>
    implements _$ReceiptOcrResultCopyWith<$Res> {
  __$ReceiptOcrResultCopyWithImpl(this._self, this._then);

  final _ReceiptOcrResult _self;
  final $Res Function(_ReceiptOcrResult) _then;

/// Create a copy of ReceiptOcrResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rawText = null,Object? amountMinor = freezed,Object? transactionDate = freezed,Object? merchantName = freezed,Object? confidence = freezed,}) {
  return _then(_ReceiptOcrResult(
rawText: null == rawText ? _self.rawText : rawText // ignore: cast_nullable_to_non_nullable
as String,amountMinor: freezed == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int?,transactionDate: freezed == transactionDate ? _self.transactionDate : transactionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,merchantName: freezed == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String?,confidence: freezed == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
