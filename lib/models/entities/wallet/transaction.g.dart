// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Transaction _$TransactionFromJson(Map<String, dynamic> json) => _Transaction(
  id: json['id'] as String,
  familyId: json['family_id'] as String?,
  fromWalletId: json['from_wallet_id'] as String?,
  toWalletId: json['to_wallet_id'] as String?,
  type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
  amount: (json['amount'] as num).toDouble(),
  description: json['description'] as String?,
  merchantName: json['merchant_name'] as String?,
  locationLat: (json['location_lat'] as num?)?.toDouble(),
  locationLng: (json['location_lng'] as num?)?.toDouble(),
  createdBy: json['created_by'] as String?,
  status:
      $enumDecodeNullable(_$TransactionStatusEnumMap, json['status']) ??
      TransactionStatus.completed,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  fromWallet: json['from_wallet'] as Map<String, dynamic>?,
  toWallet: json['to_wallet'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$TransactionToJson(_Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'family_id': instance.familyId,
      'from_wallet_id': instance.fromWalletId,
      'to_wallet_id': instance.toWalletId,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'amount': instance.amount,
      'description': instance.description,
      'merchant_name': instance.merchantName,
      'location_lat': instance.locationLat,
      'location_lng': instance.locationLng,
      'created_by': instance.createdBy,
      'status': _$TransactionStatusEnumMap[instance.status]!,
      'created_at': instance.createdAt?.toIso8601String(),
      'from_wallet': instance.fromWallet,
      'to_wallet': instance.toWallet,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.bankDeposit: 'bank_deposit',
  TransactionType.bankWithdraw: 'bank_withdraw',
  TransactionType.allowance: 'allowance',
  TransactionType.payment: 'payment',
  TransactionType.requestTransfer: 'request_transfer',
};

const _$TransactionStatusEnumMap = {
  TransactionStatus.pending: 'pending',
  TransactionStatus.completed: 'completed',
  TransactionStatus.failed: 'failed',
  TransactionStatus.cancelled: 'cancelled',
};

_CreateTransactionRequest _$CreateTransactionRequestFromJson(
  Map<String, dynamic> json,
) => _CreateTransactionRequest(
  familyId: json['family_id'] as String,
  fromWalletId: json['from_wallet_id'] as String?,
  toWalletId: json['to_wallet_id'] as String?,
  type: json['type'] as String,
  amount: (json['amount'] as num).toDouble(),
  description: json['description'] as String?,
  createdBy: json['created_by'] as String,
);

Map<String, dynamic> _$CreateTransactionRequestToJson(
  _CreateTransactionRequest instance,
) => <String, dynamic>{
  'family_id': instance.familyId,
  'from_wallet_id': instance.fromWalletId,
  'to_wallet_id': instance.toWalletId,
  'type': instance.type,
  'amount': instance.amount,
  'description': instance.description,
  'created_by': instance.createdBy,
};

_MoneyRequest _$MoneyRequestFromJson(Map<String, dynamic> json) =>
    _MoneyRequest(
      id: json['id'] as String,
      fromWalletId: json['from_wallet_id'] as String,
      toWalletId: json['to_wallet_id'] as String,
      amount: (json['amount'] as num).toDouble(),
      reason: json['reason'] as String?,
      status: json['status'] as String? ?? 'pending',
      respondedAt: json['responded_at'] == null
          ? null
          : DateTime.parse(json['responded_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      fromWallet: json['from_wallet'] as Map<String, dynamic>?,
      toWallet: json['to_wallet'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$MoneyRequestToJson(_MoneyRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'from_wallet_id': instance.fromWalletId,
      'to_wallet_id': instance.toWalletId,
      'amount': instance.amount,
      'reason': instance.reason,
      'status': instance.status,
      'responded_at': instance.respondedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'from_wallet': instance.fromWallet,
      'to_wallet': instance.toWallet,
    };
