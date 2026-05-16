import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/child/statistic/statistic_models.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/repositories/statistic/statistic_repository.dart';

part 'parent_statistic_repository.g.dart';

@riverpod
ParentStatisticRepository parentStatisticRepository(Ref ref) {
  return getIt<ParentStatisticRepository>();
}

class ParentChildOverview {
  const ParentChildOverview({
    required this.totalExpenseMinor,
    required this.prevTotalExpenseMinor,
    required this.dailyData,
    required this.topCategories,
  });

  final int totalExpenseMinor;
  final int prevTotalExpenseMinor;
  final List<StatisticDailyExpenseData> dailyData;
  final List<StatisticCategoryData> topCategories;

  double get percentChange {
    if (prevTotalExpenseMinor == 0) return 0.0;
    return ((totalExpenseMinor - prevTotalExpenseMinor) / prevTotalExpenseMinor) *
        100.0;
  }

  StatisticTrendDirection get trendDirection {
    if (totalExpenseMinor > prevTotalExpenseMinor) {
      return StatisticTrendDirection.up;
    }
    if (totalExpenseMinor < prevTotalExpenseMinor) {
      return StatisticTrendDirection.down;
    }
    return StatisticTrendDirection.stable;
  }
}

abstract class ParentStatisticRepository {
  Future<ParentChildOverview> getChildOverview({
    required String childUid,
    required DateTime anchorDate,
  });

  Future<List<TransactionModel>> getChildTransactionsByCategory({
    required String childUid,
    required String categoryKey,
    required int selectedMonthIndex,
    required DateTime anchorDate,
  });

  Future<TransactionModel?> getChildTransactionById({
    required String childUid,
    required String transactionId,
  });
}

class ParentStatisticRepositoryImpl implements ParentStatisticRepository {
  ParentStatisticRepositoryImpl(this._firestore, this._logger);

  final FirebaseFirestore _firestore;
  final Logger _logger;

  CollectionReference<Map<String, dynamic>> _transactionsOfChild(
    String childUid,
  ) {
    return _firestore
        .collection('users')
        .doc(childUid)
        .collection('transactions');
  }

  DocumentReference<Map<String, dynamic>> _monthlySummaryOfChild(
    String childUid,
    String monthKey,
  ) {
    return _firestore
        .collection('users')
        .doc(childUid)
        .collection('monthly_summaries')
        .doc(monthKey);
  }

  @override
  Future<ParentChildOverview> getChildOverview({
    required String childUid,
    required DateTime anchorDate,
  }) async {
    const monthMode = 1;
    final currentRange = statisticGetPeriodRange(
      selectedMonthIndex: monthMode,
      anchorDate: anchorDate,
    );
    final previousRange = statisticGetPreviousPeriodRange(
      selectedMonthIndex: monthMode,
      anchorDate: anchorDate,
    );
    final currentMonthKey = DateFormat('yyyy-MM').format(anchorDate);

    _logger.i(
      'ParentStatisticRepository: loading overview for child=$childUid '
      'month=$currentMonthKey.',
    );

    try {
      final results = await Future.wait<Object?>([
        _fetchExpenses(childUid, currentRange),
        _fetchExpenses(childUid, previousRange),
        _fetchSummary(childUid, currentMonthKey),
      ]);

      final currentTransactions = results[0]! as List<TransactionModel>;
      final previousTransactions = results[1]! as List<TransactionModel>;
      final summaryData = results[2] as Map<String, dynamic>?;

      final overview = buildStatisticPeriodOverview(
        range: currentRange,
        transactions: currentTransactions,
        previousTransactions: previousTransactions,
        summaryData: summaryData,
      );

      final topCategories = (overview.categories.toList()
            ..sort((a, b) => b.amountMinor.compareTo(a.amountMinor)))
          .take(5)
          .toList(growable: false);

      return ParentChildOverview(
        totalExpenseMinor: overview.totalExpenseMinor,
        prevTotalExpenseMinor: _sumExpenses(previousTransactions),
        dailyData: overview.dailyExpenses,
        topCategories: topCategories,
      );
    } catch (error, stackTrace) {
      _logger.e(
        'ParentStatisticRepository: failed to load overview for child=$childUid.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<List<TransactionModel>> getChildTransactionsByCategory({
    required String childUid,
    required String categoryKey,
    required int selectedMonthIndex,
    required DateTime anchorDate,
  }) async {
    final range = statisticGetPeriodRange(
      selectedMonthIndex: selectedMonthIndex,
      anchorDate: anchorDate,
    );

    _logger.i(
      'ParentStatisticRepository: loading transactions for child=$childUid '
      'category=$categoryKey mode=$selectedMonthIndex.',
    );

    try {
      final snapshot = await _transactionsOfChild(childUid)
          .where('type', isEqualTo: 'expense')
          .where('category_key', isEqualTo: categoryKey)
          .where(
            'date_ts',
            isGreaterThanOrEqualTo: Timestamp.fromDate(range.start),
          )
          .where('date_ts', isLessThanOrEqualTo: Timestamp.fromDate(range.end))
          .orderBy('date_ts', descending: true)
          .get();

      return snapshot.docs.map(_mapTransaction).toList(growable: false);
    } catch (error, stackTrace) {
      _logger.e(
        'ParentStatisticRepository: failed to load transactions for child=$childUid category=$categoryKey.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<TransactionModel?> getChildTransactionById({
    required String childUid,
    required String transactionId,
  }) async {
    _logger.i(
      'ParentStatisticRepository: loading transaction=$transactionId for child=$childUid.',
    );

    try {
      final snapshot = await _transactionsOfChild(childUid).doc(transactionId).get();
      if (!snapshot.exists || snapshot.data() == null) {
        return null;
      }

      final data = snapshot.data()!;
      return TransactionModel.fromFirestore({
        ...data,
        if ((data['transaction_id'] as String?) == null ||
            (data['transaction_id'] as String).isEmpty)
          'transaction_id': snapshot.id,
      });
    } catch (error, stackTrace) {
      _logger.e(
        'ParentStatisticRepository: failed to load transaction=$transactionId for child=$childUid.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<List<TransactionModel>> _fetchExpenses(
    String childUid,
    StatisticDateRange range,
  ) async {
    final snapshot = await _transactionsOfChild(childUid)
        .where('type', isEqualTo: 'expense')
        .where(
          'date_ts',
          isGreaterThanOrEqualTo: Timestamp.fromDate(range.start),
        )
        .where('date_ts', isLessThanOrEqualTo: Timestamp.fromDate(range.end))
        .orderBy('date_ts', descending: true)
        .get();

    return snapshot.docs.map(_mapTransaction).toList(growable: false);
  }

  Future<Map<String, dynamic>?> _fetchSummary(
    String childUid,
    String monthKey,
  ) async {
    try {
      final snapshot = await _monthlySummaryOfChild(childUid, monthKey).get();
      return snapshot.exists ? snapshot.data() : null;
    } catch (error, stackTrace) {
      _logger.w(
        'ParentStatisticRepository: could not load monthly summary child=$childUid month=$monthKey.',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  TransactionModel _mapTransaction(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    return TransactionModel.fromFirestore({
      ...data,
      if ((data['transaction_id'] as String?) == null ||
          (data['transaction_id'] as String).isEmpty)
        'transaction_id': doc.id,
    });
  }

  int _sumExpenses(List<TransactionModel> transactions) {
    return transactions.fold<int>(
      0,
      (total, transaction) => total + transaction.amountMinor,
    );
  }
}