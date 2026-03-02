import 'package:monikid/models/entities/transaction_model.dart';

abstract class TransactionRepository {
  /// Adds a new transaction to the database
  Future<void> addTransaction(TransactionModel transaction);

  /// Updates an existing transaction
  Future<void> updateTransaction(TransactionModel transaction);

  /// Deletes a transaction by its ID
  Future<void> deleteTransaction(String transactionId);

  /// Retrieves a stream of all transactions for a specific user
  Stream<List<TransactionModel>> getTransactions(String userId);

  /// Retrieves a stream of transactions for a specific user within a given month
  Stream<List<TransactionModel>> getTransactionsByMonth(
    String userId,
    DateTime month,
  );

  /// Retrieves a paginated list of recent transactions
  Future<List<TransactionModel>> getRecentTransactionsPaginated(
    String userId, {
    TransactionModel? lastTransaction,
    int limit = 4,
  });

  /// Retrieves a paginated list of transactions filtered by exact date and optional category
  /// Page size is 8 items.
  Future<List<TransactionModel>> getTransactionsByDateAndCategory(
    String userId, {
    DateTime? date,
    String? category,
    TransactionModel? lastTransaction,
    int limit = 8,
  });
}
