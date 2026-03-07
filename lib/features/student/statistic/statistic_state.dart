import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/models/entities/transaction_model.dart';

part 'statistic_state.freezed.dart';

@freezed
abstract class StatisticState with _$StatisticState {
  const factory StatisticState({
    @Default([]) List<TransactionModel> transactions,
    @Default([]) List<TransactionModel> previousMonthTransactions,
    @Default(true) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool isRefreshing,
    @Default(true) bool hasMore,
    @Default(8) int monthLimit,
    /// 0: Tháng trước, 1: Tháng này
    @Default(1) int selectedMonthIndex,
    @Default(0.0) double totalExpense,
    @Default(0.0) double previousMonthTotalExpense,
    String? errorMessage,
  }) = _StatisticState;
}
