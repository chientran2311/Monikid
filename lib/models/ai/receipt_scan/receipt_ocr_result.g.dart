// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_ocr_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReceiptOcrResult _$ReceiptOcrResultFromJson(Map<String, dynamic> json) =>
    _ReceiptOcrResult(
      rawText: json['rawText'] as String,
      amountMinor: (json['amountMinor'] as num?)?.toInt(),
      transactionDate: json['transactionDate'] == null
          ? null
          : DateTime.parse(json['transactionDate'] as String),
      merchantName: json['merchantName'] as String?,
      confidence: (json['confidence'] as num?)?.toDouble(),
      senderName: json['senderName'] as String?,
      recipientName: json['recipientName'] as String?,
      description: json['description'] as String?,
      conventionHint: json['conventionHint'] == null
          ? null
          : ReceiptConventionHint.fromJson(
              json['conventionHint'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ReceiptOcrResultToJson(_ReceiptOcrResult instance) =>
    <String, dynamic>{
      'rawText': instance.rawText,
      'amountMinor': instance.amountMinor,
      'transactionDate': instance.transactionDate?.toIso8601String(),
      'merchantName': instance.merchantName,
      'confidence': instance.confidence,
      'senderName': instance.senderName,
      'recipientName': instance.recipientName,
      'description': instance.description,
      'conventionHint': instance.conventionHint,
    };
