// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fqa_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FQAModel _$FQAModelFromJson(Map<String, dynamic> json) => _FQAModel(
  id: json['id'] as String,
  question: json['question'] as String,
  answer: json['answer'] as String,
  orderIndex: (json['orderIndex'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$FQAModelToJson(_FQAModel instance) => <String, dynamic>{
  'id': instance.id,
  'question': instance.question,
  'answer': instance.answer,
  'orderIndex': instance.orderIndex,
};
