import 'package:monikid/models/entities/transaction_model.dart';

abstract class StatisticRepository {
  /// Retrieves a stream of expense transactions for a specific user within a given month
  Stream<({List<TransactionModel> transactions, DateTime month})> getExpenseTransactionsByMonth(
    String userId,
    DateTime month, {
    int? limit,
  });

  /// Retrieves a stream of expense transactions for a specific user within a given date range
  Stream<({List<TransactionModel> transactions, DateTime start, DateTime end})> getExpenseTransactionsByDateRange(
    String userId,
    DateTime start,
    DateTime end, {
    int? limit,
  });
}
