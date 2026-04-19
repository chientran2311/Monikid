import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/repositories/transaction/transaction_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'transaction_history_state.dart';

part 'transaction_history_provider.g.dart';

const _kPageSize = 8;

// =============================================================================
// STREAM PROVIDER — Summary Card (thu/chi theo ngày hoặc tháng)
// =============================================================================

@riverpod
Stream<({double totalIncome, double totalExpense})> streamSummaryCard(
  Ref ref, {
  DateTime? date,
  DateTime? month,
  String? categoryKey,
  String? type,
}) {
  final log = Logger();
  final uid = ref.watch(authSessionProvider).user?.uid;

  log.i('🔍 streamSummaryCard | uid=$uid | date=$date | month=$month');

  if (uid == null) {
    log.w('⚠️ uid is null → returning empty stream');
    return Stream.value((totalIncome: 0.0, totalExpense: 0.0));
  }

  return ref
      .watch(transactionRepositoryProvider)
      .watchSummary(
        uid,
        date: date,
        month: month,
        categoryKey: categoryKey,
        type: type,
      )
      .map((data) {
        log.i('✅ watchSummary emit | income=${data.totalIncome} | expense=${data.totalExpense}');
        return data;
      })
      .handleError((e, st) {
        log.e('❌ watchSummary error: $e', error: e, stackTrace: st);
        throw e;
      });
}

// =============================================================================
// NOTIFIER
// =============================================================================

@Riverpod(keepAlive: true)
class TransactionHistory extends _$TransactionHistory {
  late final TransactionRepository _repository;
  StreamSubscription<({List<TransactionModel> transactions, DateTime month})>?
      _monthlySubscription;

  @override
  TransactionHistoryState build() {
    _repository = ref.read(transactionRepositoryProvider);
    ref.onDispose(() => _monthlySubscription?.cancel());
    return const TransactionHistoryState(selectedDate: null);
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  String? get _userId {
    final auth = ref.read(authSessionProvider);
    return auth.isAuthenticated ? auth.user?.uid : null;
  }

  bool get _hasFilter =>
      state.selectedDate != null ||
      state.selectedCategoryKey != null ||
      state.transactionTypeFilter != 'all';

  String? get _activeType {
    final t = state.transactionTypeFilter;
    return t == 'all' ? null : t;
  }

  TransactionModel? _findTransactionInState(String transactionId) {
    if (state.selectedTransaction?.transactionId == transactionId) {
      return state.selectedTransaction;
    }

    for (final transaction in state.transactions) {
      if (transaction.transactionId == transactionId) {
        return transaction;
      }
    }

    for (final transaction in state.monthlyTransactions) {
      if (transaction.transactionId == transactionId) {
        return transaction;
      }
    }

    return null;
  }

  void _cancelMonthlySubscription() {
    _monthlySubscription?.cancel();
    _monthlySubscription = null;
  }

  // ---------------------------------------------------------------------------
  // PUBLIC METHODS
  // ---------------------------------------------------------------------------

  Future<void> ensureInitialized() async {
    if (state.hasSharedData || state.isSharedLoading) {
      if (!_hasFilter) {
        _syncVisibleTransactionsFromMonthly(resetVisibleLoading: false);
      }
      return;
    }

    _subscribeToMonthlyTransactions(
      resetVisibleState: state.transactions.isEmpty && !_hasFilter,
    );
  }

  /// 1. PUBLIC METHOD: Initialize data
  Future<void> init() async {
    await ensureInitialized();

    if (_hasFilter) {
      await _loadFilteredTransactions(reset: true);
      return;
    }

    ref.invalidate(streamSummaryCardProvider);
    _syncVisibleTransactionsFromMonthly(resetVisibleLoading: false);
  }

  /// 2. PUBLIC METHOD: Pull to refresh
  Future<void> refresh() async {
    await refreshSharedTransactions();
    ref.invalidate(streamSummaryCardProvider);
    if (_hasFilter) {
      await _loadFilteredTransactions(reset: true, isRefresh: true);
      return;
    }

    _syncVisibleTransactionsFromMonthly(resetVisibleLoading: false);
  }

  Future<void> refreshSharedTransactions() async {
    _subscribeToMonthlyTransactions(
      resetVisibleState: state.transactions.isEmpty && !_hasFilter,
    );
  }

  void selectTransaction(TransactionModel transaction) {
    state = state.copyWith(
      selectedTransactionId: transaction.transactionId,
      selectedTransaction: transaction,
      isResolvingSelection: false,
      selectionErrorMessage: null,
    );
  }

  Future<TransactionModel?> ensureSelectedTransaction(String transactionId) async {
    final cachedTransaction = _findTransactionInState(transactionId);
    if (cachedTransaction != null) {
      selectTransaction(cachedTransaction);
      return cachedTransaction;
    }

    final uid = _userId;
    if (uid == null) {
      state = state.copyWith(
        selectedTransactionId: transactionId,
        selectedTransaction: null,
        isResolvingSelection: false,
        selectionErrorMessage: 'Missing authenticated user.',
      );
      return null;
    }

    state = state.copyWith(
      selectedTransactionId: transactionId,
      selectedTransaction: null,
      isResolvingSelection: true,
      selectionErrorMessage: null,
    );

    final fetchedTransaction = await _repository.getTransactionById(
      uid,
      transactionId,
    );

    if (fetchedTransaction == null) {
      state = state.copyWith(
        selectedTransactionId: transactionId,
        selectedTransaction: null,
        isResolvingSelection: false,
        selectionErrorMessage: 'Unable to load transaction.',
      );
      return null;
    }

    selectTransaction(fetchedTransaction);
    return fetchedTransaction;
  }

  void applyUpdatedTransaction(TransactionModel updatedTransaction) {
    final nextMonthlyTransactions = _upsertMonthlyTransaction(updatedTransaction);
    final nextSharedStatus = nextMonthlyTransactions.isEmpty
        ? TransactionHistorySharedStatus.empty
        : TransactionHistorySharedStatus.success;

    state = state.copyWith(
      monthlyTransactions: nextMonthlyTransactions,
      sharedStatus: nextSharedStatus,
      selectedTransactionId: updatedTransaction.transactionId,
      selectedTransaction: updatedTransaction,
      isResolvingSelection: false,
      selectionErrorMessage: null,
      sharedErrorMessage: null,
    );

    if (_hasFilter) {
      state = state.copyWith(
        transactions: _upsertFilteredTransaction(updatedTransaction),
        errorMessage: null,
      );
      return;
    }

    _syncVisibleTransactionsFromMonthly(resetVisibleLoading: false);
  }

  void removeTransaction(String transactionId) {
    final nextMonthlyTransactions = state.monthlyTransactions
        .where((transaction) => transaction.transactionId != transactionId)
        .toList(growable: false);
    final nextSharedStatus = nextMonthlyTransactions.isEmpty
        ? TransactionHistorySharedStatus.empty
        : TransactionHistorySharedStatus.success;
    final isCurrentSelection = state.selectedTransactionId == transactionId;

    state = state.copyWith(
      monthlyTransactions: nextMonthlyTransactions,
      transactions: state.transactions
          .where((transaction) => transaction.transactionId != transactionId)
          .toList(growable: false),
      sharedStatus: nextSharedStatus,
      selectedTransactionId: isCurrentSelection ? null : state.selectedTransactionId,
      selectedTransaction: isCurrentSelection ? null : state.selectedTransaction,
      isResolvingSelection: false,
      selectionErrorMessage: isCurrentSelection ? null : state.selectionErrorMessage,
      sharedErrorMessage: null,
      errorMessage: null,
    );

    if (!_hasFilter) {
      _syncVisibleTransactionsFromMonthly(resetVisibleLoading: false);
    }
  }

  /// 3. PUBLIC METHOD: Load next page
  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore || state.isLoading) {
      return;
    }

    if (_hasFilter) {
      await _loadFilteredTransactions(reset: false);
      return;
    }

    state = state.copyWith(monthLimit: state.monthLimit + _kPageSize);
    _syncVisibleTransactionsFromMonthly(resetVisibleLoading: false);
  }

  /// 4. PUBLIC METHOD: Filter by Date
  Future<void> getTransByDate(DateTime? date) async {
    if (state.selectedDate == date) return;
    state = state.copyWith(selectedDate: date);

    if (!_hasFilter) {
      ref.invalidate(streamSummaryCardProvider);
      _syncVisibleTransactionsFromMonthly(resetVisibleLoading: false);
      return;
    }

    ref.invalidate(streamSummaryCardProvider);
    await _loadFilteredTransactions(reset: true);
  }

  /// 5. PUBLIC METHOD: Filter by Category
  Future<void> getTransByCategory(String? categoryKey) async {
    if (state.selectedCategoryKey == categoryKey) return;
    state = state.copyWith(selectedCategoryKey: categoryKey);

    if (!_hasFilter) {
      _syncVisibleTransactionsFromMonthly(resetVisibleLoading: false);
      return;
    }

    await _loadFilteredTransactions(reset: true);
  }

  /// 6. PUBLIC METHOD: Filter by Type
  Future<void> setTypeFilter(String type) async {
    if (state.transactionTypeFilter == type) return;
    state = state.copyWith(transactionTypeFilter: type);

    if (!_hasFilter) {
      ref.invalidate(streamSummaryCardProvider);
      _syncVisibleTransactionsFromMonthly(resetVisibleLoading: false);
      return;
    }

    ref.invalidate(streamSummaryCardProvider);
    await _loadFilteredTransactions(reset: true);
  }

  // ---------------------------------------------------------------------------
  // PRIVATE METHODS
  // ---------------------------------------------------------------------------

  void _subscribeToMonthlyTransactions({required bool resetVisibleState}) {
    final uid = _userId;
    if (uid == null) {
      _cancelMonthlySubscription();
      state = state.copyWith(
        monthlyTransactions: [],
        transactions: [],
        sharedStatus: TransactionHistorySharedStatus.empty,
        hasMore: false,
        isLoading: false,
        isListLoading: false,
        isLoadingMore: false,
        sharedErrorMessage: null,
        errorMessage: null,
      );
      return;
    }

    _cancelMonthlySubscription();
    state = state.copyWith(
      sharedStatus: TransactionHistorySharedStatus.loading,
      sharedErrorMessage: null,
      isLoading: resetVisibleState,
      isListLoading: false,
      isLoadingMore: false,
      monthLimit: resetVisibleState ? _kPageSize : state.monthLimit,
    );

    _monthlySubscription = _repository
        .getTransactionsByMonth(uid, DateTime.now())
        .listen(
          (record) {
            final sharedStatus = record.transactions.isEmpty
                ? TransactionHistorySharedStatus.empty
                : TransactionHistorySharedStatus.success;
            final refreshedSelection = state.selectedTransactionId == null
                ? state.selectedTransaction
                : record.transactions.cast<TransactionModel?>().firstWhere(
                    (transaction) =>
                        transaction?.transactionId == state.selectedTransactionId,
                    orElse: () => state.selectedTransaction,
                  );

            state = state.copyWith(
              monthlyTransactions: record.transactions,
              sharedStatus: sharedStatus,
              selectedTransaction: refreshedSelection,
              isResolvingSelection: false,
              sharedErrorMessage: null,
            );

            if (!_hasFilter) {
              _syncVisibleTransactionsFromMonthly(resetVisibleLoading: false);
            }
          },
          onError: _handleSharedLoadError,
        );
  }

  Future<void> _loadFilteredTransactions({
    required bool reset,
    bool isRefresh = false,
  }) async {
    final uid = _userId;
    if (uid == null) {
      state = state.copyWith(
        transactions: [],
        hasMore: false,
        isLoading: false,
        isListLoading: false,
        isLoadingMore: false,
        errorMessage: null,
      );
      return;
    }

    _updateLoadingState(reset: reset, isRefresh: isRefresh);

    try {
      final lastTx = reset
          ? null
          : (state.transactions.isNotEmpty ? state.transactions.last : null);

      final results = await _repository.getTransactionsByFilter(
        uid,
        date: state.selectedDate,
        categoryKey: state.selectedCategoryKey,
        type: _activeType,
        lastTransaction: lastTx,
        limit: _kPageSize + 1,
      );

      final hasMore = results.length > _kPageSize;
      final visibleResults = hasMore ? results.take(_kPageSize).toList() : results;
      final finalList = reset
          ? visibleResults
          : [...state.transactions, ...visibleResults];

      state = state.copyWith(
        transactions: finalList,
        hasMore: hasMore,
        isLoading: false,
        isListLoading: false,
        isLoadingMore: false,
        errorMessage: null,
      );
    } catch (error, stackTrace) {
      Logger().e(
        'Error loading filtered transactions.',
        error: error,
        stackTrace: stackTrace,
      );
      _handleLoadError(reset, error);
    }
  }

  void _syncVisibleTransactionsFromMonthly({
    required bool resetVisibleLoading,
  }) {
    final monthlyTransactions = state.monthlyTransactions;
    final hasMore = monthlyTransactions.length > state.monthLimit;
    final visibleTransactions = hasMore
        ? monthlyTransactions.take(state.monthLimit).toList()
        : monthlyTransactions;

    state = state.copyWith(
      transactions: visibleTransactions,
      hasMore: hasMore,
      isLoading: resetVisibleLoading ? false : state.isLoading && !state.hasSharedData,
      isListLoading: false,
      isLoadingMore: false,
      errorMessage: null,
    );
  }

  List<TransactionModel> _upsertMonthlyTransaction(
    TransactionModel updatedTransaction,
  ) {
    final transactions = state.monthlyTransactions
        .where(
          (transaction) =>
              transaction.transactionId != updatedTransaction.transactionId,
        )
        .toList();

    if (_isInCurrentMonth(updatedTransaction.dateTs)) {
      transactions.add(updatedTransaction);
    }

    transactions.sort((a, b) => b.dateTs.compareTo(a.dateTs));
    return List.unmodifiable(transactions);
  }

  List<TransactionModel> _upsertFilteredTransaction(
    TransactionModel updatedTransaction,
  ) {
    final transactions = state.transactions
        .where(
          (transaction) =>
              transaction.transactionId != updatedTransaction.transactionId,
        )
        .toList();

    if (_matchesCurrentFilter(updatedTransaction)) {
      transactions.add(updatedTransaction);
    }

    transactions.sort((a, b) => b.dateTs.compareTo(a.dateTs));
    return List.unmodifiable(transactions);
  }

  bool _matchesCurrentFilter(TransactionModel transaction) {
    if (_activeType != null && transaction.type != _activeType) {
      return false;
    }

    if (state.selectedCategoryKey != null &&
        transaction.categoryKey != state.selectedCategoryKey) {
      return false;
    }

    if (state.selectedDate != null) {
      final selectedDate = state.selectedDate!;
      return transaction.dateTs.year == selectedDate.year &&
          transaction.dateTs.month == selectedDate.month &&
          transaction.dateTs.day == selectedDate.day;
    }

    return _isInCurrentMonth(transaction.dateTs);
  }

  bool _isInCurrentMonth(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  void _updateLoadingState({required bool reset, required bool isRefresh}) {
    if (reset) {
      if (isRefresh) {
        state = state.copyWith(
          isLoading: false,
          isListLoading: false,
          isLoadingMore: false,
          errorMessage: null,
        );
      } else {
        if (state.transactions.isEmpty) {
          state = state.copyWith(
            isLoading: true,
            isListLoading: false,
            isLoadingMore: false,
            errorMessage: null,
          );
        } else {
          state = state.copyWith(
            isLoading: false,
            isListLoading: true,
            transactions: [],
            isLoadingMore: false,
            errorMessage: null,
          );
        }
      }
    } else {
      state = state.copyWith(
        isLoadingMore: true,
        errorMessage: null,
      );
    }
  }

  void _handleLoadError(bool reset, Object e) {
    final errorMessage = e.toString().replaceAll('Exception: ', '');

    if (reset) {
      state = state.copyWith(
        isLoading: false,
        isListLoading: false,
        errorMessage: errorMessage,
        transactions: [],
      );
    } else {
      state = state.copyWith(
        isLoadingMore: false,
        errorMessage: errorMessage,
      );
    }
  }

  void _handleSharedLoadError(Object error, StackTrace stackTrace) {
    Logger().e(
      'Error loading shared monthly transactions.',
      error: error,
      stackTrace: stackTrace,
    );

    state = state.copyWith(
      sharedStatus: TransactionHistorySharedStatus.error,
      sharedErrorMessage: error.toString().replaceAll('Exception: ', ''),
      isLoading: false,
      isListLoading: false,
      isLoadingMore: false,
    );
  }
}
