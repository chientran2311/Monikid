// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_money_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RequestMoneyModel _$RequestMoneyModelFromJson(Map<String, dynamic> json) =>
    _RequestMoneyModel(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      category: json['category'] as String,
      note: json['note'] as String?,
      recipients: (json['recipients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      familyCode: json['familyCode'] as String,
      studentId: json['studentId'] as String,
    );

Map<String, dynamic> _$RequestMoneyModelToJson(_RequestMoneyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'category': instance.category,
      'note': instance.note,
      'recipients': instance.recipients,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'familyCode': instance.familyCode,
      'studentId': instance.studentId,
    };
