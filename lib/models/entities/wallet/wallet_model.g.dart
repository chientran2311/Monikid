// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WalletModel _$WalletModelFromJson(Map<String, dynamic> json) => _WalletModel(
  id: json['id'] as String,
  ownerId: json['owner_id'] as String,
  familyId: json['family_id'] as String?,
  walletType: $enumDecode(_$WalletTypeEnumMap, json['wallet_type']),
  balance: (json['balance'] as num?)?.toDouble() ?? 1000000.0,
  isLocked: json['is_locked'] as bool? ?? false,
  lockedBy: json['locked_by'] as String?,
  lockedAt: json['locked_at'] == null
      ? null
      : DateTime.parse(json['locked_at'] as String),
  spendingLimitDaily: (json['spending_limit_daily'] as num?)?.toDouble(),
  createdBy: json['created_by'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  totalTransferred: (json['total_transferred'] as num?)?.toDouble() ?? 0.0,
  totalSpent: (json['total_spent'] as num?)?.toDouble() ?? 0.0,
  totalWithdrawn: (json['total_withdrawn'] as num?)?.toDouble() ?? 0.0,
  totalDeposited: (json['total_deposited'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$WalletModelToJson(_WalletModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'owner_id': instance.ownerId,
      'family_id': instance.familyId,
      'wallet_type': _$WalletTypeEnumMap[instance.walletType]!,
      'balance': instance.balance,
      'is_locked': instance.isLocked,
      'locked_by': instance.lockedBy,
      'locked_at': instance.lockedAt?.toIso8601String(),
      'spending_limit_daily': instance.spendingLimitDaily,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'total_transferred': instance.totalTransferred,
      'total_spent': instance.totalSpent,
      'total_withdrawn': instance.totalWithdrawn,
      'total_deposited': instance.totalDeposited,
    };

const _$WalletTypeEnumMap = {
  WalletType.parent: 'parent',
  WalletType.child: 'child',
};

_FamilyMemberWallet _$FamilyMemberWalletFromJson(Map<String, dynamic> json) =>
    _FamilyMemberWallet(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      fullName: json['full_name'] as String? ?? 'Thành viên',
      avatarUrl: json['avatarUrl'] as String?,
      role: json['role'] as String,
      walletId: json['wallet_id'] as String?,
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$FamilyMemberWalletToJson(_FamilyMemberWallet instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'full_name': instance.fullName,
      'avatarUrl': instance.avatarUrl,
      'role': instance.role,
      'wallet_id': instance.walletId,
      'balance': instance.balance,
    };

_MockBankAccount _$MockBankAccountFromJson(Map<String, dynamic> json) =>
    _MockBankAccount(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      accountNumber: json['account_number'] as String,
      balance: (json['balance'] as num?)?.toDouble() ?? 1000000.0,
      isVerified: json['is_verified'] as bool? ?? false,
      linkedWalletId: json['linked_wallet_id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$MockBankAccountToJson(_MockBankAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'account_number': instance.accountNumber,
      'balance': instance.balance,
      'is_verified': instance.isVerified,
      'linked_wallet_id': instance.linkedWalletId,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
