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

 String get familyId; String get parentId; String get parentName; String get inviteCode; DateTime get inviteCodeExpiresAt; int get childCount; String get status; DateTime get createdAt; DateTime? get updatedAt;
/// Create a copy of FamilyModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FamilyModelCopyWith<FamilyModel> get copyWith => _$FamilyModelCopyWithImpl<FamilyModel>(this as FamilyModel, _$identity);

  /// Serializes this FamilyModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FamilyModel&&(identical(other.familyId, familyId) || other.familyId == familyId)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.parentName, parentName) || other.parentName == parentName)&&(identical(other.inviteCode, inviteCode) || other.inviteCode == inviteCode)&&(identical(other.inviteCodeExpiresAt, inviteCodeExpiresAt) || other.inviteCodeExpiresAt == inviteCodeExpiresAt)&&(identical(other.childCount, childCount) || other.childCount == childCount)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,familyId,parentId,parentName,inviteCode,inviteCodeExpiresAt,childCount,status,createdAt,updatedAt);

@override
String toString() {
  return 'FamilyModel(familyId: $familyId, parentId: $parentId, parentName: $parentName, inviteCode: $inviteCode, inviteCodeExpiresAt: $inviteCodeExpiresAt, childCount: $childCount, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $FamilyModelCopyWith<$Res>  {
  factory $FamilyModelCopyWith(FamilyModel value, $Res Function(FamilyModel) _then) = _$FamilyModelCopyWithImpl;
@useResult
$Res call({
 String familyId, String parentId, String parentName, String inviteCode, DateTime inviteCodeExpiresAt, int childCount, String status, DateTime createdAt, DateTime? updatedAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? familyId = null,Object? parentId = null,Object? parentName = null,Object? inviteCode = null,Object? inviteCodeExpiresAt = null,Object? childCount = null,Object? status = null,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
familyId: null == familyId ? _self.familyId : familyId // ignore: cast_nullable_to_non_nullable
as String,parentId: null == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String,parentName: null == parentName ? _self.parentName : parentName // ignore: cast_nullable_to_non_nullable
as String,inviteCode: null == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String,inviteCodeExpiresAt: null == inviteCodeExpiresAt ? _self.inviteCodeExpiresAt : inviteCodeExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,childCount: null == childCount ? _self.childCount : childCount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FamilyModel implements FamilyModel {
  const _FamilyModel({required this.familyId, required this.parentId, required this.parentName, required this.inviteCode, required this.inviteCodeExpiresAt, required this.childCount, required this.status, required this.createdAt, this.updatedAt});
  factory _FamilyModel.fromJson(Map<String, dynamic> json) => _$FamilyModelFromJson(json);

@override final  String familyId;
@override final  String parentId;
@override final  String parentName;
@override final  String inviteCode;
@override final  DateTime inviteCodeExpiresAt;
@override final  int childCount;
@override final  String status;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FamilyModel&&(identical(other.familyId, familyId) || other.familyId == familyId)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.parentName, parentName) || other.parentName == parentName)&&(identical(other.inviteCode, inviteCode) || other.inviteCode == inviteCode)&&(identical(other.inviteCodeExpiresAt, inviteCodeExpiresAt) || other.inviteCodeExpiresAt == inviteCodeExpiresAt)&&(identical(other.childCount, childCount) || other.childCount == childCount)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,familyId,parentId,parentName,inviteCode,inviteCodeExpiresAt,childCount,status,createdAt,updatedAt);

@override
String toString() {
  return 'FamilyModel(familyId: $familyId, parentId: $parentId, parentName: $parentName, inviteCode: $inviteCode, inviteCodeExpiresAt: $inviteCodeExpiresAt, childCount: $childCount, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$FamilyModelCopyWith<$Res> implements $FamilyModelCopyWith<$Res> {
  factory _$FamilyModelCopyWith(_FamilyModel value, $Res Function(_FamilyModel) _then) = __$FamilyModelCopyWithImpl;
@override @useResult
$Res call({
 String familyId, String parentId, String parentName, String inviteCode, DateTime inviteCodeExpiresAt, int childCount, String status, DateTime createdAt, DateTime? updatedAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? familyId = null,Object? parentId = null,Object? parentName = null,Object? inviteCode = null,Object? inviteCodeExpiresAt = null,Object? childCount = null,Object? status = null,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_FamilyModel(
familyId: null == familyId ? _self.familyId : familyId // ignore: cast_nullable_to_non_nullable
as String,parentId: null == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String,parentName: null == parentName ? _self.parentName : parentName // ignore: cast_nullable_to_non_nullable
as String,inviteCode: null == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String,inviteCodeExpiresAt: null == inviteCodeExpiresAt ? _self.inviteCodeExpiresAt : inviteCodeExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,childCount: null == childCount ? _self.childCount : childCount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
