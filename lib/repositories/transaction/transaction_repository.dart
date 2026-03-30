import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_repository.g.dart';

@riverpod
TransactionRepository transactionRepository(Ref ref) {
  return getIt<TransactionRepository>();
}

abstract class TransactionRepository {
  Future<void> addTransaction(TransactionModel transaction);

  Future<void> updateTransaction(TransactionModel transaction);

  Future<void> deleteTransaction(String transactionId);

  Stream<({List<TransactionModel> transactions, DateTime month})> getTransactionsByMonth(
    String userId,
    DateTime month, {
    int? limit,
    String? type,
  });

  Future<List<TransactionModel>> getRecentTransactionsPaginated(
    String userId, {
    TransactionModel? lastTransaction,
    int limit = 4,
  });

  Future<List<TransactionModel>> getTransactionsByFilter(
    String userId, {
    DateTime? date,
    String? category,
    String? type,
    TransactionModel? lastTransaction,
    int limit = 8,
  });

  Future<({double totalIncome, double totalExpense})> getSummary(
    String userId, {
    DateTime? month,
    DateTime? date,
  });

  Stream<({double totalIncome, double totalExpense})> watchSummary(
    String userId, {
    DateTime? month,
    DateTime? date,
  });
}

class TransactionRepositoryImpl implements TransactionRepository {
  TransactionRepositoryImpl(this._firestore, this._logger);

  final FirebaseFirestore _firestore;
  final Logger _logger;

  CollectionReference<Map<String, dynamic>> get _transactions =>
      _firestore.collection('transactions');

  @override
  Future<void> addTransaction(TransactionModel transaction) async {
    try {
      _logger.i('Adding transaction: ${transaction.transactionId}');
      await _transactions
          .doc(transaction.transactionId)
          .set(transaction.toFirestore());
    } catch (e, stackTrace) {
      _logger.e('Error adding transaction', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> updateTransaction(TransactionModel transaction) async {
    try {
      final updatedTransaction = transaction.copyWith(updatedAt: DateTime.now());
      _logger.i('Updating transaction: ${transaction.transactionId}');
      await _transactions
          .doc(transaction.transactionId)
          .update(updatedTransaction.toFirestore());
    } catch (e, stackTrace) {
      _logger.e('Error updating transaction', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> deleteTransaction(String transactionId) async {
    try {
      _logger.i('Deleting transaction: $transactionId');
      await _transactions.doc(transactionId).delete();
    } catch (e, stackTrace) {
      _logger.e('Error deleting transaction', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Stream<({List<TransactionModel> transactions, DateTime month})> getTransactionsByMonth(
    String userId,
    DateTime month, {
    int? limit,
    String? type,
  }) {
    final range = _monthRange(month);

    Query<Map<String, dynamic>> query = _transactions
        .where('userId', isEqualTo: userId)
        .where('dateTs', isGreaterThanOrEqualTo: Timestamp.fromDate(range.start))
        .where('dateTs', isLessThanOrEqualTo: Timestamp.fromDate(range.end))
        .orderBy('dateTs', descending: true);

    if (type != null && type != 'all') {
      query = query.where('type', isEqualTo: type);
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map((snapshot) {
      final transactions = snapshot.docs.map(_mapTransaction).toList();
      return (transactions: transactions, month: month);
    }).handleError((error, stackTrace) {
      _logger.e(
        'Error listening transactions by month',
        error: error,
        stackTrace: stackTrace,
      );
      throw error;
    });
  }

  @override
  Future<List<TransactionModel>> getRecentTransactionsPaginated(
    String userId, {
    TransactionModel? lastTransaction,
    int limit = 4,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _transactions
          .where('userId', isEqualTo: userId)
          .orderBy('dateTs', descending: true)
          .limit(limit);

      if (lastTransaction != null) {
        query = query.startAfter([Timestamp.fromDate(lastTransaction.date)]);
      }

      final snapshot = await query.get();
      return snapshot.docs.map(_mapTransaction).toList();
    } catch (e, stackTrace) {
      _logger.e(
        'Error fetching recent transactions',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<List<TransactionModel>> getTransactionsByFilter(
    String userId, {
    DateTime? date,
    String? category,
    String? type,
    TransactionModel? lastTransaction,
    int limit = 8,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _transactions.where(
        'userId',
        isEqualTo: userId,
      );

      if (date != null) {
        final range = _dayRange(date);
        query = query
            .where('dateTs', isGreaterThanOrEqualTo: Timestamp.fromDate(range.start))
            .where('dateTs', isLessThanOrEqualTo: Timestamp.fromDate(range.end));
      }

      if (category != null && category.isNotEmpty) {
        query = query.where('category', isEqualTo: category);
      }

      if (type != null && type != 'all') {
        query = query.where('type', isEqualTo: type);
      }

      query = query.orderBy('dateTs', descending: true).limit(limit);

      if (lastTransaction != null) {
        query = query.startAfter([Timestamp.fromDate(lastTransaction.date)]);
      }

      final snapshot = await query.get();
      return snapshot.docs.map(_mapTransaction).toList();
    } catch (e, stackTrace) {
      _logger.e(
        'Error fetching transactions by filter',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<({double totalIncome, double totalExpense})> getSummary(
    String userId, {
    DateTime? month,
    DateTime? date,
  }) async {
    try {
      final snapshot = await _buildSummaryQuery(
        userId,
        month: month,
        date: date,
      ).get();
      return _sumTransactions(snapshot.docs.map(_mapTransaction));
    } catch (e, stackTrace) {
      _logger.e('Error getting summary', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Stream<({double totalIncome, double totalExpense})> watchSummary(
    String userId, {
    DateTime? month,
    DateTime? date,
  }) {
    return _buildSummaryQuery(userId, month: month, date: date)
        .snapshots()
        .map((snapshot) => _sumTransactions(snapshot.docs.map(_mapTransaction)));
  }

  Query<Map<String, dynamic>> _buildSummaryQuery(
    String userId, {
    DateTime? month,
    DateTime? date,
  }) {
    Query<Map<String, dynamic>> query = _transactions.where(
      'userId',
      isEqualTo: userId,
    );

    if (date != null) {
      final range = _dayRange(date);
      query = query
          .where('dateTs', isGreaterThanOrEqualTo: Timestamp.fromDate(range.start))
          .where('dateTs', isLessThanOrEqualTo: Timestamp.fromDate(range.end));
    } else if (month != null) {
      final range = _monthRange(month);
      query = query
          .where('dateTs', isGreaterThanOrEqualTo: Timestamp.fromDate(range.start))
          .where('dateTs', isLessThanOrEqualTo: Timestamp.fromDate(range.end));
    }

    return query.orderBy('dateTs', descending: true);
  }

  TransactionModel _mapTransaction(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return TransactionModel.fromFirestore({
      ...data,
      if ((data['transactionId'] as String?) == null || (data['transactionId'] as String).isEmpty)
        'transactionId': doc.id,
    });
  }

  ({double totalIncome, double totalExpense}) _sumTransactions(
    Iterable<TransactionModel> transactions,
  ) {
    double totalIncome = 0;
    double totalExpense = 0;

    for (final transaction in transactions) {
      if (transaction.type == 'income') {
        totalIncome += transaction.amount;
      } else {
        totalExpense += transaction.amount;
      }
    }

    return (totalIncome: totalIncome, totalExpense: totalExpense);
  }

  ({DateTime start, DateTime end}) _dayRange(DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
    return (start: start, end: end);
  }

  ({DateTime start, DateTime end}) _monthRange(DateTime month) {
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 0, 23, 59, 59, 999);
    return (start: start, end: end);
  }
}
