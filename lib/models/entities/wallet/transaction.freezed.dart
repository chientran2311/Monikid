// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Transaction {

 String get id;@JsonKey(name: 'family_id') String? get familyId;@JsonKey(name: 'from_wallet_id') String? get fromWalletId;@JsonKey(name: 'to_wallet_id') String? get toWalletId; TransactionType get type; double get amount; String? get description;@JsonKey(name: 'merchant_name') String? get merchantName;@JsonKey(name: 'location_lat') double? get locationLat;@JsonKey(name: 'location_lng') double? get locationLng;@JsonKey(name: 'created_by') String? get createdBy; TransactionStatus get status;@JsonKey(name: 'created_at') DateTime? get createdAt;// Additional fields for UI display
@JsonKey(name: 'from_wallet') Map<String, dynamic>? get fromWallet;@JsonKey(name: 'to_wallet') Map<String, dynamic>? get toWallet;
/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionCopyWith<Transaction> get copyWith => _$TransactionCopyWithImpl<Transaction>(this as Transaction, _$identity);

  /// Serializes this Transaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Transaction&&(identical(other.id, id) || other.id == id)&&(identical(other.familyId, familyId) || other.familyId == familyId)&&(identical(other.fromWalletId, fromWalletId) || other.fromWalletId == fromWalletId)&&(identical(other.toWalletId, toWalletId) || other.toWalletId == toWalletId)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.locationLat, locationLat) || other.locationLat == locationLat)&&(identical(other.locationLng, locationLng) || other.locationLng == locationLng)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.fromWallet, fromWallet)&&const DeepCollectionEquality().equals(other.toWallet, toWallet));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,familyId,fromWalletId,toWalletId,type,amount,description,merchantName,locationLat,locationLng,createdBy,status,createdAt,const DeepCollectionEquality().hash(fromWallet),const DeepCollectionEquality().hash(toWallet));

@override
String toString() {
  return 'Transaction(id: $id, familyId: $familyId, fromWalletId: $fromWalletId, toWalletId: $toWalletId, type: $type, amount: $amount, description: $description, merchantName: $merchantName, locationLat: $locationLat, locationLng: $locationLng, createdBy: $createdBy, status: $status, createdAt: $createdAt, fromWallet: $fromWallet, toWallet: $toWallet)';
}


}

/// @nodoc
abstract mixin class $TransactionCopyWith<$Res>  {
  factory $TransactionCopyWith(Transaction value, $Res Function(Transaction) _then) = _$TransactionCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'family_id') String? familyId,@JsonKey(name: 'from_wallet_id') String? fromWalletId,@JsonKey(name: 'to_wallet_id') String? toWalletId, TransactionType type, double amount, String? description,@JsonKey(name: 'merchant_name') String? merchantName,@JsonKey(name: 'location_lat') double? locationLat,@JsonKey(name: 'location_lng') double? locationLng,@JsonKey(name: 'created_by') String? createdBy, TransactionStatus status,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'from_wallet') Map<String, dynamic>? fromWallet,@JsonKey(name: 'to_wallet') Map<String, dynamic>? toWallet
});




}
/// @nodoc
class _$TransactionCopyWithImpl<$Res>
    implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._self, this._then);

  final Transaction _self;
  final $Res Function(Transaction) _then;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? familyId = freezed,Object? fromWalletId = freezed,Object? toWalletId = freezed,Object? type = null,Object? amount = null,Object? description = freezed,Object? merchantName = freezed,Object? locationLat = freezed,Object? locationLng = freezed,Object? createdBy = freezed,Object? status = null,Object? createdAt = freezed,Object? fromWallet = freezed,Object? toWallet = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,familyId: freezed == familyId ? _self.familyId : familyId // ignore: cast_nullable_to_non_nullable
as String?,fromWalletId: freezed == fromWalletId ? _self.fromWalletId : fromWalletId // ignore: cast_nullable_to_non_nullable
as String?,toWalletId: freezed == toWalletId ? _self.toWalletId : toWalletId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,merchantName: freezed == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String?,locationLat: freezed == locationLat ? _self.locationLat : locationLat // ignore: cast_nullable_to_non_nullable
as double?,locationLng: freezed == locationLng ? _self.locationLng : locationLng // ignore: cast_nullable_to_non_nullable
as double?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransactionStatus,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fromWallet: freezed == fromWallet ? _self.fromWallet : fromWallet // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,toWallet: freezed == toWallet ? _self.toWallet : toWallet // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Transaction implements Transaction {
  const _Transaction({required this.id, @JsonKey(name: 'family_id') this.familyId, @JsonKey(name: 'from_wallet_id') this.fromWalletId, @JsonKey(name: 'to_wallet_id') this.toWalletId, required this.type, required this.amount, this.description, @JsonKey(name: 'merchant_name') this.merchantName, @JsonKey(name: 'location_lat') this.locationLat, @JsonKey(name: 'location_lng') this.locationLng, @JsonKey(name: 'created_by') this.createdBy, this.status = TransactionStatus.completed, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'from_wallet') final  Map<String, dynamic>? fromWallet, @JsonKey(name: 'to_wallet') final  Map<String, dynamic>? toWallet}): _fromWallet = fromWallet,_toWallet = toWallet;
  factory _Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);

@override final  String id;
@override@JsonKey(name: 'family_id') final  String? familyId;
@override@JsonKey(name: 'from_wallet_id') final  String? fromWalletId;
@override@JsonKey(name: 'to_wallet_id') final  String? toWalletId;
@override final  TransactionType type;
@override final  double amount;
@override final  String? description;
@override@JsonKey(name: 'merchant_name') final  String? merchantName;
@override@JsonKey(name: 'location_lat') final  double? locationLat;
@override@JsonKey(name: 'location_lng') final  double? locationLng;
@override@JsonKey(name: 'created_by') final  String? createdBy;
@override@JsonKey() final  TransactionStatus status;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
// Additional fields for UI display
 final  Map<String, dynamic>? _fromWallet;
// Additional fields for UI display
@override@JsonKey(name: 'from_wallet') Map<String, dynamic>? get fromWallet {
  final value = _fromWallet;
  if (value == null) return null;
  if (_fromWallet is EqualUnmodifiableMapView) return _fromWallet;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _toWallet;
@override@JsonKey(name: 'to_wallet') Map<String, dynamic>? get toWallet {
  final value = _toWallet;
  if (value == null) return null;
  if (_toWallet is EqualUnmodifiableMapView) return _toWallet;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionCopyWith<_Transaction> get copyWith => __$TransactionCopyWithImpl<_Transaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Transaction&&(identical(other.id, id) || other.id == id)&&(identical(other.familyId, familyId) || other.familyId == familyId)&&(identical(other.fromWalletId, fromWalletId) || other.fromWalletId == fromWalletId)&&(identical(other.toWalletId, toWalletId) || other.toWalletId == toWalletId)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.locationLat, locationLat) || other.locationLat == locationLat)&&(identical(other.locationLng, locationLng) || other.locationLng == locationLng)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._fromWallet, _fromWallet)&&const DeepCollectionEquality().equals(other._toWallet, _toWallet));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,familyId,fromWalletId,toWalletId,type,amount,description,merchantName,locationLat,locationLng,createdBy,status,createdAt,const DeepCollectionEquality().hash(_fromWallet),const DeepCollectionEquality().hash(_toWallet));

@override
String toString() {
  return 'Transaction(id: $id, familyId: $familyId, fromWalletId: $fromWalletId, toWalletId: $toWalletId, type: $type, amount: $amount, description: $description, merchantName: $merchantName, locationLat: $locationLat, locationLng: $locationLng, createdBy: $createdBy, status: $status, createdAt: $createdAt, fromWallet: $fromWallet, toWallet: $toWallet)';
}


}

/// @nodoc
abstract mixin class _$TransactionCopyWith<$Res> implements $TransactionCopyWith<$Res> {
  factory _$TransactionCopyWith(_Transaction value, $Res Function(_Transaction) _then) = __$TransactionCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'family_id') String? familyId,@JsonKey(name: 'from_wallet_id') String? fromWalletId,@JsonKey(name: 'to_wallet_id') String? toWalletId, TransactionType type, double amount, String? description,@JsonKey(name: 'merchant_name') String? merchantName,@JsonKey(name: 'location_lat') double? locationLat,@JsonKey(name: 'location_lng') double? locationLng,@JsonKey(name: 'created_by') String? createdBy, TransactionStatus status,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'from_wallet') Map<String, dynamic>? fromWallet,@JsonKey(name: 'to_wallet') Map<String, dynamic>? toWallet
});




}
/// @nodoc
class __$TransactionCopyWithImpl<$Res>
    implements _$TransactionCopyWith<$Res> {
  __$TransactionCopyWithImpl(this._self, this._then);

  final _Transaction _self;
  final $Res Function(_Transaction) _then;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? familyId = freezed,Object? fromWalletId = freezed,Object? toWalletId = freezed,Object? type = null,Object? amount = null,Object? description = freezed,Object? merchantName = freezed,Object? locationLat = freezed,Object? locationLng = freezed,Object? createdBy = freezed,Object? status = null,Object? createdAt = freezed,Object? fromWallet = freezed,Object? toWallet = freezed,}) {
  return _then(_Transaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,familyId: freezed == familyId ? _self.familyId : familyId // ignore: cast_nullable_to_non_nullable
as String?,fromWalletId: freezed == fromWalletId ? _self.fromWalletId : fromWalletId // ignore: cast_nullable_to_non_nullable
as String?,toWalletId: freezed == toWalletId ? _self.toWalletId : toWalletId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,merchantName: freezed == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String?,locationLat: freezed == locationLat ? _self.locationLat : locationLat // ignore: cast_nullable_to_non_nullable
as double?,locationLng: freezed == locationLng ? _self.locationLng : locationLng // ignore: cast_nullable_to_non_nullable
as double?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransactionStatus,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fromWallet: freezed == fromWallet ? _self._fromWallet : fromWallet // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,toWallet: freezed == toWallet ? _self._toWallet : toWallet // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$CreateTransactionRequest {

@JsonKey(name: 'family_id') String get familyId;@JsonKey(name: 'from_wallet_id') String? get fromWalletId;@JsonKey(name: 'to_wallet_id') String? get toWalletId; String get type; double get amount; String? get description;@JsonKey(name: 'created_by') String get createdBy;
/// Create a copy of CreateTransactionRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateTransactionRequestCopyWith<CreateTransactionRequest> get copyWith => _$CreateTransactionRequestCopyWithImpl<CreateTransactionRequest>(this as CreateTransactionRequest, _$identity);

  /// Serializes this CreateTransactionRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateTransactionRequest&&(identical(other.familyId, familyId) || other.familyId == familyId)&&(identical(other.fromWalletId, fromWalletId) || other.fromWalletId == fromWalletId)&&(identical(other.toWalletId, toWalletId) || other.toWalletId == toWalletId)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,familyId,fromWalletId,toWalletId,type,amount,description,createdBy);

@override
String toString() {
  return 'CreateTransactionRequest(familyId: $familyId, fromWalletId: $fromWalletId, toWalletId: $toWalletId, type: $type, amount: $amount, description: $description, createdBy: $createdBy)';
}


}

/// @nodoc
abstract mixin class $CreateTransactionRequestCopyWith<$Res>  {
  factory $CreateTransactionRequestCopyWith(CreateTransactionRequest value, $Res Function(CreateTransactionRequest) _then) = _$CreateTransactionRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'family_id') String familyId,@JsonKey(name: 'from_wallet_id') String? fromWalletId,@JsonKey(name: 'to_wallet_id') String? toWalletId, String type, double amount, String? description,@JsonKey(name: 'created_by') String createdBy
});




}
/// @nodoc
class _$CreateTransactionRequestCopyWithImpl<$Res>
    implements $CreateTransactionRequestCopyWith<$Res> {
  _$CreateTransactionRequestCopyWithImpl(this._self, this._then);

  final CreateTransactionRequest _self;
  final $Res Function(CreateTransactionRequest) _then;

/// Create a copy of CreateTransactionRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? familyId = null,Object? fromWalletId = freezed,Object? toWalletId = freezed,Object? type = null,Object? amount = null,Object? description = freezed,Object? createdBy = null,}) {
  return _then(_self.copyWith(
familyId: null == familyId ? _self.familyId : familyId // ignore: cast_nullable_to_non_nullable
as String,fromWalletId: freezed == fromWalletId ? _self.fromWalletId : fromWalletId // ignore: cast_nullable_to_non_nullable
as String?,toWalletId: freezed == toWalletId ? _self.toWalletId : toWalletId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CreateTransactionRequest implements CreateTransactionRequest {
  const _CreateTransactionRequest({@JsonKey(name: 'family_id') required this.familyId, @JsonKey(name: 'from_wallet_id') this.fromWalletId, @JsonKey(name: 'to_wallet_id') this.toWalletId, required this.type, required this.amount, this.description, @JsonKey(name: 'created_by') required this.createdBy});
  factory _CreateTransactionRequest.fromJson(Map<String, dynamic> json) => _$CreateTransactionRequestFromJson(json);

@override@JsonKey(name: 'family_id') final  String familyId;
@override@JsonKey(name: 'from_wallet_id') final  String? fromWalletId;
@override@JsonKey(name: 'to_wallet_id') final  String? toWalletId;
@override final  String type;
@override final  double amount;
@override final  String? description;
@override@JsonKey(name: 'created_by') final  String createdBy;

/// Create a copy of CreateTransactionRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateTransactionRequestCopyWith<_CreateTransactionRequest> get copyWith => __$CreateTransactionRequestCopyWithImpl<_CreateTransactionRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateTransactionRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateTransactionRequest&&(identical(other.familyId, familyId) || other.familyId == familyId)&&(identical(other.fromWalletId, fromWalletId) || other.fromWalletId == fromWalletId)&&(identical(other.toWalletId, toWalletId) || other.toWalletId == toWalletId)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,familyId,fromWalletId,toWalletId,type,amount,description,createdBy);

@override
String toString() {
  return 'CreateTransactionRequest(familyId: $familyId, fromWalletId: $fromWalletId, toWalletId: $toWalletId, type: $type, amount: $amount, description: $description, createdBy: $createdBy)';
}


}

/// @nodoc
abstract mixin class _$CreateTransactionRequestCopyWith<$Res> implements $CreateTransactionRequestCopyWith<$Res> {
  factory _$CreateTransactionRequestCopyWith(_CreateTransactionRequest value, $Res Function(_CreateTransactionRequest) _then) = __$CreateTransactionRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'family_id') String familyId,@JsonKey(name: 'from_wallet_id') String? fromWalletId,@JsonKey(name: 'to_wallet_id') String? toWalletId, String type, double amount, String? description,@JsonKey(name: 'created_by') String createdBy
});




}
/// @nodoc
class __$CreateTransactionRequestCopyWithImpl<$Res>
    implements _$CreateTransactionRequestCopyWith<$Res> {
  __$CreateTransactionRequestCopyWithImpl(this._self, this._then);

  final _CreateTransactionRequest _self;
  final $Res Function(_CreateTransactionRequest) _then;

/// Create a copy of CreateTransactionRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? familyId = null,Object? fromWalletId = freezed,Object? toWalletId = freezed,Object? type = null,Object? amount = null,Object? description = freezed,Object? createdBy = null,}) {
  return _then(_CreateTransactionRequest(
familyId: null == familyId ? _self.familyId : familyId // ignore: cast_nullable_to_non_nullable
as String,fromWalletId: freezed == fromWalletId ? _self.fromWalletId : fromWalletId // ignore: cast_nullable_to_non_nullable
as String?,toWalletId: freezed == toWalletId ? _self.toWalletId : toWalletId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MoneyRequest {

 String get id;@JsonKey(name: 'from_wallet_id') String get fromWalletId;@JsonKey(name: 'to_wallet_id') String get toWalletId; double get amount; String? get reason; String get status;@JsonKey(name: 'responded_at') DateTime? get respondedAt;@JsonKey(name: 'created_at') DateTime? get createdAt;// Additional fields for UI display
@JsonKey(name: 'from_wallet') Map<String, dynamic>? get fromWallet;@JsonKey(name: 'to_wallet') Map<String, dynamic>? get toWallet;
/// Create a copy of MoneyRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MoneyRequestCopyWith<MoneyRequest> get copyWith => _$MoneyRequestCopyWithImpl<MoneyRequest>(this as MoneyRequest, _$identity);

  /// Serializes this MoneyRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MoneyRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.fromWalletId, fromWalletId) || other.fromWalletId == fromWalletId)&&(identical(other.toWalletId, toWalletId) || other.toWalletId == toWalletId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.fromWallet, fromWallet)&&const DeepCollectionEquality().equals(other.toWallet, toWallet));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fromWalletId,toWalletId,amount,reason,status,respondedAt,createdAt,const DeepCollectionEquality().hash(fromWallet),const DeepCollectionEquality().hash(toWallet));

@override
String toString() {
  return 'MoneyRequest(id: $id, fromWalletId: $fromWalletId, toWalletId: $toWalletId, amount: $amount, reason: $reason, status: $status, respondedAt: $respondedAt, createdAt: $createdAt, fromWallet: $fromWallet, toWallet: $toWallet)';
}


}

/// @nodoc
abstract mixin class $MoneyRequestCopyWith<$Res>  {
  factory $MoneyRequestCopyWith(MoneyRequest value, $Res Function(MoneyRequest) _then) = _$MoneyRequestCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'from_wallet_id') String fromWalletId,@JsonKey(name: 'to_wallet_id') String toWalletId, double amount, String? reason, String status,@JsonKey(name: 'responded_at') DateTime? respondedAt,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'from_wallet') Map<String, dynamic>? fromWallet,@JsonKey(name: 'to_wallet') Map<String, dynamic>? toWallet
});




}
/// @nodoc
class _$MoneyRequestCopyWithImpl<$Res>
    implements $MoneyRequestCopyWith<$Res> {
  _$MoneyRequestCopyWithImpl(this._self, this._then);

  final MoneyRequest _self;
  final $Res Function(MoneyRequest) _then;

/// Create a copy of MoneyRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fromWalletId = null,Object? toWalletId = null,Object? amount = null,Object? reason = freezed,Object? status = null,Object? respondedAt = freezed,Object? createdAt = freezed,Object? fromWallet = freezed,Object? toWallet = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromWalletId: null == fromWalletId ? _self.fromWalletId : fromWalletId // ignore: cast_nullable_to_non_nullable
as String,toWalletId: null == toWalletId ? _self.toWalletId : toWalletId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fromWallet: freezed == fromWallet ? _self.fromWallet : fromWallet // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,toWallet: freezed == toWallet ? _self.toWallet : toWallet // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MoneyRequest implements MoneyRequest {
  const _MoneyRequest({required this.id, @JsonKey(name: 'from_wallet_id') required this.fromWalletId, @JsonKey(name: 'to_wallet_id') required this.toWalletId, required this.amount, this.reason, this.status = 'pending', @JsonKey(name: 'responded_at') this.respondedAt, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'from_wallet') final  Map<String, dynamic>? fromWallet, @JsonKey(name: 'to_wallet') final  Map<String, dynamic>? toWallet}): _fromWallet = fromWallet,_toWallet = toWallet;
  factory _MoneyRequest.fromJson(Map<String, dynamic> json) => _$MoneyRequestFromJson(json);

@override final  String id;
@override@JsonKey(name: 'from_wallet_id') final  String fromWalletId;
@override@JsonKey(name: 'to_wallet_id') final  String toWalletId;
@override final  double amount;
@override final  String? reason;
@override@JsonKey() final  String status;
@override@JsonKey(name: 'responded_at') final  DateTime? respondedAt;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
// Additional fields for UI display
 final  Map<String, dynamic>? _fromWallet;
// Additional fields for UI display
@override@JsonKey(name: 'from_wallet') Map<String, dynamic>? get fromWallet {
  final value = _fromWallet;
  if (value == null) return null;
  if (_fromWallet is EqualUnmodifiableMapView) return _fromWallet;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _toWallet;
@override@JsonKey(name: 'to_wallet') Map<String, dynamic>? get toWallet {
  final value = _toWallet;
  if (value == null) return null;
  if (_toWallet is EqualUnmodifiableMapView) return _toWallet;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of MoneyRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MoneyRequestCopyWith<_MoneyRequest> get copyWith => __$MoneyRequestCopyWithImpl<_MoneyRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MoneyRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MoneyRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.fromWalletId, fromWalletId) || other.fromWalletId == fromWalletId)&&(identical(other.toWalletId, toWalletId) || other.toWalletId == toWalletId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._fromWallet, _fromWallet)&&const DeepCollectionEquality().equals(other._toWallet, _toWallet));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fromWalletId,toWalletId,amount,reason,status,respondedAt,createdAt,const DeepCollectionEquality().hash(_fromWallet),const DeepCollectionEquality().hash(_toWallet));

@override
String toString() {
  return 'MoneyRequest(id: $id, fromWalletId: $fromWalletId, toWalletId: $toWalletId, amount: $amount, reason: $reason, status: $status, respondedAt: $respondedAt, createdAt: $createdAt, fromWallet: $fromWallet, toWallet: $toWallet)';
}


}

/// @nodoc
abstract mixin class _$MoneyRequestCopyWith<$Res> implements $MoneyRequestCopyWith<$Res> {
  factory _$MoneyRequestCopyWith(_MoneyRequest value, $Res Function(_MoneyRequest) _then) = __$MoneyRequestCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'from_wallet_id') String fromWalletId,@JsonKey(name: 'to_wallet_id') String toWalletId, double amount, String? reason, String status,@JsonKey(name: 'responded_at') DateTime? respondedAt,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'from_wallet') Map<String, dynamic>? fromWallet,@JsonKey(name: 'to_wallet') Map<String, dynamic>? toWallet
});




}
/// @nodoc
class __$MoneyRequestCopyWithImpl<$Res>
    implements _$MoneyRequestCopyWith<$Res> {
  __$MoneyRequestCopyWithImpl(this._self, this._then);

  final _MoneyRequest _self;
  final $Res Function(_MoneyRequest) _then;

/// Create a copy of MoneyRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fromWalletId = null,Object? toWalletId = null,Object? amount = null,Object? reason = freezed,Object? status = null,Object? respondedAt = freezed,Object? createdAt = freezed,Object? fromWallet = freezed,Object? toWallet = freezed,}) {
  return _then(_MoneyRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromWalletId: null == fromWalletId ? _self.fromWalletId : fromWalletId // ignore: cast_nullable_to_non_nullable
as String,toWalletId: null == toWalletId ? _self.toWalletId : toWalletId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fromWallet: freezed == fromWallet ? _self._fromWallet : fromWallet // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,toWallet: freezed == toWallet ? _self._toWallet : toWallet // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
