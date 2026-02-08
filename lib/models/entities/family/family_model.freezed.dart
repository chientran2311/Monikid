// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'family_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FamilyMemberWallet {

 String get id;@JsonKey(name: 'user_id') String get userId;// Đổi fullName thành optional hoặc có Default để tránh crash khi join profiles lỗi
@JsonKey(name: 'full_name') String get fullName; String? get avatarUrl; String get role;@JsonKey(name: 'wallet_id') String? get walletId; double get balance;
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
  const _FamilyMemberWallet({required this.id, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'full_name') this.fullName = 'Thành viên', this.avatarUrl, this.role = 'child', @JsonKey(name: 'wallet_id') this.walletId, this.balance = 0.0});
  factory _FamilyMemberWallet.fromJson(Map<String, dynamic> json) => _$FamilyMemberWalletFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
// Đổi fullName thành optional hoặc có Default để tránh crash khi join profiles lỗi
@override@JsonKey(name: 'full_name') final  String fullName;
@override final  String? avatarUrl;
@override@JsonKey() final  String role;
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

// dart format on
