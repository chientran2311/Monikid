// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    _TransactionModel(
      transactionId: json['transactionId'] as String,
      userId: json['userId'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] as String,
      category: json['category'] as String,
      categoryEmoji: json['categoryEmoji'] as String?,
      note: json['note'] as String?,
      source: json['source'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      receiptImageUrl: json['receiptImageUrl'] as String?,
      date: DateTime.parse(json['date'] as String),
      createdAt: const TimestampConverter().fromJson(
        json['createdAt'] as Timestamp?,
      ),
      updatedAt: const TimestampConverter().fromJson(
        json['updatedAt'] as Timestamp?,
      ),
      location: json['location'] as String?,
    );

Map<String, dynamic> _$TransactionModelToJson(_TransactionModel instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'userId': instance.userId,
      'amount': instance.amount,
      'type': instance.type,
      'category': instance.category,
      'categoryEmoji': instance.categoryEmoji,
      'note': instance.note,
      'source': instance.source,
      'paymentMethod': instance.paymentMethod,
      'receiptImageUrl': instance.receiptImageUrl,
      'date': instance.date.toIso8601String(),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'location': instance.location,
    };
