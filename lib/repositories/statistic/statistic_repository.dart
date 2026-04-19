import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/student/statistic/statistic_models.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'statistic_repository.g.dart';

typedef StatisticTransactionPageResult = ({
  List<TransactionModel> transactions,
  bool hasMore,
});

@riverpod
StatisticRepository statisticRepository(Ref ref) {
  return getIt<StatisticRepository>();
}

abstract class StatisticRepository {
  Future<StatisticOverviewData?> getOverview({
    required String userId,
    required int selectedMonthIndex,
    required DateTime anchorDate,
  });

  Future<StatisticTransactionPageResult> getExpenseTransactionsPage({
    required String userId,
    required DateTime start,
    required DateTime end,
    TransactionModel? lastTransaction,
    int limit = 8,
  });
}

class StatisticRepositoryImpl implements StatisticRepository {
  StatisticRepositoryImpl(this._firestore, this._logger);

  final FirebaseFirestore _firestore;
  final Logger _logger;

  CollectionReference<Map<String, dynamic>> _transactionsOfUser(String userId) {
    return _firestore.collection('users').doc(userId).collection('transactions');
  }

  DocumentReference<Map<String, dynamic>> _monthlySummaryOfUser(
    String userId,
    DateTime month,
  ) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('monthly_summaries')
        .doc(_monthKey(month));
  }

  @override
  Future<StatisticOverviewData?> getOverview({
    required String userId,
    required int selectedMonthIndex,
    required DateTime anchorDate,
  }) async {
    final currentRange = statisticGetPeriodRange(
      selectedMonthIndex: selectedMonthIndex,
      anchorDate: anchorDate,
    );
    final previousRange = statisticGetPreviousPeriodRange(
      selectedMonthIndex: selectedMonthIndex,
      anchorDate: anchorDate,
    );

    try {
      _logger.i(
        'Loading statistic overview for userId=$userId '
        'mode=$selectedMonthIndex '
        'start=${currentRange.start.toIso8601String()} '
        'end=${currentRange.end.toIso8601String()}.',
      );

      final results = await Future.wait<Object?>([
        _fetchExpenseTransactionsForRange(
          userId: userId,
          start: currentRange.start,
          end: currentRange.end,
        ),
        _fetchExpenseTransactionsForRange(
          userId: userId,
          start: previousRange.start,
          end: previousRange.end,
        ),
        selectedMonthIndex == 1
            ? _fetchMonthlySummary(userId: userId, month: currentRange.start)
            : Future.value(null),
        selectedMonthIndex == 1
            ? _fetchMonthlySummary(userId: userId, month: previousRange.start)
            : Future.value(null),
      ]);

      final currentTransactions = results[0]! as List<TransactionModel>;
      final previousTransactions = results[1]! as List<TransactionModel>;
      final currentSummary = results[2] as Map<String, dynamic>?;
      final previousSummary = results[3] as Map<String, dynamic>?;

      final currentOverview = buildStatisticPeriodOverview(
        range: currentRange,
        transactions: currentTransactions,
        previousTransactions: previousTransactions,
        summaryData: currentSummary,
      );
      final previousOverview = buildStatisticPeriodOverview(
        range: previousRange,
        transactions: previousTransactions,
        previousTransactions: const [],
        summaryData: previousSummary,
      );

      return StatisticOverviewData(
        currentPeriod: currentOverview,
        previousPeriod: previousOverview,
        currentTransactions: currentTransactions,
        previousTransactions: previousTransactions,
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to load statistic overview.',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  @override
  Future<StatisticTransactionPageResult> getExpenseTransactionsPage({
    required String userId,
    required DateTime start,
    required DateTime end,
    TransactionModel? lastTransaction,
    int limit = 8,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _transactionsOfUser(userId)
          .where('type', isEqualTo: 'expense')
          .where('date_ts', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
          .where('date_ts', isLessThanOrEqualTo: Timestamp.fromDate(end))
          .orderBy('date_ts', descending: true)
          .limit(limit + 1);

      if (lastTransaction != null) {
        query = query.startAfter([Timestamp.fromDate(lastTransaction.dateTs)]);
      }

      final snapshot = await query.get();
      final allTransactions = snapshot.docs.map(_mapTransaction).toList();
      final hasMore = allTransactions.length > limit;
      final transactions = hasMore
          ? allTransactions.take(limit).toList(growable: false)
          : allTransactions;

      return (transactions: transactions, hasMore: hasMore);
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to load statistic transaction page.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<List<TransactionModel>> _fetchExpenseTransactionsForRange({
    required String userId,
    required DateTime start,
    required DateTime end,
  }) async {
    final snapshot = await _transactionsOfUser(userId)
        .where('type', isEqualTo: 'expense')
        .where('date_ts', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('date_ts', isLessThanOrEqualTo: Timestamp.fromDate(end))
        .orderBy('date_ts', descending: true)
        .get();

    return snapshot.docs.map(_mapTransaction).toList(growable: false);
  }

  Future<Map<String, dynamic>?> _fetchMonthlySummary({
    required String userId,
    required DateTime month,
  }) async {
    try {
      final snapshot = await _monthlySummaryOfUser(userId, month).get();
      if (!snapshot.exists) {
        _logger.i(
          'Statistic monthly summary is missing for userId=$userId month=${_monthKey(month)}.',
        );
        return null;
      }

      return snapshot.data();
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to load statistic monthly summary.',
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
}

StatisticDateRange statisticGetPeriodRange({
  required int selectedMonthIndex,
  required DateTime anchorDate,
}) {
  if (selectedMonthIndex == 0) {
    final referenceDate = DateTime(
      anchorDate.year,
      anchorDate.month,
      anchorDate.day,
    );
    final start = referenceDate.subtract(Duration(days: referenceDate.weekday - 1));
    return StatisticDateRange(
      start: DateTime(start.year, start.month, start.day),
      end: DateTime(start.year, start.month, start.day + 6, 23, 59, 59, 999),
    );
  }

  return StatisticDateRange(
    start: DateTime(anchorDate.year, anchorDate.month, 1),
    end: DateTime(anchorDate.year, anchorDate.month + 1, 0, 23, 59, 59, 999),
  );
}

StatisticDateRange statisticGetPreviousPeriodRange({
  required int selectedMonthIndex,
  required DateTime anchorDate,
}) {
  if (selectedMonthIndex == 0) {
    final currentRange = statisticGetPeriodRange(
      selectedMonthIndex: selectedMonthIndex,
      anchorDate: anchorDate,
    );
    final previousStart = currentRange.start.subtract(const Duration(days: 7));
    return StatisticDateRange(
      start: previousStart,
      end: DateTime(
        previousStart.year,
        previousStart.month,
        previousStart.day + 6,
        23,
        59,
        59,
        999,
      ),
    );
  }

  return StatisticDateRange(
    start: DateTime(anchorDate.year, anchorDate.month - 1, 1),
    end: DateTime(anchorDate.year, anchorDate.month, 0, 23, 59, 59, 999),
  );
}

StatisticPeriodOverview buildStatisticPeriodOverview({
  required StatisticDateRange range,
  required List<TransactionModel> transactions,
  required List<TransactionModel> previousTransactions,
  Map<String, dynamic>? summaryData,
}) {
  final computedCategories = _buildCategoryMap(transactions);
  final previousCategories = _buildCategoryMap(previousTransactions);
  final transactionCountByCategory = _countTransactionsByCategory(transactions);
  final categoryLabelByKey = _readCategoryLabels([
    ...transactions,
    ...previousTransactions,
  ]);
  final iconByCategory = _readCategoryIcons(transactions);

  final totalExpenseMinor = _readSummaryTotalExpenseMinor(summaryData) ??
      _sumExpenseMinor(transactions);
  final dailyExpenses = _readSummaryDailyExpenses(summaryData, range) ??
      _buildDailyExpenseSeries(range: range, transactions: transactions);
  final categories = _buildCategoryData(
    currentCategoryTotals: computedCategories,
    previousCategoryTotals: previousCategories,
    transactionCountByCategory: transactionCountByCategory,
    categoryLabelByKey: categoryLabelByKey,
    iconByCategory: iconByCategory,
    totalExpenseMinor: totalExpenseMinor,
  );

  return StatisticPeriodOverview(
    range: range,
    totalExpenseMinor: totalExpenseMinor,
    transactionCount: transactions.length,
    dailyExpenses: dailyExpenses,
    categories: categories,
    smartInsight: _buildSmartInsight(categories),
    strongestIncrease: _findInsightByDirection(
      categories,
      StatisticTrendDirection.up,
    ),
    strongestDecrease: _findInsightByDirection(
      categories,
      StatisticTrendDirection.down,
    ),
  );
}

int _sumExpenseMinor(List<TransactionModel> transactions) {
  return transactions.fold<int>(
    0,
    (total, transaction) => total + transaction.amountMinor,
  );
}

Map<String, int> _buildCategoryMap(List<TransactionModel> transactions) {
  final totals = <String, int>{};
  for (final transaction in transactions) {
    totals[transaction.categoryKey] =
        (totals[transaction.categoryKey] ?? 0) + transaction.amountMinor;
  }
  return totals;
}

Map<String, int> _countTransactionsByCategory(List<TransactionModel> transactions) {
  final counts = <String, int>{};
  for (final transaction in transactions) {
    counts[transaction.categoryKey] =
        (counts[transaction.categoryKey] ?? 0) + 1;
  }
  return counts;
}

Map<String, String> _readCategoryLabels(List<TransactionModel> transactions) {
  final labels = <String, String>{};
  for (final transaction in transactions) {
    labels[transaction.categoryKey] = transaction.categoryLabel;
  }
  return labels;
}

Map<String, String?> _readCategoryIcons(List<TransactionModel> transactions) {
  final icons = <String, String?>{};
  for (final transaction in transactions) {
    icons[transaction.categoryKey] = transaction.categoryIcon;
  }
  return icons;
}

List<StatisticCategoryData> _buildCategoryData({
  required Map<String, int> currentCategoryTotals,
  required Map<String, int> previousCategoryTotals,
  required Map<String, int> transactionCountByCategory,
  required Map<String, String> categoryLabelByKey,
  required Map<String, String?> iconByCategory,
  required int totalExpenseMinor,
}) {
  final allCategoryKeys = {
    ...currentCategoryTotals.keys,
    ...previousCategoryTotals.keys,
  }.toList(growable: false);

  final results = allCategoryKeys.map((categoryKey) {
    final currentAmount = currentCategoryTotals[categoryKey] ?? 0;
    final previousAmount = previousCategoryTotals[categoryKey] ?? 0;
    final transactionCount = transactionCountByCategory[categoryKey] ?? 0;
    final shareRatio = totalExpenseMinor > 0
        ? currentAmount / totalExpenseMinor
        : 0.0;
    final trend = _buildTrend(
      currentAmount: currentAmount,
      previousAmount: previousAmount,
    );

    return StatisticCategoryData(
      categoryKey: categoryKey,
      categoryLabel: categoryLabelByKey[categoryKey] ?? categoryKey,
      categoryIcon: iconByCategory[categoryKey],
      amountMinor: currentAmount,
      transactionCount: transactionCount,
      shareRatio: shareRatio,
      trendDirection: trend.direction,
      changePercent: trend.changePercent,
      trendLabel: trend.label,
    );
  }).toList(growable: false)
    ..sort((left, right) => right.amountMinor.compareTo(left.amountMinor));

  return results;
}

({
  StatisticTrendDirection direction,
  double? changePercent,
  String? label,
}) _buildTrend({
  required int currentAmount,
  required int previousAmount,
}) {
  if (currentAmount > previousAmount) {
    final changePercent = previousAmount > 0
        ? ((currentAmount - previousAmount) / previousAmount) * 100
        : 100.0;
    return (
      direction: StatisticTrendDirection.up,
      changePercent: changePercent,
      label: 'increase',
    );
  }

  if (currentAmount < previousAmount) {
    final changePercent = previousAmount > 0
        ? ((previousAmount - currentAmount) / previousAmount) * 100
        : 100.0;
    return (
      direction: StatisticTrendDirection.down,
      changePercent: changePercent,
      label: 'decrease',
    );
  }

  if (currentAmount == 0 && previousAmount == 0) {
    return (
      direction: StatisticTrendDirection.none,
      changePercent: null,
      label: null,
    );
  }

  return (
    direction: StatisticTrendDirection.stable,
    changePercent: 0,
    label: 'stable',
  );
}

StatisticInsightData? _buildSmartInsight(List<StatisticCategoryData> categories) {
  return _findInsightByDirection(categories, StatisticTrendDirection.up);
}

StatisticInsightData? _findInsightByDirection(
  List<StatisticCategoryData> categories,
  StatisticTrendDirection direction,
) {
  final matches = categories
      .where(
        (category) =>
            category.trendDirection == direction &&
            category.changePercent != null,
      )
      .toList(growable: false);

  if (matches.isEmpty) {
    return null;
  }

  matches.sort(
    (left, right) => (right.changePercent ?? 0).compareTo(
      left.changePercent ?? 0,
    ),
  );
  final strongest = matches.first;

  return StatisticInsightData(
    categoryKey: strongest.categoryKey,
    categoryLabel: strongest.categoryLabel,
    categoryIcon: strongest.categoryIcon,
    direction: strongest.trendDirection,
    changePercent: strongest.changePercent ?? 0,
  );
}

List<StatisticDailyExpenseData> _buildDailyExpenseSeries({
  required StatisticDateRange range,
  required List<TransactionModel> transactions,
}) {
  final totalsByDay = <String, int>{};
  for (final transaction in transactions) {
    final date = DateTime(
      transaction.dateTs.year,
      transaction.dateTs.month,
      transaction.dateTs.day,
    );
    final key = _dayKey(date);
    totalsByDay[key] = (totalsByDay[key] ?? 0) + transaction.amountMinor;
  }

  final points = <StatisticDailyExpenseData>[];
  var cursor = DateTime(range.start.year, range.start.month, range.start.day);
  while (!cursor.isAfter(range.end)) {
    final key = _dayKey(cursor);
    points.add(
      StatisticDailyExpenseData(
        date: cursor,
        amountMinor: totalsByDay[key] ?? 0,
      ),
    );
    cursor = cursor.add(const Duration(days: 1));
  }

  return List.unmodifiable(points);
}

List<StatisticDailyExpenseData>? _readSummaryDailyExpenses(
  Map<String, dynamic>? summaryData,
  StatisticDateRange range,
) {
  if (summaryData == null) {
    return null;
  }

  final rawDaily = summaryData['daily_expense_minor'];
  if (rawDaily is! Map<String, dynamic>) {
    return null;
  }

  final points = <StatisticDailyExpenseData>[];
  var cursor = DateTime(range.start.year, range.start.month, range.start.day);
  while (!cursor.isAfter(range.end)) {
    final key = _dayKey(cursor);
    points.add(
      StatisticDailyExpenseData(
        date: cursor,
        amountMinor: (rawDaily[key] as num?)?.toInt() ?? 0,
      ),
    );
    cursor = cursor.add(const Duration(days: 1));
  }

  return List.unmodifiable(points);
}

int? _readSummaryTotalExpenseMinor(Map<String, dynamic>? summaryData) {
  if (summaryData == null) {
    return null;
  }

  return (summaryData['total_expense_minor'] as num?)?.toInt();
}

String _monthKey(DateTime month) {
  final normalizedMonth = month.month.toString().padLeft(2, '0');
  return '${month.year}-$normalizedMonth';
}

String _dayKey(DateTime date) {
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  return '${date.year}-$month-$day';
}
