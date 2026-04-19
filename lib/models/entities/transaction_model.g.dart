// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionEvidenceImage _$TransactionEvidenceImageFromJson(
  Map<String, dynamic> json,
) => _TransactionEvidenceImage(
  storagePath: json['storagePath'] as String,
  fileName: json['fileName'] as String?,
  mimeType: json['mimeType'] as String?,
  uploadedAt: const TimestampConverter().fromJson(
    json['uploadedAt'] as Timestamp?,
  ),
);

Map<String, dynamic> _$TransactionEvidenceImageToJson(
  _TransactionEvidenceImage instance,
) => <String, dynamic>{
  'storagePath': instance.storagePath,
  'fileName': instance.fileName,
  'mimeType': instance.mimeType,
  'uploadedAt': const TimestampConverter().toJson(instance.uploadedAt),
};

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
      evidenceImage: json['evidenceImage'] == null
          ? null
          : TransactionEvidenceImage.fromJson(
              json['evidenceImage'] as Map<String, dynamic>,
            ),
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
      'evidenceImage': instance.evidenceImage,
    };
