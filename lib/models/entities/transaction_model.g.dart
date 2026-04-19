// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    _TransactionModel(
      transactionId: json['transactionId'] as String,
      userId: json['userId'] as String,
      familyId: json['familyId'] as String?,
      amountMinor: (json['amountMinor'] as num).toInt(),
      currency: json['currency'] as String? ?? 'VND',
      type: json['type'] as String,
      categoryKey: json['categoryKey'] as String,
      categoryLabel: json['categoryLabel'] as String,
      categoryIcon: json['categoryIcon'] as String?,
      note: json['note'] as String?,
      source: json['source'] as String?,
      merchantName: json['merchantName'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      dateTs: DateTime.parse(json['dateTs'] as String),
      createdAt: const TimestampConverter().fromJson(
        json['createdAt'] as Timestamp?,
      ),
      updatedAt: const TimestampConverter().fromJson(
        json['updatedAt'] as Timestamp?,
      ),
      ocrUsed: json['ocrUsed'] as bool?,
      ocrConfidence: (json['ocrConfidence'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TransactionModelToJson(_TransactionModel instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'userId': instance.userId,
      'familyId': instance.familyId,
      'amountMinor': instance.amountMinor,
      'currency': instance.currency,
      'type': instance.type,
      'categoryKey': instance.categoryKey,
      'categoryLabel': instance.categoryLabel,
      'categoryIcon': instance.categoryIcon,
      'note': instance.note,
      'source': instance.source,
      'merchantName': instance.merchantName,
      'paymentMethod': instance.paymentMethod,
      'dateTs': instance.dateTs.toIso8601String(),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'ocrUsed': instance.ocrUsed,
      'ocrConfidence': instance.ocrConfidence,
    };
