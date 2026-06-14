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

 String get uid; String get role; String get userRole; String get displayName; String? get avatarUrl;
/// Create a copy of FamilyMemberModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FamilyMemberModelCopyWith<FamilyMemberModel> get copyWith => _$FamilyMemberModelCopyWithImpl<FamilyMemberModel>(this as FamilyMemberModel, _$identity);

  /// Serializes this FamilyMemberModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FamilyMemberModel&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.role, role) || other.role == role)&&(identical(other.userRole, userRole) || other.userRole == userRole)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,role,userRole,displayName,avatarUrl);

@override
String toString() {
  return 'FamilyMemberModel(uid: $uid, role: $role, userRole: $userRole, displayName: $displayName, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $FamilyMemberModelCopyWith<$Res>  {
  factory $FamilyMemberModelCopyWith(FamilyMemberModel value, $Res Function(FamilyMemberModel) _then) = _$FamilyMemberModelCopyWithImpl;
@useResult
$Res call({
 String uid, String role, String userRole, String displayName, String? avatarUrl
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
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? role = null,Object? userRole = null,Object? displayName = null,Object? avatarUrl = freezed,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,userRole: null == userRole ? _self.userRole : userRole // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FamilyMemberModel extends FamilyMemberModel {
  const _FamilyMemberModel({required this.uid, this.role = 'member', this.userRole = 'child', this.displayName = '', this.avatarUrl}): super._();
  factory _FamilyMemberModel.fromJson(Map<String, dynamic> json) => _$FamilyMemberModelFromJson(json);

@override final  String uid;
@override@JsonKey() final  String role;
@override@JsonKey() final  String userRole;
@override@JsonKey() final  String displayName;
@override final  String? avatarUrl;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FamilyMemberModel&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.role, role) || other.role == role)&&(identical(other.userRole, userRole) || other.userRole == userRole)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,role,userRole,displayName,avatarUrl);

@override
String toString() {
  return 'FamilyMemberModel(uid: $uid, role: $role, userRole: $userRole, displayName: $displayName, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$FamilyMemberModelCopyWith<$Res> implements $FamilyMemberModelCopyWith<$Res> {
  factory _$FamilyMemberModelCopyWith(_FamilyMemberModel value, $Res Function(_FamilyMemberModel) _then) = __$FamilyMemberModelCopyWithImpl;
@override @useResult
$Res call({
 String uid, String role, String userRole, String displayName, String? avatarUrl
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
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? role = null,Object? userRole = null,Object? displayName = null,Object? avatarUrl = freezed,}) {
  return _then(_FamilyMemberModel(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,userRole: null == userRole ? _self.userRole : userRole // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
