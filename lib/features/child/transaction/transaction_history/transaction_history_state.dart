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
    @Default(true) bool isLoading,
    @Default(false) bool isListLoading,
    @Default(false) bool isLoadingMore,
    @Default(true) bool hasMore,
    @Default(8) int monthLimit,
    String? sharedErrorMessage,
    String? errorMessage,
    // Legacy state properties kept for backward compatibility
    DateTime? selectedDate,
    String? transactionTypeFilter,
    String? selectedCategoryKey,
    TransactionModel? selectedTransaction,
    String? selectedTransactionId,
    String? selectionErrorMessage,
  }) = _TransactionHistoryState;

  const TransactionHistoryState._();

  bool get isSharedLoading => sharedStatus == TransactionHistorySharedStatus.loading;
  bool get hasSharedData =>
      sharedStatus == TransactionHistorySharedStatus.success ||
      sharedStatus == TransactionHistorySharedStatus.empty;
}
