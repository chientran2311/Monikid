import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/models/entities/transaction_model.dart';

part 'statistic_models.freezed.dart';

enum StatisticStatus {
  initial,
  loading,
  success,
  empty,
  error,
}

enum StatisticTrendDirection {
  up,
  down,
  stable,
  none,
}

enum StatisticBudgetStatus {
  noLimit,
  onTrack,
  warning,
  exceeded,
}

@freezed
abstract class StatisticDateRange with _$StatisticDateRange {
  const factory StatisticDateRange({
    required DateTime start,
    required DateTime end,
  }) = _StatisticDateRange;
}

@freezed
abstract class StatisticDailyExpenseData with _$StatisticDailyExpenseData {
  const factory StatisticDailyExpenseData({
    required DateTime date,
    required int amountMinor,
  }) = _StatisticDailyExpenseData;
}

@freezed
abstract class StatisticCategoryData with _$StatisticCategoryData {
  const factory StatisticCategoryData({
    required String categoryKey,
    required String categoryLabel,
    String? categoryIcon,
    required int amountMinor,
    required int transactionCount,
    required double shareRatio,
    @Default(StatisticTrendDirection.none)
    StatisticTrendDirection trendDirection,
    double? changePercent,
    String? trendLabel,
  }) = _StatisticCategoryData;
}

@freezed
abstract class StatisticInsightData with _$StatisticInsightData {
  const factory StatisticInsightData({
    required String categoryKey,
    required String categoryLabel,
    String? categoryIcon,
    required StatisticTrendDirection direction,
    required double changePercent,
  }) = _StatisticInsightData;
}

@freezed
abstract class StatisticBudgetOverview with _$StatisticBudgetOverview {
  const factory StatisticBudgetOverview({
    int? limitMinor,
    int? remainingMinor,
    @Default(0) int spentMinor,
    @Default(0) double usageRatio,
    @Default(StatisticBudgetStatus.noLimit) StatisticBudgetStatus status,
    @Default(StatisticTrendDirection.none)
    StatisticTrendDirection comparisonDirection,
    double? comparisonPercent,
  }) = _StatisticBudgetOverview;
}

@freezed
abstract class StatisticPeriodOverview with _$StatisticPeriodOverview {
  const factory StatisticPeriodOverview({
    required StatisticDateRange range,
    @Default(0) int totalExpenseMinor,
    @Default(0) int transactionCount,
    @Default([]) List<StatisticDailyExpenseData> dailyExpenses,
    @Default([]) List<StatisticCategoryData> categories,
    @Default(0) int totalIncomeMinor,
    @Default([]) List<StatisticCategoryData> incomeCategories,
    StatisticInsightData? smartInsight,
    StatisticInsightData? strongestIncrease,
    StatisticInsightData? strongestDecrease,
  }) = _StatisticPeriodOverview;
}

@freezed
abstract class StatisticOverviewData with _$StatisticOverviewData {
  const factory StatisticOverviewData({
    required StatisticPeriodOverview currentPeriod,
    required StatisticPeriodOverview previousPeriod,
    @Default([]) List<TransactionModel> currentTransactions,
    @Default([]) List<TransactionModel> previousTransactions,
  }) = _StatisticOverviewData;
}
