import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/models/entities/transaction_model.dart';

part 'transaction_history_state.freezed.dart';

enum TransactionHistorySharedStatus {
  initial,
  loading,
  success,
  empty,
  error,
}

@freezed
abstract class TransactionHistoryState with _$TransactionHistoryState {
  const factory TransactionHistoryState({
    @Default([]) List<TransactionModel> monthlyTransactions,
    @Default([]) List<TransactionModel> transactions,
    @Default(TransactionHistorySharedStatus.initial)
    TransactionHistorySharedStatus sharedStatus,
    String? selectedTransactionId,
    TransactionModel? selectedTransaction,
    @Default(true) bool isLoading,
    @Default(false) bool isListLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool isResolvingSelection,
    @Default(true) bool hasMore,
    DateTime? selectedDate,
    String? selectedCategoryKey,
    // 'all' | 'income' | 'expense'
    @Default('all') String transactionTypeFilter,
    @Default(8) int monthLimit,
    String? selectionErrorMessage,
    String? sharedErrorMessage,
    String? errorMessage,
  }) = _TransactionHistoryState;

  const TransactionHistoryState._();

  bool get isSharedLoading => sharedStatus == TransactionHistorySharedStatus.loading;
  bool get hasSharedData =>
      sharedStatus == TransactionHistorySharedStatus.success ||
      sharedStatus == TransactionHistorySharedStatus.empty;
  bool get hasSelectedTransaction =>
      selectedTransactionId != null && selectedTransaction != null;
}
