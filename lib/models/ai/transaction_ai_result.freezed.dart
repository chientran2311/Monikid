// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_ai_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransactionAiResult {

@JsonKey(name: 'amount_minor') int get amountMinor;@JsonKey(name: 'category') String get categoryKey;@JsonKey(name: 'description') String get note;@JsonKey(name: 'transaction_date') String get transactionDate;
/// Create a copy of TransactionAiResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionAiResultCopyWith<TransactionAiResult> get copyWith => _$TransactionAiResultCopyWithImpl<TransactionAiResult>(this as TransactionAiResult, _$identity);

  /// Serializes this TransactionAiResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionAiResult&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor)&&(identical(other.categoryKey, categoryKey) || other.categoryKey == categoryKey)&&(identical(other.note, note) || other.note == note)&&(identical(other.transactionDate, transactionDate) || other.transactionDate == transactionDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amountMinor,categoryKey,note,transactionDate);

@override
String toString() {
  return 'TransactionAiResult(amountMinor: $amountMinor, categoryKey: $categoryKey, note: $note, transactionDate: $transactionDate)';
}


}

/// @nodoc
abstract mixin class $TransactionAiResultCopyWith<$Res>  {
  factory $TransactionAiResultCopyWith(TransactionAiResult value, $Res Function(TransactionAiResult) _then) = _$TransactionAiResultCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'amount_minor') int amountMinor,@JsonKey(name: 'category') String categoryKey,@JsonKey(name: 'description') String note,@JsonKey(name: 'transaction_date') String transactionDate
});




}
/// @nodoc
class _$TransactionAiResultCopyWithImpl<$Res>
    implements $TransactionAiResultCopyWith<$Res> {
  _$TransactionAiResultCopyWithImpl(this._self, this._then);

  final TransactionAiResult _self;
  final $Res Function(TransactionAiResult) _then;

/// Create a copy of TransactionAiResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amountMinor = null,Object? categoryKey = null,Object? note = null,Object? transactionDate = null,}) {
  return _then(_self.copyWith(
amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,categoryKey: null == categoryKey ? _self.categoryKey : categoryKey // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,transactionDate: null == transactionDate ? _self.transactionDate : transactionDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TransactionAiResult implements TransactionAiResult {
  const _TransactionAiResult({@JsonKey(name: 'amount_minor') required this.amountMinor, @JsonKey(name: 'category') required this.categoryKey, @JsonKey(name: 'description') required this.note, @JsonKey(name: 'transaction_date') required this.transactionDate});
  factory _TransactionAiResult.fromJson(Map<String, dynamic> json) => _$TransactionAiResultFromJson(json);

@override@JsonKey(name: 'amount_minor') final  int amountMinor;
@override@JsonKey(name: 'category') final  String categoryKey;
@override@JsonKey(name: 'description') final  String note;
@override@JsonKey(name: 'transaction_date') final  String transactionDate;

/// Create a copy of TransactionAiResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionAiResultCopyWith<_TransactionAiResult> get copyWith => __$TransactionAiResultCopyWithImpl<_TransactionAiResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionAiResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionAiResult&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor)&&(identical(other.categoryKey, categoryKey) || other.categoryKey == categoryKey)&&(identical(other.note, note) || other.note == note)&&(identical(other.transactionDate, transactionDate) || other.transactionDate == transactionDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amountMinor,categoryKey,note,transactionDate);

@override
String toString() {
  return 'TransactionAiResult(amountMinor: $amountMinor, categoryKey: $categoryKey, note: $note, transactionDate: $transactionDate)';
}


}

/// @nodoc
abstract mixin class _$TransactionAiResultCopyWith<$Res> implements $TransactionAiResultCopyWith<$Res> {
  factory _$TransactionAiResultCopyWith(_TransactionAiResult value, $Res Function(_TransactionAiResult) _then) = __$TransactionAiResultCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'amount_minor') int amountMinor,@JsonKey(name: 'category') String categoryKey,@JsonKey(name: 'description') String note,@JsonKey(name: 'transaction_date') String transactionDate
});




}
/// @nodoc
class __$TransactionAiResultCopyWithImpl<$Res>
    implements _$TransactionAiResultCopyWith<$Res> {
  __$TransactionAiResultCopyWithImpl(this._self, this._then);

  final _TransactionAiResult _self;
  final $Res Function(_TransactionAiResult) _then;

/// Create a copy of TransactionAiResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amountMinor = null,Object? categoryKey = null,Object? note = null,Object? transactionDate = null,}) {
  return _then(_TransactionAiResult(
amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,categoryKey: null == categoryKey ? _self.categoryKey : categoryKey // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,transactionDate: null == transactionDate ? _self.transactionDate : transactionDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
