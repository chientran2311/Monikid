import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/models/entities/transaction_model.dart';

part 'transaction_history_state.freezed.dart';

@freezed
abstract class TransactionHistoryState with _$TransactionHistoryState {
  const factory TransactionHistoryState({
    @Default([]) List<TransactionModel> transactions,
    @Default(true) bool isLoading,
    @Default(false) bool isListLoading,
    @Default(false) bool isLoadingMore,
    @Default(true) bool hasMore,
    DateTime? selectedDate,
    String? selectedCategory,
    // 'all' | 'income' | 'expense'
    @Default('all') String transactionTypeFilter,
    @Default(8) int monthLimit,
    String? errorMessage,
  }) = _TransactionHistoryState;

  const TransactionHistoryState._();
}
