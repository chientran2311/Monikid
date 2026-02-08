

import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_model.freezed.dart';
part 'wallet_model.g.dart';

enum WalletType {
  @JsonValue('parent')
  parent,
  @JsonValue('child')
  child,
}

@freezed
abstract class WalletModel with _$WalletModel {
  const factory WalletModel({
    required String id,
    @JsonKey(name: 'owner_id') required String ownerId,
    @JsonKey(name: 'family_id') String? familyId,
    @JsonKey(name: 'wallet_type') required WalletType walletType,
    @Default(1000000.0) double balance,
    @JsonKey(name: 'is_locked') @Default(false) bool isLocked,
    @JsonKey(name: 'locked_by') String? lockedBy,
    @JsonKey(name: 'locked_at') DateTime? lockedAt,
    @JsonKey(name: 'spending_limit_daily') double? spendingLimitDaily,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    // Statistics
    @JsonKey(name: 'total_transferred') @Default(0.0) double totalTransferred,
    @JsonKey(name: 'total_spent') @Default(0.0) double totalSpent,
    @JsonKey(name: 'total_withdrawn') @Default(0.0) double totalWithdrawn,
    @JsonKey(name: 'total_deposited') @Default(0.0) double totalDeposited,
  }) = _WalletModel;

  factory WalletModel.fromJson(Map<String, dynamic> json) =>
      _$WalletModelFromJson(json);
}

@freezed
abstract class FamilyMemberWallet with _$FamilyMemberWallet {
  const factory FamilyMemberWallet({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'full_name') @Default('Thành viên') String fullName,
    String? avatarUrl,
    required String role,
    @JsonKey(name: 'wallet_id') String? walletId,
    @Default(0.0) double balance, // Sửa từ double? sang double @Default
  }) = _FamilyMemberWallet;

  factory FamilyMemberWallet.fromJson(Map<String, dynamic> json) =>
      _$FamilyMemberWalletFromJson(json);
}

@freezed
abstract class MockBankAccount with _$MockBankAccount {
  const factory MockBankAccount({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'account_number') required String accountNumber,
    @Default(1000000.0) double balance, // Khớp với 1,000,000 mặc định trong SQL [cite: 44]
    @JsonKey(name: 'is_verified') @Default(false) bool isVerified,
    @JsonKey(name: 'linked_wallet_id') String? linkedWalletId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _MockBankAccount;

  const MockBankAccount._();

  factory MockBankAccount.fromJson(Map<String, dynamic> json) =>
      _$MockBankAccountFromJson(json);
  
  // Helper getter for bank name
  String get bankName => 'Mock Bank';
}