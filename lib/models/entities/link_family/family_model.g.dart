// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FamilyModel _$FamilyModelFromJson(Map<String, dynamic> json) => _FamilyModel(
  familyId: json['familyId'] as String,
  parentId: json['parentId'] as String,
  parentName: json['parentName'] as String,
  inviteCode: json['inviteCode'] as String,
  inviteCodeExpiresAt: DateTime.parse(json['inviteCodeExpiresAt'] as String),
  childCount: (json['childCount'] as num).toInt(),
  status: json['status'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$FamilyModelToJson(_FamilyModel instance) =>
    <String, dynamic>{
      'familyId': instance.familyId,
      'parentId': instance.parentId,
      'parentName': instance.parentName,
      'inviteCode': instance.inviteCode,
      'inviteCodeExpiresAt': instance.inviteCodeExpiresAt.toIso8601String(),
      'childCount': instance.childCount,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
