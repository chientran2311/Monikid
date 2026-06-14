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

  List<StatisticDailyExpenseData> get resolvedDailyData {
    if (period == ParentStatisticPeriod.week && dailyData.length > 7) {
      return dailyData.sublist(dailyData.length - 7);
    }
    return dailyData;
  }
}
