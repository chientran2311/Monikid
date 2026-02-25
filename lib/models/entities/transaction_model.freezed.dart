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

 String get transactionId; String get userId; double get amount;/// 'expense' or 'income'
 String get type; String get category; String? get categoryEmoji; String? get note; String? get source; String? get paymentMethod; String? get receiptImageUrl;@TimestampConverter() DateTime get date;@TimestampConverter() DateTime? get createdAt;@TimestampConverter() DateTime? get updatedAt; String? get location;
/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionModelCopyWith<TransactionModel> get copyWith => _$TransactionModelCopyWithImpl<TransactionModel>(this as TransactionModel, _$identity);

  /// Serializes this TransactionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionModel&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type)&&(identical(other.category, category) || other.category == category)&&(identical(other.categoryEmoji, categoryEmoji) || other.categoryEmoji == categoryEmoji)&&(identical(other.note, note) || other.note == note)&&(identical(other.source, source) || other.source == source)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.receiptImageUrl, receiptImageUrl) || other.receiptImageUrl == receiptImageUrl)&&(identical(other.date, date) || other.date == date)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionId,userId,amount,type,category,categoryEmoji,note,source,paymentMethod,receiptImageUrl,date,createdAt,updatedAt,location);

@override
String toString() {
  return 'TransactionModel(transactionId: $transactionId, userId: $userId, amount: $amount, type: $type, category: $category, categoryEmoji: $categoryEmoji, note: $note, source: $source, paymentMethod: $paymentMethod, receiptImageUrl: $receiptImageUrl, date: $date, createdAt: $createdAt, updatedAt: $updatedAt, location: $location)';
}


}

/// @nodoc
abstract mixin class $TransactionModelCopyWith<$Res>  {
  factory $TransactionModelCopyWith(TransactionModel value, $Res Function(TransactionModel) _then) = _$TransactionModelCopyWithImpl;
@useResult
$Res call({
 String transactionId, String userId, double amount, String type, String category, String? categoryEmoji, String? note, String? source, String? paymentMethod, String? receiptImageUrl,@TimestampConverter() DateTime date,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? updatedAt, String? location
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
@pragma('vm:prefer-inline') @override $Res call({Object? transactionId = null,Object? userId = null,Object? amount = null,Object? type = null,Object? category = null,Object? categoryEmoji = freezed,Object? note = freezed,Object? source = freezed,Object? paymentMethod = freezed,Object? receiptImageUrl = freezed,Object? date = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? location = freezed,}) {
  return _then(_self.copyWith(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,categoryEmoji: freezed == categoryEmoji ? _self.categoryEmoji : categoryEmoji // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,receiptImageUrl: freezed == receiptImageUrl ? _self.receiptImageUrl : receiptImageUrl // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TransactionModel implements TransactionModel {
  const _TransactionModel({required this.transactionId, required this.userId, required this.amount, required this.type, required this.category, this.categoryEmoji, this.note, this.source, this.paymentMethod, this.receiptImageUrl, @TimestampConverter() required this.date, @TimestampConverter() this.createdAt, @TimestampConverter() this.updatedAt, this.location});
  factory _TransactionModel.fromJson(Map<String, dynamic> json) => _$TransactionModelFromJson(json);

@override final  String transactionId;
@override final  String userId;
@override final  double amount;
/// 'expense' or 'income'
@override final  String type;
@override final  String category;
@override final  String? categoryEmoji;
@override final  String? note;
@override final  String? source;
@override final  String? paymentMethod;
@override final  String? receiptImageUrl;
@override@TimestampConverter() final  DateTime date;
@override@TimestampConverter() final  DateTime? createdAt;
@override@TimestampConverter() final  DateTime? updatedAt;
@override final  String? location;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionModel&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type)&&(identical(other.category, category) || other.category == category)&&(identical(other.categoryEmoji, categoryEmoji) || other.categoryEmoji == categoryEmoji)&&(identical(other.note, note) || other.note == note)&&(identical(other.source, source) || other.source == source)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.receiptImageUrl, receiptImageUrl) || other.receiptImageUrl == receiptImageUrl)&&(identical(other.date, date) || other.date == date)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionId,userId,amount,type,category,categoryEmoji,note,source,paymentMethod,receiptImageUrl,date,createdAt,updatedAt,location);

@override
String toString() {
  return 'TransactionModel(transactionId: $transactionId, userId: $userId, amount: $amount, type: $type, category: $category, categoryEmoji: $categoryEmoji, note: $note, source: $source, paymentMethod: $paymentMethod, receiptImageUrl: $receiptImageUrl, date: $date, createdAt: $createdAt, updatedAt: $updatedAt, location: $location)';
}


}

/// @nodoc
abstract mixin class _$TransactionModelCopyWith<$Res> implements $TransactionModelCopyWith<$Res> {
  factory _$TransactionModelCopyWith(_TransactionModel value, $Res Function(_TransactionModel) _then) = __$TransactionModelCopyWithImpl;
@override @useResult
$Res call({
 String transactionId, String userId, double amount, String type, String category, String? categoryEmoji, String? note, String? source, String? paymentMethod, String? receiptImageUrl,@TimestampConverter() DateTime date,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? updatedAt, String? location
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
@override @pragma('vm:prefer-inline') $Res call({Object? transactionId = null,Object? userId = null,Object? amount = null,Object? type = null,Object? category = null,Object? categoryEmoji = freezed,Object? note = freezed,Object? source = freezed,Object? paymentMethod = freezed,Object? receiptImageUrl = freezed,Object? date = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? location = freezed,}) {
  return _then(_TransactionModel(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,categoryEmoji: freezed == categoryEmoji ? _self.categoryEmoji : categoryEmoji // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,receiptImageUrl: freezed == receiptImageUrl ? _self.receiptImageUrl : receiptImageUrl // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
