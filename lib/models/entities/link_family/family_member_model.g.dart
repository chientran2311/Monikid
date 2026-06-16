// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FamilyMemberModel _$FamilyMemberModelFromJson(Map<String, dynamic> json) =>
    _FamilyMemberModel(
      uid: json['uid'] as String,
      familyRole: json['familyRole'] as String? ?? 'member',
      userRole: json['userRole'] as String? ?? 'child',
      displayName: json['displayName'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$FamilyMemberModelToJson(_FamilyMemberModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'familyRole': instance.familyRole,
      'userRole': instance.userRole,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
    };
