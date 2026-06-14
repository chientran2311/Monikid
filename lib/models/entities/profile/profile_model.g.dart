// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) =>
    _ProfileModel(
      id: json['id'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      familyId: json['familyId'] as String?,
    );

Map<String, dynamic> _$ProfileModelToJson(_ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'avatarUrl': instance.avatarUrl,
      'fullName': instance.fullName,
      'email': instance.email,
      'role': instance.role,
      'familyId': instance.familyId,
    };
