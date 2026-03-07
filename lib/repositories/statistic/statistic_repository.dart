import 'package:monikid/models/entities/transaction_model.dart';

abstract class StatisticRepository {
  /// Retrieves a stream of expense transactions for a specific user within a given month
  Stream<({List<TransactionModel> transactions, DateTime month})> getExpenseTransactionsByMonth(
    String userId,
    DateTime month, {
    int? limit,
  });

  /// Retrieves the total expense amount for a specific month
  Future<double> getTotalExpenseByMonth(String userId, DateTime month);
}
