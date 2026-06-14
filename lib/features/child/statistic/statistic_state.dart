import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/features/child/statistic/statistic_models.dart';
import 'package:monikid/models/entities/transaction_model.dart';

part 'statistic_state.freezed.dart';

@freezed
abstract class StatisticState with _$StatisticState {
  const factory StatisticState({
    @Default([]) List<TransactionModel> transactions,
    @Default([]) List<TransactionModel> previousPeriodTransactions,
    @Default([]) List<TransactionModel> visibleTransactions,
    @Default(false) bool isLoadingMore,
    @Default(false) bool isRefreshing,
    @Default(true) bool hasMore,
    @Default(8) int pageLimit,
    /// 0: by week, 1: by month, 2: by year
    @Default(1) int selectedTabIndex,
    DateTime? selectedDate,
    @Default(0.0) double totalExpense,
    @Default(0.0) double previousPeriodTotalExpense,
    @Default(StatisticStatus.initial) StatisticStatus status,
    StatisticPeriodOverview? currentOverview,
    StatisticPeriodOverview? previousOverview,
    StatisticBudgetOverview? budgetOverview,
    String? errorMessage,
  }) = _StatisticState;

  const StatisticState._();

  bool get isLoading => status == StatisticStatus.loading;
  bool get hasData =>
      status == StatisticStatus.success || status == StatisticStatus.empty;
  bool get isEmpty => status == StatisticStatus.empty;
  StatisticPeriodOverview get resolvedCurrentOverview =>
      currentOverview ??
      StatisticPeriodOverview(
        range: StatisticDateRange(
          start: selectedDate ?? DateTime.now(),
          end: selectedDate ?? DateTime.now(),
        ),
      );
  StatisticPeriodOverview get resolvedPreviousOverview =>
      previousOverview ??
      StatisticPeriodOverview(
        range: StatisticDateRange(
          start: selectedDate ?? DateTime.now(),
          end: selectedDate ?? DateTime.now(),
        ),
      );
}
