import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:monikid/features/child/statistic/statistic_models.dart';

part 'parent_statistic_state.freezed.dart';

enum ParentStatisticPeriod { week, month, year }

enum ParentStatisticStatus { initial, loading, success, empty, error }

@freezed
abstract class ParentStatisticState with _$ParentStatisticState {
  const factory ParentStatisticState({
    @Default(ParentStatisticPeriod.month) ParentStatisticPeriod period,
    @Default(ParentStatisticStatus.initial) ParentStatisticStatus status,
    @Default('') String selectedChildId,
    @Default(0) int totalExpenseMinor,
    @Default(0) int prevTotalExpenseMinor,
    @Default([]) List<StatisticDailyExpenseData> dailyData,
    @Default([]) List<StatisticCategoryData> topCategories,
    @Default([]) List<StatisticCategoryData> incomeCategories,
    DateTime? selectedDate,
    String? errorMessage,
  }) = _ParentStatisticState;

  const ParentStatisticState._();

  int get totalTransactionCount =>
      topCategories.fold(0, (sum, c) => sum + c.transactionCount);

  bool get isLoading => status == ParentStatisticStatus.loading;

  bool get hasError => status == ParentStatisticStatus.error;

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

  int get totalIncomeMinor =>
      incomeCategories.fold(0, (sum, c) => sum + c.amountMinor);

  int avgPerDayMinorForPeriod(ParentStatisticPeriod period) {
    final days = switch (period) {
      ParentStatisticPeriod.week => 7,
      ParentStatisticPeriod.month => 30,
      ParentStatisticPeriod.year => 365,
    };
    if (days == 0 || totalExpenseMinor == 0) return 0;
    return (totalExpenseMinor / days).round();
  }

  StatisticDailyExpenseData? get peakDay => dailyData.isEmpty
      ? null
      : dailyData.reduce((a, b) => a.amountMinor >= b.amountMinor ? a : b);

  int get currentSpendingStreak {
    if (dailyData.isEmpty) return 0;
    final sorted = [...dailyData]..sort((a, b) => a.date.compareTo(b.date));
    int streak = 0, maxStreak = 0;
    for (var i = 0; i < sorted.length; i++) {
      if (sorted[i].amountMinor > 0) {
        if (i == 0) {
          streak = 1;
        } else {
          final diff = sorted[i].date.difference(sorted[i - 1].date).inDays;
          streak = diff == 1 ? streak + 1 : 1;
        }
        if (streak > maxStreak) maxStreak = streak;
      } else {
        streak = 0;
      }
    }
    return maxStreak;
  }
}
