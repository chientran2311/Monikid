import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

/// Transaction types matching Supabase schema
enum TransactionType {
  @JsonValue('bank_deposit')
  bankDeposit,
  @JsonValue('bank_withdraw')
  bankWithdraw,
  @JsonValue('allowance')
  allowance,
  @JsonValue('payment')
  payment,
  @JsonValue('request_transfer')
  requestTransfer,
}

/// Transaction status
enum TransactionStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('completed')
  completed,
  @JsonValue('failed')
  failed,
  @JsonValue('cancelled')
  cancelled,
}

/// Transaction model matching Supabase schema
@freezed
abstract class Transaction with _$Transaction {
  const factory Transaction({
    required String id,
    @JsonKey(name: 'family_id') String? familyId,
    @JsonKey(name: 'from_wallet_id') String? fromWalletId,
    @JsonKey(name: 'to_wallet_id') String? toWalletId,
    required TransactionType type,
    required double amount,
    String? description,
    @JsonKey(name: 'merchant_name') String? merchantName,
    @JsonKey(name: 'location_lat') double? locationLat,
    @JsonKey(name: 'location_lng') double? locationLng,
    @JsonKey(name: 'created_by') String? createdBy,
    @Default(TransactionStatus.completed) TransactionStatus status,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    // Additional fields for UI display
    @JsonKey(name: 'from_wallet') Map<String, dynamic>? fromWallet,
    @JsonKey(name: 'to_wallet') Map<String, dynamic>? toWallet,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}

/// Create transaction request DTO
@freezed
abstract class CreateTransactionRequest with _$CreateTransactionRequest {
  const factory CreateTransactionRequest({
    @JsonKey(name: 'family_id') required String familyId,
    @JsonKey(name: 'from_wallet_id') String? fromWalletId,
    @JsonKey(name: 'to_wallet_id') String? toWalletId,
    required String type,
    required double amount,
    String? description,
    @JsonKey(name: 'created_by') required String createdBy,
  }) = _CreateTransactionRequest;

  factory CreateTransactionRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateTransactionRequestFromJson(json);
}

/// Money request model
@freezed
abstract class MoneyRequest with _$MoneyRequest {
  const factory MoneyRequest({
    required String id,
    @JsonKey(name: 'from_wallet_id') required String fromWalletId,
    @JsonKey(name: 'to_wallet_id') required String toWalletId,
    required double amount,
    String? reason,
    @Default('pending') String status,
    @JsonKey(name: 'responded_at') DateTime? respondedAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    // Additional fields for UI display
    @JsonKey(name: 'from_wallet') Map<String, dynamic>? fromWallet,
    @JsonKey(name: 'to_wallet') Map<String, dynamic>? toWallet,
  }) = _MoneyRequest;

  factory MoneyRequest.fromJson(Map<String, dynamic> json) =>
      _$MoneyRequestFromJson(json);
}
