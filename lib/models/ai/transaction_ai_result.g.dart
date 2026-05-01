// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_ai_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionAiResult _$TransactionAiResultFromJson(Map<String, dynamic> json) =>
    _TransactionAiResult(
      amountMinor: (json['amount_minor'] as num).toInt(),
      categoryKey: json['category'] as String,
      note: json['description'] as String,
      transactionDate: json['transaction_date'] as String,
    );

Map<String, dynamic> _$TransactionAiResultToJson(
  _TransactionAiResult instance,
) => <String, dynamic>{
  'amount_minor': instance.amountMinor,
  'category': instance.categoryKey,
  'description': instance.note,
  'transaction_date': instance.transactionDate,
};
