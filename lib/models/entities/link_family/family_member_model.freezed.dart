// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'family_member_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FamilyMemberModel {

 String get uid; String get familyId; String get role;// parent, child
 String get displayName; String? get avatarUrl; DateTime get joinedAt; String get status;
/// Create a copy of FamilyMemberModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FamilyMemberModelCopyWith<FamilyMemberModel> get copyWith => _$FamilyMemberModelCopyWithImpl<FamilyMemberModel>(this as FamilyMemberModel, _$identity);

  /// Serializes this FamilyMemberModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FamilyMemberModel&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.familyId, familyId) || other.familyId == familyId)&&(identical(other.role, role) || other.role == role)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,familyId,role,displayName,avatarUrl,joinedAt,status);

@override
String toString() {
  return 'FamilyMemberModel(uid: $uid, familyId: $familyId, role: $role, displayName: $displayName, avatarUrl: $avatarUrl, joinedAt: $joinedAt, status: $status)';
}


}

/// @nodoc
abstract mixin class $FamilyMemberModelCopyWith<$Res>  {
  factory $FamilyMemberModelCopyWith(FamilyMemberModel value, $Res Function(FamilyMemberModel) _then) = _$FamilyMemberModelCopyWithImpl;
@useResult
$Res call({
 String uid, String familyId, String role, String displayName, String? avatarUrl, DateTime joinedAt, String status
});




}
/// @nodoc
class _$FamilyMemberModelCopyWithImpl<$Res>
    implements $FamilyMemberModelCopyWith<$Res> {
  _$FamilyMemberModelCopyWithImpl(this._self, this._then);

  final FamilyMemberModel _self;
  final $Res Function(FamilyMemberModel) _then;

/// Create a copy of FamilyMemberModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? familyId = null,Object? role = null,Object? displayName = null,Object? avatarUrl = freezed,Object? joinedAt = null,Object? status = null,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,familyId: null == familyId ? _self.familyId : familyId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FamilyMemberModel implements FamilyMemberModel {
  const _FamilyMemberModel({required this.uid, required this.familyId, required this.role, required this.displayName, this.avatarUrl, required this.joinedAt, required this.status});
  factory _FamilyMemberModel.fromJson(Map<String, dynamic> json) => _$FamilyMemberModelFromJson(json);

@override final  String uid;
@override final  String familyId;
@override final  String role;
// parent, child
@override final  String displayName;
@override final  String? avatarUrl;
@override final  DateTime joinedAt;
@override final  String status;

/// Create a copy of FamilyMemberModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FamilyMemberModelCopyWith<_FamilyMemberModel> get copyWith => __$FamilyMemberModelCopyWithImpl<_FamilyMemberModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FamilyMemberModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FamilyMemberModel&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.familyId, familyId) || other.familyId == familyId)&&(identical(other.role, role) || other.role == role)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,familyId,role,displayName,avatarUrl,joinedAt,status);

@override
String toString() {
  return 'FamilyMemberModel(uid: $uid, familyId: $familyId, role: $role, displayName: $displayName, avatarUrl: $avatarUrl, joinedAt: $joinedAt, status: $status)';
}


}

/// @nodoc
abstract mixin class _$FamilyMemberModelCopyWith<$Res> implements $FamilyMemberModelCopyWith<$Res> {
  factory _$FamilyMemberModelCopyWith(_FamilyMemberModel value, $Res Function(_FamilyMemberModel) _then) = __$FamilyMemberModelCopyWithImpl;
@override @useResult
$Res call({
 String uid, String familyId, String role, String displayName, String? avatarUrl, DateTime joinedAt, String status
});




}
/// @nodoc
class __$FamilyMemberModelCopyWithImpl<$Res>
    implements _$FamilyMemberModelCopyWith<$Res> {
  __$FamilyMemberModelCopyWithImpl(this._self, this._then);

  final _FamilyMemberModel _self;
  final $Res Function(_FamilyMemberModel) _then;

/// Create a copy of FamilyMemberModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? familyId = null,Object? role = null,Object? displayName = null,Object? avatarUrl = freezed,Object? joinedAt = null,Object? status = null,}) {
  return _then(_FamilyMemberModel(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,familyId: null == familyId ? _self.familyId : familyId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
