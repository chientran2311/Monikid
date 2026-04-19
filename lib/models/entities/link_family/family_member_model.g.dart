// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FamilyMemberModel _$FamilyMemberModelFromJson(Map<String, dynamic> json) =>
    _FamilyMemberModel(
      uid: json['uid'] as String,
      familyId: json['familyId'] as String,
      role: json['role'] as String,
      displayName: json['displayName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      joinedAt: DateTime.parse(json['joinedAt'] as String),
      status: json['status'] as String,
    );

Map<String, dynamic> _$FamilyMemberModelToJson(_FamilyMemberModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'familyId': instance.familyId,
      'role': instance.role,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'joinedAt': instance.joinedAt.toIso8601String(),
      'status': instance.status,
    };
