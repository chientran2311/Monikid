// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FamilyMemberWallet _$FamilyMemberWalletFromJson(Map<String, dynamic> json) =>
    _FamilyMemberWallet(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      fullName: json['full_name'] as String? ?? 'Thành viên',
      avatarUrl: json['avatarUrl'] as String?,
      role: json['role'] as String? ?? 'child',
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
