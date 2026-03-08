import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/models/entities/transaction_model.dart';

part 'transaction_history_state.freezed.dart';

@freezed
abstract class TransactionHistoryState with _$TransactionHistoryState {
  const factory TransactionHistoryState({
    @Default([]) List<TransactionModel> transactions,
    @Default(true) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool isRefreshing,
    @Default(false) bool isListLoading,
    @Default(true) bool hasMore,
    DateTime? selectedDate,
    String? selectedCategory,
    // Mặc định là 'expense' hoặc 'income', không còn null
    @Default('expense') String transactionTypeFilter,
    @Default(8) int monthLimit,
    String? errorMessage,
  }) = _TransactionHistoryState;
}
