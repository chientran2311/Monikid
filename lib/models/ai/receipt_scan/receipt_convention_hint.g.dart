// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_convention_hint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReceiptConventionHint _$ReceiptConventionHintFromJson(
  Map<String, dynamic> json,
) => _ReceiptConventionHint(
  purpose: json['purpose'] as String?,
  merchant: json['merchant'] as String?,
  categoryHint: json['category_hint'] as String?,
);

Map<String, dynamic> _$ReceiptConventionHintToJson(
  _ReceiptConventionHint instance,
) => <String, dynamic>{
  'purpose': instance.purpose,
  'merchant': instance.merchant,
  'category_hint': instance.categoryHint,
};
