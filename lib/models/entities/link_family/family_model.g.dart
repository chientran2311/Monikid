// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FamilyModel _$FamilyModelFromJson(Map<String, dynamic> json) => _FamilyModel(
  familyId: json['familyId'] as String,
  inviteCode: json['inviteCode'] as String,
  hostDisplayName: json['hostDisplayName'] as String,
  hostAvatarUrl: json['hostAvatarUrl'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$FamilyModelToJson(_FamilyModel instance) =>
    <String, dynamic>{
      'familyId': instance.familyId,
      'inviteCode': instance.inviteCode,
      'hostDisplayName': instance.hostDisplayName,
      'hostAvatarUrl': instance.hostAvatarUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
