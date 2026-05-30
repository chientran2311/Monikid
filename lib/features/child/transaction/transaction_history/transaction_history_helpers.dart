import 'package:monikid/models/entities/transaction_model.dart';

/// Pure utility functions for transaction history operations.
/// Extracted from transaction_history_provider.dart to reduce file size.
class TransactionHistoryHelpers {
  TransactionHistoryHelpers._();

  /// Upserts a transaction into the list, maintaining descending date order.
  /// Removes existing transaction with same ID if found.
  static List<TransactionModel> upsertTransaction({
    required List<TransactionModel> currentList,
    required TransactionModel updatedTransaction,
    required bool Function(TransactionModel) shouldInclude,
  }) {
    final transactions = currentList
        .where(
          (transaction) =>
              transaction.transactionId != updatedTransaction.transactionId,
        )
        .toList();

    if (shouldInclude(updatedTransaction)) {
      transactions.add(updatedTransaction);
    }

    transactions.sort((a, b) => b.dateTs.compareTo(a.dateTs));
    return List.unmodifiable(transactions);
  }

  /// Checks if a transaction matches the given filter criteria.
  static bool matchesFilter({
    required TransactionModel transaction,
    required String? activeType,
    required String? selectedCategoryKey,
    required DateTime? selectedDate,
  }) {
    if (activeType != null && transaction.type != activeType) {
      return false;
    }

    if (selectedCategoryKey != null &&
        transaction.categoryKey != selectedCategoryKey) {
      return false;
    }

    if (selectedDate != null) {
      return transaction.dateTs.year == selectedDate.year &&
          transaction.dateTs.month == selectedDate.month &&
          transaction.dateTs.day == selectedDate.day;
    }

    return isInCurrentMonth(transaction.dateTs);
  }

  /// Checks if a date belongs to the current month.
  static bool isInCurrentMonth(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  /// Formats error message by removing "Exception: " prefix.
  static String formatErrorMessage(Object error) {
    return error.toString().replaceAll('Exception: ', '');
  }

  /// Calculates loading state parameters based on reset/refresh flags and current transactions.
  static LoadingStateParams calculateLoadingStateParams({
    required bool reset,
    required bool isRefresh,
    required bool hasTransactions,
  }) {
    if (!reset) {
      return LoadingStateParams(
        isLoading: false,
        isListLoading: false,
        isLoadingMore: true,
        shouldClearTransactions: false,
      );
    }

    if (isRefresh) {
      return const LoadingStateParams(
        isLoading: false,
        isListLoading: false,
        isLoadingMore: false,
        shouldClearTransactions: false,
      );
    }

    if (hasTransactions) {
      return const LoadingStateParams(
        isLoading: false,
        isListLoading: true,
        isLoadingMore: false,
        shouldClearTransactions: true,
      );
    }

    return const LoadingStateParams(
      isLoading: true,
      isListLoading: false,
      isLoadingMore: false,
      shouldClearTransactions: false,
    );
  }
}

/// Data class for loading state parameters.
class LoadingStateParams {
  final bool isLoading;
  final bool isListLoading;
  final bool isLoadingMore;
  final bool shouldClearTransactions;

  const LoadingStateParams({
    required this.isLoading,
    required this.isListLoading,
    required this.isLoadingMore,
    required this.shouldClearTransactions,
  });
}
