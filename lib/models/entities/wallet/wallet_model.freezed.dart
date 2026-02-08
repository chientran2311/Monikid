// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WalletModel {

 String get id;@JsonKey(name: 'owner_id') String get ownerId;@JsonKey(name: 'family_id') String? get familyId;@JsonKey(name: 'wallet_type') WalletType get walletType; double get balance;@JsonKey(name: 'is_locked') bool get isLocked;@JsonKey(name: 'locked_by') String? get lockedBy;@JsonKey(name: 'locked_at') DateTime? get lockedAt;@JsonKey(name: 'spending_limit_daily') double? get spendingLimitDaily;@JsonKey(name: 'created_by') String? get createdBy;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;// Statistics
@JsonKey(name: 'total_transferred') double get totalTransferred;@JsonKey(name: 'total_spent') double get totalSpent;@JsonKey(name: 'total_withdrawn') double get totalWithdrawn;@JsonKey(name: 'total_deposited') double get totalDeposited;
/// Create a copy of WalletModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletModelCopyWith<WalletModel> get copyWith => _$WalletModelCopyWithImpl<WalletModel>(this as WalletModel, _$identity);

  /// Serializes this WalletModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletModel&&(identical(other.id, id) || other.id == id)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.familyId, familyId) || other.familyId == familyId)&&(identical(other.walletType, walletType) || other.walletType == walletType)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.lockedBy, lockedBy) || other.lockedBy == lockedBy)&&(identical(other.lockedAt, lockedAt) || other.lockedAt == lockedAt)&&(identical(other.spendingLimitDaily, spendingLimitDaily) || other.spendingLimitDaily == spendingLimitDaily)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.totalTransferred, totalTransferred) || other.totalTransferred == totalTransferred)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent)&&(identical(other.totalWithdrawn, totalWithdrawn) || other.totalWithdrawn == totalWithdrawn)&&(identical(other.totalDeposited, totalDeposited) || other.totalDeposited == totalDeposited));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ownerId,familyId,walletType,balance,isLocked,lockedBy,lockedAt,spendingLimitDaily,createdBy,createdAt,updatedAt,totalTransferred,totalSpent,totalWithdrawn,totalDeposited);

@override
String toString() {
  return 'WalletModel(id: $id, ownerId: $ownerId, familyId: $familyId, walletType: $walletType, balance: $balance, isLocked: $isLocked, lockedBy: $lockedBy, lockedAt: $lockedAt, spendingLimitDaily: $spendingLimitDaily, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, totalTransferred: $totalTransferred, totalSpent: $totalSpent, totalWithdrawn: $totalWithdrawn, totalDeposited: $totalDeposited)';
}


}

/// @nodoc
abstract mixin class $WalletModelCopyWith<$Res>  {
  factory $WalletModelCopyWith(WalletModel value, $Res Function(WalletModel) _then) = _$WalletModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'owner_id') String ownerId,@JsonKey(name: 'family_id') String? familyId,@JsonKey(name: 'wallet_type') WalletType walletType, double balance,@JsonKey(name: 'is_locked') bool isLocked,@JsonKey(name: 'locked_by') String? lockedBy,@JsonKey(name: 'locked_at') DateTime? lockedAt,@JsonKey(name: 'spending_limit_daily') double? spendingLimitDaily,@JsonKey(name: 'created_by') String? createdBy,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt,@JsonKey(name: 'total_transferred') double totalTransferred,@JsonKey(name: 'total_spent') double totalSpent,@JsonKey(name: 'total_withdrawn') double totalWithdrawn,@JsonKey(name: 'total_deposited') double totalDeposited
});




}
/// @nodoc
class _$WalletModelCopyWithImpl<$Res>
    implements $WalletModelCopyWith<$Res> {
  _$WalletModelCopyWithImpl(this._self, this._then);

  final WalletModel _self;
  final $Res Function(WalletModel) _then;

/// Create a copy of WalletModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ownerId = null,Object? familyId = freezed,Object? walletType = null,Object? balance = null,Object? isLocked = null,Object? lockedBy = freezed,Object? lockedAt = freezed,Object? spendingLimitDaily = freezed,Object? createdBy = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? totalTransferred = null,Object? totalSpent = null,Object? totalWithdrawn = null,Object? totalDeposited = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,familyId: freezed == familyId ? _self.familyId : familyId // ignore: cast_nullable_to_non_nullable
as String?,walletType: null == walletType ? _self.walletType : walletType // ignore: cast_nullable_to_non_nullable
as WalletType,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,lockedBy: freezed == lockedBy ? _self.lockedBy : lockedBy // ignore: cast_nullable_to_non_nullable
as String?,lockedAt: freezed == lockedAt ? _self.lockedAt : lockedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,spendingLimitDaily: freezed == spendingLimitDaily ? _self.spendingLimitDaily : spendingLimitDaily // ignore: cast_nullable_to_non_nullable
as double?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,totalTransferred: null == totalTransferred ? _self.totalTransferred : totalTransferred // ignore: cast_nullable_to_non_nullable
as double,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as double,totalWithdrawn: null == totalWithdrawn ? _self.totalWithdrawn : totalWithdrawn // ignore: cast_nullable_to_non_nullable
as double,totalDeposited: null == totalDeposited ? _self.totalDeposited : totalDeposited // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _WalletModel implements WalletModel {
  const _WalletModel({required this.id, @JsonKey(name: 'owner_id') required this.ownerId, @JsonKey(name: 'family_id') this.familyId, @JsonKey(name: 'wallet_type') required this.walletType, this.balance = 1000000.0, @JsonKey(name: 'is_locked') this.isLocked = false, @JsonKey(name: 'locked_by') this.lockedBy, @JsonKey(name: 'locked_at') this.lockedAt, @JsonKey(name: 'spending_limit_daily') this.spendingLimitDaily, @JsonKey(name: 'created_by') this.createdBy, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt, @JsonKey(name: 'total_transferred') this.totalTransferred = 0.0, @JsonKey(name: 'total_spent') this.totalSpent = 0.0, @JsonKey(name: 'total_withdrawn') this.totalWithdrawn = 0.0, @JsonKey(name: 'total_deposited') this.totalDeposited = 0.0});
  factory _WalletModel.fromJson(Map<String, dynamic> json) => _$WalletModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'owner_id') final  String ownerId;
@override@JsonKey(name: 'family_id') final  String? familyId;
@override@JsonKey(name: 'wallet_type') final  WalletType walletType;
@override@JsonKey() final  double balance;
@override@JsonKey(name: 'is_locked') final  bool isLocked;
@override@JsonKey(name: 'locked_by') final  String? lockedBy;
@override@JsonKey(name: 'locked_at') final  DateTime? lockedAt;
@override@JsonKey(name: 'spending_limit_daily') final  double? spendingLimitDaily;
@override@JsonKey(name: 'created_by') final  String? createdBy;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;
// Statistics
@override@JsonKey(name: 'total_transferred') final  double totalTransferred;
@override@JsonKey(name: 'total_spent') final  double totalSpent;
@override@JsonKey(name: 'total_withdrawn') final  double totalWithdrawn;
@override@JsonKey(name: 'total_deposited') final  double totalDeposited;

/// Create a copy of WalletModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletModelCopyWith<_WalletModel> get copyWith => __$WalletModelCopyWithImpl<_WalletModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletModel&&(identical(other.id, id) || other.id == id)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.familyId, familyId) || other.familyId == familyId)&&(identical(other.walletType, walletType) || other.walletType == walletType)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.lockedBy, lockedBy) || other.lockedBy == lockedBy)&&(identical(other.lockedAt, lockedAt) || other.lockedAt == lockedAt)&&(identical(other.spendingLimitDaily, spendingLimitDaily) || other.spendingLimitDaily == spendingLimitDaily)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.totalTransferred, totalTransferred) || other.totalTransferred == totalTransferred)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent)&&(identical(other.totalWithdrawn, totalWithdrawn) || other.totalWithdrawn == totalWithdrawn)&&(identical(other.totalDeposited, totalDeposited) || other.totalDeposited == totalDeposited));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ownerId,familyId,walletType,balance,isLocked,lockedBy,lockedAt,spendingLimitDaily,createdBy,createdAt,updatedAt,totalTransferred,totalSpent,totalWithdrawn,totalDeposited);

@override
String toString() {
  return 'WalletModel(id: $id, ownerId: $ownerId, familyId: $familyId, walletType: $walletType, balance: $balance, isLocked: $isLocked, lockedBy: $lockedBy, lockedAt: $lockedAt, spendingLimitDaily: $spendingLimitDaily, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, totalTransferred: $totalTransferred, totalSpent: $totalSpent, totalWithdrawn: $totalWithdrawn, totalDeposited: $totalDeposited)';
}


}

/// @nodoc
abstract mixin class _$WalletModelCopyWith<$Res> implements $WalletModelCopyWith<$Res> {
  factory _$WalletModelCopyWith(_WalletModel value, $Res Function(_WalletModel) _then) = __$WalletModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'owner_id') String ownerId,@JsonKey(name: 'family_id') String? familyId,@JsonKey(name: 'wallet_type') WalletType walletType, double balance,@JsonKey(name: 'is_locked') bool isLocked,@JsonKey(name: 'locked_by') String? lockedBy,@JsonKey(name: 'locked_at') DateTime? lockedAt,@JsonKey(name: 'spending_limit_daily') double? spendingLimitDaily,@JsonKey(name: 'created_by') String? createdBy,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt,@JsonKey(name: 'total_transferred') double totalTransferred,@JsonKey(name: 'total_spent') double totalSpent,@JsonKey(name: 'total_withdrawn') double totalWithdrawn,@JsonKey(name: 'total_deposited') double totalDeposited
});




}
/// @nodoc
class __$WalletModelCopyWithImpl<$Res>
    implements _$WalletModelCopyWith<$Res> {
  __$WalletModelCopyWithImpl(this._self, this._then);

  final _WalletModel _self;
  final $Res Function(_WalletModel) _then;

/// Create a copy of WalletModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ownerId = null,Object? familyId = freezed,Object? walletType = null,Object? balance = null,Object? isLocked = null,Object? lockedBy = freezed,Object? lockedAt = freezed,Object? spendingLimitDaily = freezed,Object? createdBy = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? totalTransferred = null,Object? totalSpent = null,Object? totalWithdrawn = null,Object? totalDeposited = null,}) {
  return _then(_WalletModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,familyId: freezed == familyId ? _self.familyId : familyId // ignore: cast_nullable_to_non_nullable
as String?,walletType: null == walletType ? _self.walletType : walletType // ignore: cast_nullable_to_non_nullable
as WalletType,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,lockedBy: freezed == lockedBy ? _self.lockedBy : lockedBy // ignore: cast_nullable_to_non_nullable
as String?,lockedAt: freezed == lockedAt ? _self.lockedAt : lockedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,spendingLimitDaily: freezed == spendingLimitDaily ? _self.spendingLimitDaily : spendingLimitDaily // ignore: cast_nullable_to_non_nullable
as double?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,totalTransferred: null == totalTransferred ? _self.totalTransferred : totalTransferred // ignore: cast_nullable_to_non_nullable
as double,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as double,totalWithdrawn: null == totalWithdrawn ? _self.totalWithdrawn : totalWithdrawn // ignore: cast_nullable_to_non_nullable
as double,totalDeposited: null == totalDeposited ? _self.totalDeposited : totalDeposited // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$FamilyMemberWallet {

 String get id;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'full_name') String get fullName; String? get avatarUrl; String get role;@JsonKey(name: 'wallet_id') String? get walletId; double get balance;
/// Create a copy of FamilyMemberWallet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FamilyMemberWalletCopyWith<FamilyMemberWallet> get copyWith => _$FamilyMemberWalletCopyWithImpl<FamilyMemberWallet>(this as FamilyMemberWallet, _$identity);

  /// Serializes this FamilyMemberWallet to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FamilyMemberWallet&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.role, role) || other.role == role)&&(identical(other.walletId, walletId) || other.walletId == walletId)&&(identical(other.balance, balance) || other.balance == balance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,fullName,avatarUrl,role,walletId,balance);

@override
String toString() {
  return 'FamilyMemberWallet(id: $id, userId: $userId, fullName: $fullName, avatarUrl: $avatarUrl, role: $role, walletId: $walletId, balance: $balance)';
}


}

/// @nodoc
abstract mixin class $FamilyMemberWalletCopyWith<$Res>  {
  factory $FamilyMemberWalletCopyWith(FamilyMemberWallet value, $Res Function(FamilyMemberWallet) _then) = _$FamilyMemberWalletCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'full_name') String fullName, String? avatarUrl, String role,@JsonKey(name: 'wallet_id') String? walletId, double balance
});




}
/// @nodoc
class _$FamilyMemberWalletCopyWithImpl<$Res>
    implements $FamilyMemberWalletCopyWith<$Res> {
  _$FamilyMemberWalletCopyWithImpl(this._self, this._then);

  final FamilyMemberWallet _self;
  final $Res Function(FamilyMemberWallet) _then;

/// Create a copy of FamilyMemberWallet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? fullName = null,Object? avatarUrl = freezed,Object? role = null,Object? walletId = freezed,Object? balance = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,walletId: freezed == walletId ? _self.walletId : walletId // ignore: cast_nullable_to_non_nullable
as String?,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FamilyMemberWallet implements FamilyMemberWallet {
  const _FamilyMemberWallet({required this.id, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'full_name') this.fullName = 'Thành viên', this.avatarUrl, required this.role, @JsonKey(name: 'wallet_id') this.walletId, this.balance = 0.0});
  factory _FamilyMemberWallet.fromJson(Map<String, dynamic> json) => _$FamilyMemberWalletFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'full_name') final  String fullName;
@override final  String? avatarUrl;
@override final  String role;
@override@JsonKey(name: 'wallet_id') final  String? walletId;
@override@JsonKey() final  double balance;

/// Create a copy of FamilyMemberWallet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FamilyMemberWalletCopyWith<_FamilyMemberWallet> get copyWith => __$FamilyMemberWalletCopyWithImpl<_FamilyMemberWallet>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FamilyMemberWalletToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FamilyMemberWallet&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.role, role) || other.role == role)&&(identical(other.walletId, walletId) || other.walletId == walletId)&&(identical(other.balance, balance) || other.balance == balance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,fullName,avatarUrl,role,walletId,balance);

@override
String toString() {
  return 'FamilyMemberWallet(id: $id, userId: $userId, fullName: $fullName, avatarUrl: $avatarUrl, role: $role, walletId: $walletId, balance: $balance)';
}


}

/// @nodoc
abstract mixin class _$FamilyMemberWalletCopyWith<$Res> implements $FamilyMemberWalletCopyWith<$Res> {
  factory _$FamilyMemberWalletCopyWith(_FamilyMemberWallet value, $Res Function(_FamilyMemberWallet) _then) = __$FamilyMemberWalletCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'full_name') String fullName, String? avatarUrl, String role,@JsonKey(name: 'wallet_id') String? walletId, double balance
});




}
/// @nodoc
class __$FamilyMemberWalletCopyWithImpl<$Res>
    implements _$FamilyMemberWalletCopyWith<$Res> {
  __$FamilyMemberWalletCopyWithImpl(this._self, this._then);

  final _FamilyMemberWallet _self;
  final $Res Function(_FamilyMemberWallet) _then;

/// Create a copy of FamilyMemberWallet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? fullName = null,Object? avatarUrl = freezed,Object? role = null,Object? walletId = freezed,Object? balance = null,}) {
  return _then(_FamilyMemberWallet(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,walletId: freezed == walletId ? _self.walletId : walletId // ignore: cast_nullable_to_non_nullable
as String?,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$MockBankAccount {

 String get id;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'account_number') String get accountNumber; double get balance;// Khớp với 1,000,000 mặc định trong SQL [cite: 44]
@JsonKey(name: 'is_verified') bool get isVerified;@JsonKey(name: 'linked_wallet_id') String? get linkedWalletId;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of MockBankAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MockBankAccountCopyWith<MockBankAccount> get copyWith => _$MockBankAccountCopyWithImpl<MockBankAccount>(this as MockBankAccount, _$identity);

  /// Serializes this MockBankAccount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MockBankAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.linkedWalletId, linkedWalletId) || other.linkedWalletId == linkedWalletId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,accountNumber,balance,isVerified,linkedWalletId,createdAt,updatedAt);

@override
String toString() {
  return 'MockBankAccount(id: $id, userId: $userId, accountNumber: $accountNumber, balance: $balance, isVerified: $isVerified, linkedWalletId: $linkedWalletId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $MockBankAccountCopyWith<$Res>  {
  factory $MockBankAccountCopyWith(MockBankAccount value, $Res Function(MockBankAccount) _then) = _$MockBankAccountCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'account_number') String accountNumber, double balance,@JsonKey(name: 'is_verified') bool isVerified,@JsonKey(name: 'linked_wallet_id') String? linkedWalletId,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$MockBankAccountCopyWithImpl<$Res>
    implements $MockBankAccountCopyWith<$Res> {
  _$MockBankAccountCopyWithImpl(this._self, this._then);

  final MockBankAccount _self;
  final $Res Function(MockBankAccount) _then;

/// Create a copy of MockBankAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? accountNumber = null,Object? balance = null,Object? isVerified = null,Object? linkedWalletId = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,accountNumber: null == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,linkedWalletId: freezed == linkedWalletId ? _self.linkedWalletId : linkedWalletId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MockBankAccount extends MockBankAccount {
  const _MockBankAccount({required this.id, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'account_number') required this.accountNumber, this.balance = 1000000.0, @JsonKey(name: 'is_verified') this.isVerified = false, @JsonKey(name: 'linked_wallet_id') this.linkedWalletId, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt}): super._();
  factory _MockBankAccount.fromJson(Map<String, dynamic> json) => _$MockBankAccountFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'account_number') final  String accountNumber;
@override@JsonKey() final  double balance;
// Khớp với 1,000,000 mặc định trong SQL [cite: 44]
@override@JsonKey(name: 'is_verified') final  bool isVerified;
@override@JsonKey(name: 'linked_wallet_id') final  String? linkedWalletId;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of MockBankAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MockBankAccountCopyWith<_MockBankAccount> get copyWith => __$MockBankAccountCopyWithImpl<_MockBankAccount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MockBankAccountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MockBankAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.linkedWalletId, linkedWalletId) || other.linkedWalletId == linkedWalletId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,accountNumber,balance,isVerified,linkedWalletId,createdAt,updatedAt);

@override
String toString() {
  return 'MockBankAccount(id: $id, userId: $userId, accountNumber: $accountNumber, balance: $balance, isVerified: $isVerified, linkedWalletId: $linkedWalletId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$MockBankAccountCopyWith<$Res> implements $MockBankAccountCopyWith<$Res> {
  factory _$MockBankAccountCopyWith(_MockBankAccount value, $Res Function(_MockBankAccount) _then) = __$MockBankAccountCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'account_number') String accountNumber, double balance,@JsonKey(name: 'is_verified') bool isVerified,@JsonKey(name: 'linked_wallet_id') String? linkedWalletId,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$MockBankAccountCopyWithImpl<$Res>
    implements _$MockBankAccountCopyWith<$Res> {
  __$MockBankAccountCopyWithImpl(this._self, this._then);

  final _MockBankAccount _self;
  final $Res Function(_MockBankAccount) _then;

/// Create a copy of MockBankAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? accountNumber = null,Object? balance = null,Object? isVerified = null,Object? linkedWalletId = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_MockBankAccount(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,accountNumber: null == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,linkedWalletId: freezed == linkedWalletId ? _self.linkedWalletId : linkedWalletId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
