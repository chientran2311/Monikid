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
mixin _$FamilyModel {

 String get familyId; String get inviteCode;// '' if code not yet created
 String get hostDisplayName;// denormalized host name (child reads)
 String? get hostAvatarUrl;// denormalized host avatar (child reads)
 DateTime get createdAt; DateTime? get updatedAt;
/// Create a copy of FamilyModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FamilyModelCopyWith<FamilyModel> get copyWith => _$FamilyModelCopyWithImpl<FamilyModel>(this as FamilyModel, _$identity);

  /// Serializes this FamilyModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FamilyModel&&(identical(other.familyId, familyId) || other.familyId == familyId)&&(identical(other.inviteCode, inviteCode) || other.inviteCode == inviteCode)&&(identical(other.hostDisplayName, hostDisplayName) || other.hostDisplayName == hostDisplayName)&&(identical(other.hostAvatarUrl, hostAvatarUrl) || other.hostAvatarUrl == hostAvatarUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,familyId,inviteCode,hostDisplayName,hostAvatarUrl,createdAt,updatedAt);

@override
String toString() {
  return 'FamilyModel(familyId: $familyId, inviteCode: $inviteCode, hostDisplayName: $hostDisplayName, hostAvatarUrl: $hostAvatarUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $FamilyModelCopyWith<$Res>  {
  factory $FamilyModelCopyWith(FamilyModel value, $Res Function(FamilyModel) _then) = _$FamilyModelCopyWithImpl;
@useResult
$Res call({
 String familyId, String inviteCode, String hostDisplayName, String? hostAvatarUrl, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$FamilyModelCopyWithImpl<$Res>
    implements $FamilyModelCopyWith<$Res> {
  _$FamilyModelCopyWithImpl(this._self, this._then);

  final FamilyModel _self;
  final $Res Function(FamilyModel) _then;

/// Create a copy of FamilyModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? familyId = null,Object? inviteCode = null,Object? hostDisplayName = null,Object? hostAvatarUrl = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
familyId: null == familyId ? _self.familyId : familyId // ignore: cast_nullable_to_non_nullable
as String,inviteCode: null == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String,hostDisplayName: null == hostDisplayName ? _self.hostDisplayName : hostDisplayName // ignore: cast_nullable_to_non_nullable
as String,hostAvatarUrl: freezed == hostAvatarUrl ? _self.hostAvatarUrl : hostAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FamilyModel implements FamilyModel {
  const _FamilyModel({required this.familyId, required this.inviteCode, required this.hostDisplayName, this.hostAvatarUrl, required this.createdAt, this.updatedAt});
  factory _FamilyModel.fromJson(Map<String, dynamic> json) => _$FamilyModelFromJson(json);

@override final  String familyId;
@override final  String inviteCode;
// '' if code not yet created
@override final  String hostDisplayName;
// denormalized host name (child reads)
@override final  String? hostAvatarUrl;
// denormalized host avatar (child reads)
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of FamilyModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FamilyModelCopyWith<_FamilyModel> get copyWith => __$FamilyModelCopyWithImpl<_FamilyModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FamilyModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FamilyModel&&(identical(other.familyId, familyId) || other.familyId == familyId)&&(identical(other.inviteCode, inviteCode) || other.inviteCode == inviteCode)&&(identical(other.hostDisplayName, hostDisplayName) || other.hostDisplayName == hostDisplayName)&&(identical(other.hostAvatarUrl, hostAvatarUrl) || other.hostAvatarUrl == hostAvatarUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,familyId,inviteCode,hostDisplayName,hostAvatarUrl,createdAt,updatedAt);

@override
String toString() {
  return 'FamilyModel(familyId: $familyId, inviteCode: $inviteCode, hostDisplayName: $hostDisplayName, hostAvatarUrl: $hostAvatarUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$FamilyModelCopyWith<$Res> implements $FamilyModelCopyWith<$Res> {
  factory _$FamilyModelCopyWith(_FamilyModel value, $Res Function(_FamilyModel) _then) = __$FamilyModelCopyWithImpl;
@override @useResult
$Res call({
 String familyId, String inviteCode, String hostDisplayName, String? hostAvatarUrl, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$FamilyModelCopyWithImpl<$Res>
    implements _$FamilyModelCopyWith<$Res> {
  __$FamilyModelCopyWithImpl(this._self, this._then);

  final _FamilyModel _self;
  final $Res Function(_FamilyModel) _then;

/// Create a copy of FamilyModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? familyId = null,Object? inviteCode = null,Object? hostDisplayName = null,Object? hostAvatarUrl = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_FamilyModel(
familyId: null == familyId ? _self.familyId : familyId // ignore: cast_nullable_to_non_nullable
as String,inviteCode: null == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String,hostDisplayName: null == hostDisplayName ? _self.hostDisplayName : hostDisplayName // ignore: cast_nullable_to_non_nullable
as String,hostAvatarUrl: freezed == hostAvatarUrl ? _self.hostAvatarUrl : hostAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
