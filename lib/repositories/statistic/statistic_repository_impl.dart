import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'statistic_repository.dart';

@LazySingleton(as: StatisticRepository)
class StatisticRepositoryImpl implements StatisticRepository {
  final FirebaseFirestore _firestore;
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 50,
      colors: true,
      printEmojis: true,
    ),
  );

  StatisticRepositoryImpl(this._firestore);

  CollectionReference<Map<String, dynamic>> get _transactions =>
      _firestore.collection('transactions');

  @override
  Stream<({List<TransactionModel> transactions, DateTime month})> getExpenseTransactionsByMonth(
    String userId,
    DateTime month, {
    int? limit,
  }) {
    _logger.i(
      '📡 Listening to expense transactions for user: $userId in month: ${month.month}/${month.year}',
    );

    final startOfMonth = DateTime(month.year, month.month, 1);
    final endOfMonth = DateTime(
      month.year,
      month.month + 1,
      0,
      23,
      59,
      59,
      999,
    );

    var query = _transactions
        .where('userId', isEqualTo: userId)
        .where('type', isEqualTo: 'expense')
        .where('date', isGreaterThanOrEqualTo: startOfMonth.toIso8601String())
        .where('date', isLessThanOrEqualTo: endOfMonth.toIso8601String())
        .orderBy('date', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map((snapshot) {
      final txs = snapshot.docs.map((doc) {
        return TransactionModel.fromJson(doc.data());
      }).toList();
      return (transactions: txs, month: month);
    });
  }

  @override
  Future<double> getTotalExpenseByMonth(String userId, DateTime month) async {
    try {
      _logger.i('📊 getTotalExpenseByMonth: $userId | ${month.month}/${month.year}');

      final startOfMonth = DateTime(month.year, month.month, 1);
      final endOfMonth = DateTime(
        month.year,
        month.month + 1,
        0,
        23,
        59,
        59,
        999,
      );

      final snapshot = await _transactions
          .where('userId', isEqualTo: userId)
          .where('type', isEqualTo: 'expense')
          .where('date', isGreaterThanOrEqualTo: startOfMonth.toIso8601String())
          .where('date', isLessThanOrEqualTo: endOfMonth.toIso8601String())
          .get();

      double totalExpense = 0;
      for (final doc in snapshot.docs) {
        final tx = TransactionModel.fromJson(doc.data());
        totalExpense += tx.amount;
      }

      _logger.i('✅ Total expense for ${month.month}/${month.year}: $totalExpense');
      return totalExpense;
    } catch (e) {
      _logger.e('❌ getTotalExpenseByMonth failed: $e');
      rethrow;
    }
  }
}
