import 'package:monikid/models/entities/transaction_model.dart';

abstract class TransactionRepository {
  /// Adds a new transaction to the database
  Future<void> addTransaction(TransactionModel transaction);

  /// Updates an existing transaction
  Future<void> updateTransaction(TransactionModel transaction);

  /// Deletes a transaction by its ID
  Future<void> deleteTransaction(String transactionId);

  /// Retrieves a stream of transactions for a specific user within a given month
  Stream<({List<TransactionModel> transactions, DateTime month})> getTransactionsByMonth(
    String userId,
    DateTime month, {
    int? limit,
    String? type,
  });

  /// Retrieves a paginated list of recent transactions
  Future<List<TransactionModel>> getRecentTransactionsPaginated(
    String userId, {
    TransactionModel? lastTransaction,
    int limit = 4,
  });

  /// Retrieves a paginated list of transactions filtered by exact date and optional category/type
  /// Page size is 8 items.
  Future<List<TransactionModel>> getTransactionsByFilter(
    String userId, {
    DateTime? date,
    String? category,
    String? type,
    TransactionModel? lastTransaction,
    int limit = 8,
  });

  /// Tính tổng thu và chi theo tháng (nếu month != null) hoặc theo ngày (nếu date != null).
  Future<({double totalIncome, double totalExpense})> getSummary(
    String userId, {
    DateTime? month,
    DateTime? date,
  });

  /// Theo dõi realtime tổng thu chi
  Stream<({double totalIncome, double totalExpense})> watchSummary(
    String userId, {
    DateTime? month,
    DateTime? date,
  });
}
