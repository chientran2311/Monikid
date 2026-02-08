import 'package:monikid/models/entities/wallet/transaction.dart';
import 'package:monikid/models/entities/wallet/wallet_model.dart';

/// Abstract wallet repository interface
abstract class WalletRepository {
  /// Get current user's wallet
  Future<WalletModel?> getMyWallet();

  /// Get wallet by ID
  Future<WalletModel?> getWalletById(String walletId);

  /// Get all family members with their wallets
  Future<List<FamilyMemberWallet>> getFamilyMembersWithWallets(String familyId);

  /// Get user's mock bank account
  Future<MockBankAccount?> getMyBankAccount();

  /// Deposit from bank to wallet
  Future<Transaction> depositFromBank({
    required double amount,
    String? description,
  });

  /// Withdraw from wallet to bank
  Future<Transaction> withdrawToBank({
    required double amount,
    String? description,
  });

  /// Transfer money to another wallet
  Future<Transaction> transfer({
    required String toWalletId,
    required double amount,
    String? description,
  });

  /// Get transaction history
  Future<List<Transaction>> getTransactions({
    String? walletId,
    int limit = 20,
    int offset = 0,
  });

  /// Get transaction by ID
  Future<Transaction?> getTransactionById(String transactionId);

  /// Get pending money requests (for parent)
  Future<List<MoneyRequest>> getPendingRequests();

  /// Request money from parent (for child)
  Future<MoneyRequest> requestMoney({
    required String toWalletId,
    required double amount,
    String? reason,
  });

  /// Approve/deny money request
  Future<MoneyRequest> respondToRequest({
    required String requestId,
    required bool approve,
  });

  /// Create fake family with children accounts
  Future<void> createFakeFamily();
}
