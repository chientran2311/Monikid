// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransactionModel {

 String get transactionId; String get userId; String? get familyId; int get amountMinor; String get currency; String get type; String get categoryKey; String get categoryLabel; String? get categoryIcon; String? get note; String? get source; String? get merchantName; String? get paymentMethod;@TimestampConverter() DateTime get dateTs;@TimestampConverter() DateTime? get createdAt;@TimestampConverter() DateTime? get updatedAt; bool? get ocrUsed; double? get ocrConfidence;
/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionModelCopyWith<TransactionModel> get copyWith => _$TransactionModelCopyWithImpl<TransactionModel>(this as TransactionModel, _$identity);

  /// Serializes this TransactionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionModel&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.familyId, familyId) || other.familyId == familyId)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.type, type) || other.type == type)&&(identical(other.categoryKey, categoryKey) || other.categoryKey == categoryKey)&&(identical(other.categoryLabel, categoryLabel) || other.categoryLabel == categoryLabel)&&(identical(other.categoryIcon, categoryIcon) || other.categoryIcon == categoryIcon)&&(identical(other.note, note) || other.note == note)&&(identical(other.source, source) || other.source == source)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.dateTs, dateTs) || other.dateTs == dateTs)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.ocrUsed, ocrUsed) || other.ocrUsed == ocrUsed)&&(identical(other.ocrConfidence, ocrConfidence) || other.ocrConfidence == ocrConfidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionId,userId,familyId,amountMinor,currency,type,categoryKey,categoryLabel,categoryIcon,note,source,merchantName,paymentMethod,dateTs,createdAt,updatedAt,ocrUsed,ocrConfidence);

@override
String toString() {
  return 'TransactionModel(transactionId: $transactionId, userId: $userId, familyId: $familyId, amountMinor: $amountMinor, currency: $currency, type: $type, categoryKey: $categoryKey, categoryLabel: $categoryLabel, categoryIcon: $categoryIcon, note: $note, source: $source, merchantName: $merchantName, paymentMethod: $paymentMethod, dateTs: $dateTs, createdAt: $createdAt, updatedAt: $updatedAt, ocrUsed: $ocrUsed, ocrConfidence: $ocrConfidence)';
}


}

/// @nodoc
abstract mixin class $TransactionModelCopyWith<$Res>  {
  factory $TransactionModelCopyWith(TransactionModel value, $Res Function(TransactionModel) _then) = _$TransactionModelCopyWithImpl;
@useResult
$Res call({
 String transactionId, String userId, String? familyId, int amountMinor, String currency, String type, String categoryKey, String categoryLabel, String? categoryIcon, String? note, String? source, String? merchantName, String? paymentMethod,@TimestampConverter() DateTime dateTs,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? updatedAt, bool? ocrUsed, double? ocrConfidence
});




}
/// @nodoc
class _$TransactionModelCopyWithImpl<$Res>
    implements $TransactionModelCopyWith<$Res> {
  _$TransactionModelCopyWithImpl(this._self, this._then);

  final TransactionModel _self;
  final $Res Function(TransactionModel) _then;

/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactionId = null,Object? userId = null,Object? familyId = freezed,Object? amountMinor = null,Object? currency = null,Object? type = null,Object? categoryKey = null,Object? categoryLabel = null,Object? categoryIcon = freezed,Object? note = freezed,Object? source = freezed,Object? merchantName = freezed,Object? paymentMethod = freezed,Object? dateTs = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? ocrUsed = freezed,Object? ocrConfidence = freezed,}) {
  return _then(_self.copyWith(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,familyId: freezed == familyId ? _self.familyId : familyId // ignore: cast_nullable_to_non_nullable
as String?,amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,categoryKey: null == categoryKey ? _self.categoryKey : categoryKey // ignore: cast_nullable_to_non_nullable
as String,categoryLabel: null == categoryLabel ? _self.categoryLabel : categoryLabel // ignore: cast_nullable_to_non_nullable
as String,categoryIcon: freezed == categoryIcon ? _self.categoryIcon : categoryIcon // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,merchantName: freezed == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,dateTs: null == dateTs ? _self.dateTs : dateTs // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,ocrUsed: freezed == ocrUsed ? _self.ocrUsed : ocrUsed // ignore: cast_nullable_to_non_nullable
as bool?,ocrConfidence: freezed == ocrConfidence ? _self.ocrConfidence : ocrConfidence // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TransactionModel extends TransactionModel {
  const _TransactionModel({required this.transactionId, required this.userId, this.familyId, required this.amountMinor, this.currency = 'VND', required this.type, required this.categoryKey, required this.categoryLabel, this.categoryIcon, this.note, this.source, this.merchantName, this.paymentMethod, @TimestampConverter() required this.dateTs, @TimestampConverter() this.createdAt, @TimestampConverter() this.updatedAt, this.ocrUsed, this.ocrConfidence}): super._();
  factory _TransactionModel.fromJson(Map<String, dynamic> json) => _$TransactionModelFromJson(json);

@override final  String transactionId;
@override final  String userId;
@override final  String? familyId;
@override final  int amountMinor;
@override@JsonKey() final  String currency;
@override final  String type;
@override final  String categoryKey;
@override final  String categoryLabel;
@override final  String? categoryIcon;
@override final  String? note;
@override final  String? source;
@override final  String? merchantName;
@override final  String? paymentMethod;
@override@TimestampConverter() final  DateTime dateTs;
@override@TimestampConverter() final  DateTime? createdAt;
@override@TimestampConverter() final  DateTime? updatedAt;
@override final  bool? ocrUsed;
@override final  double? ocrConfidence;

/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionModelCopyWith<_TransactionModel> get copyWith => __$TransactionModelCopyWithImpl<_TransactionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionModel&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.familyId, familyId) || other.familyId == familyId)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.type, type) || other.type == type)&&(identical(other.categoryKey, categoryKey) || other.categoryKey == categoryKey)&&(identical(other.categoryLabel, categoryLabel) || other.categoryLabel == categoryLabel)&&(identical(other.categoryIcon, categoryIcon) || other.categoryIcon == categoryIcon)&&(identical(other.note, note) || other.note == note)&&(identical(other.source, source) || other.source == source)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.dateTs, dateTs) || other.dateTs == dateTs)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.ocrUsed, ocrUsed) || other.ocrUsed == ocrUsed)&&(identical(other.ocrConfidence, ocrConfidence) || other.ocrConfidence == ocrConfidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionId,userId,familyId,amountMinor,currency,type,categoryKey,categoryLabel,categoryIcon,note,source,merchantName,paymentMethod,dateTs,createdAt,updatedAt,ocrUsed,ocrConfidence);

@override
String toString() {
  return 'TransactionModel(transactionId: $transactionId, userId: $userId, familyId: $familyId, amountMinor: $amountMinor, currency: $currency, type: $type, categoryKey: $categoryKey, categoryLabel: $categoryLabel, categoryIcon: $categoryIcon, note: $note, source: $source, merchantName: $merchantName, paymentMethod: $paymentMethod, dateTs: $dateTs, createdAt: $createdAt, updatedAt: $updatedAt, ocrUsed: $ocrUsed, ocrConfidence: $ocrConfidence)';
}


}

/// @nodoc
abstract mixin class _$TransactionModelCopyWith<$Res> implements $TransactionModelCopyWith<$Res> {
  factory _$TransactionModelCopyWith(_TransactionModel value, $Res Function(_TransactionModel) _then) = __$TransactionModelCopyWithImpl;
@override @useResult
$Res call({
 String transactionId, String userId, String? familyId, int amountMinor, String currency, String type, String categoryKey, String categoryLabel, String? categoryIcon, String? note, String? source, String? merchantName, String? paymentMethod,@TimestampConverter() DateTime dateTs,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? updatedAt, bool? ocrUsed, double? ocrConfidence
});




}
/// @nodoc
class __$TransactionModelCopyWithImpl<$Res>
    implements _$TransactionModelCopyWith<$Res> {
  __$TransactionModelCopyWithImpl(this._self, this._then);

  final _TransactionModel _self;
  final $Res Function(_TransactionModel) _then;

/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactionId = null,Object? userId = null,Object? familyId = freezed,Object? amountMinor = null,Object? currency = null,Object? type = null,Object? categoryKey = null,Object? categoryLabel = null,Object? categoryIcon = freezed,Object? note = freezed,Object? source = freezed,Object? merchantName = freezed,Object? paymentMethod = freezed,Object? dateTs = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? ocrUsed = freezed,Object? ocrConfidence = freezed,}) {
  return _then(_TransactionModel(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,familyId: freezed == familyId ? _self.familyId : familyId // ignore: cast_nullable_to_non_nullable
as String?,amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,categoryKey: null == categoryKey ? _self.categoryKey : categoryKey // ignore: cast_nullable_to_non_nullable
as String,categoryLabel: null == categoryLabel ? _self.categoryLabel : categoryLabel // ignore: cast_nullable_to_non_nullable
as String,categoryIcon: freezed == categoryIcon ? _self.categoryIcon : categoryIcon // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,merchantName: freezed == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,dateTs: null == dateTs ? _self.dateTs : dateTs // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,ocrUsed: freezed == ocrUsed ? _self.ocrUsed : ocrUsed // ignore: cast_nullable_to_non_nullable
as bool?,ocrConfidence: freezed == ocrConfidence ? _self.ocrConfidence : ocrConfidence // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
