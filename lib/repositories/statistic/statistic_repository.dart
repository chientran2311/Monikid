import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'statistic_repository.g.dart';

@riverpod
StatisticRepository statisticRepository(Ref ref) {
  return getIt<StatisticRepository>();
}

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

class StatisticRepositoryImpl implements StatisticRepository {
  final FirebaseFirestore _firestore;
  final Logger _logger;

  StatisticRepositoryImpl(this._firestore, this._logger);

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
        .where('dateTs', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfMonth))
        .where('dateTs', isLessThanOrEqualTo: Timestamp.fromDate(endOfMonth))
        .orderBy('dateTs', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map((snapshot) {
      final txs = snapshot.docs.map((doc) {
        return TransactionModel.fromFirestore({
          ...doc.data(),
          if ((doc.data()['transactionId'] as String?) == null) 'transactionId': doc.id,
        });
      }).toList();
      return (transactions: txs, month: month);
    });
  }

  @override
  Stream<({List<TransactionModel> transactions, DateTime start, DateTime end})> getExpenseTransactionsByDateRange(
    String userId,
    DateTime start,
    DateTime end, {
    int? limit,
  }) {
    _logger.i(
      '📡 Listening to expense transactions for user: $userId from ${start.toIso8601String()} to ${end.toIso8601String()}',
    );

    var query = _transactions
        .where('userId', isEqualTo: userId)
        .where('type', isEqualTo: 'expense')
        .where('dateTs', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('dateTs', isLessThanOrEqualTo: Timestamp.fromDate(end))
        .orderBy('dateTs', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map((snapshot) {
      final txs = snapshot.docs.map((doc) {
        return TransactionModel.fromFirestore({
          ...doc.data(),
          if ((doc.data()['transactionId'] as String?) == null) 'transactionId': doc.id,
        });
      }).toList();
      return (transactions: txs, start: start, end: end);
    });
  }
}
