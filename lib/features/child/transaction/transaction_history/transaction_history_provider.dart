import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/features/child/transaction/transaction_history/transaction_history_helpers.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/repositories/transaction/transaction_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'providers/transaction_filter_provider.dart';
import 'providers/transaction_selection_provider.dart';
import 'providers/transaction_summary_provider.dart';
import 'transaction_history_state.dart';

part 'transaction_history_provider.g.dart';

const _kPageSize = 8;

@Riverpod(keepAlive: true)
class TransactionHistory extends _$TransactionHistory {
  late final TransactionRepository _repository;
  late final Logger _logger;

  @override
  TransactionHistoryState build() {
    _repository = ref.read(transactionRepositoryProvider);
    _logger = getIt<Logger>();

    // React to filter changes
    ref.listen(transactionFilterNotifierProvider, (previous, next) {
      if (previous != next) {
        ref.invalidate(streamSummaryCardProvider);
        if (!next.hasFilter) {
          _syncVisibleTransactionsFromMonthly(resetVisibleLoading: false);
        } else {
          _loadFilteredTransactions(reset: true);
        }
      }
    });

    return const TransactionHistoryState();
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  String? get _userId {
    final auth = ref.read(authSessionProvider);
    return auth.isAuthenticated ? auth.user?.uid : null;
  }

  bool get _hasFilter => ref.read(transactionFilterNotifierProvider).hasFilter;
  String? get _activeType => ref.read(transactionFilterNotifierProvider).activeType;
  DateTime? get _selectedDate => ref.read(transactionFilterNotifierProvider).selectedDate;
  String? get _selectedCategoryKey => ref.read(transactionFilterNotifierProvider).selectedCategoryKey;

  TransactionModel? findTransactionInState(String transactionId) {
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

    await _loadSharedMonthlyTransactions(
      resetVisibleState: state.transactions.isEmpty && !_hasFilter,
    );
  }

  /// 1. PUBLIC METHOD: Initialize data
  Future<void> init() async {
    await ensureInitialized();
    ref.invalidate(streamSummaryCardProvider);

    if (_hasFilter) {
      await _loadFilteredTransactions(reset: true);
    } else {
      _syncVisibleTransactionsFromMonthly(resetVisibleLoading: false);
    }
  }

  /// 2. PUBLIC METHOD: Pull to refresh
  Future<void> refresh() async {
    await _loadSharedMonthlyTransactions(
      resetVisibleState: state.transactions.isEmpty && !_hasFilter,
    );
    ref.invalidate(streamSummaryCardProvider);

    if (_hasFilter) {
      await _loadFilteredTransactions(reset: true, isRefresh: true);
    } else {
      _syncVisibleTransactionsFromMonthly(resetVisibleLoading: false);
    }
  }

  void applyUpdatedTransaction(TransactionModel updatedTransaction) {
    final nextMonthlyTransactions = TransactionHistoryHelpers.upsertTransaction(
      currentList: state.monthlyTransactions,
      updatedTransaction: updatedTransaction,
      shouldInclude: (tx) => TransactionHistoryHelpers.isInCurrentMonth(tx.dateTs),
    );
    final nextSharedStatus = nextMonthlyTransactions.isEmpty
        ? TransactionHistorySharedStatus.empty
        : TransactionHistorySharedStatus.success;

    state = state.copyWith(
      monthlyTransactions: nextMonthlyTransactions,
      sharedStatus: nextSharedStatus,
      sharedErrorMessage: null,
    );

    if (_hasFilter) {
      state = state.copyWith(
        transactions: TransactionHistoryHelpers.upsertTransaction(
          currentList: state.transactions,
          updatedTransaction: updatedTransaction,
          shouldInclude: (tx) => TransactionHistoryHelpers.matchesFilter(
            transaction: tx,
            activeType: _activeType,
            selectedCategoryKey: _selectedCategoryKey,
            selectedDate: _selectedDate,
          ),
        ),
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

    state = state.copyWith(
      monthlyTransactions: nextMonthlyTransactions,
      transactions: state.transactions
          .where((transaction) => transaction.transactionId != transactionId)
          .toList(growable: false),
      sharedStatus: nextSharedStatus,
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

  /// Wrappers for filter state
  Future<void> getTransByDate(DateTime? date) async {
    ref.read(transactionFilterNotifierProvider.notifier).getTransByDate(date);
  }

  Future<void> getTransByCategory(String? categoryKey) async {
    ref.read(transactionFilterNotifierProvider.notifier).getTransByCategory(categoryKey);
  }

  Future<void> setTypeFilter(String type) async {
    ref.read(transactionFilterNotifierProvider.notifier).setTypeFilter(type);
  }

  /// Legacy method redirects to transaction selection provider
  void selectTransaction(TransactionModel transaction) {
    ref.read(transactionSelectionNotifierProvider.notifier).selectTransaction(transaction);
  }

  Future<TransactionModel?> ensureSelectedTransaction(String transactionId) async {
    return ref.read(transactionSelectionNotifierProvider.notifier).ensureSelectedTransaction(transactionId);
  }

  /// Refresh shared monthly transactions (replaces old refreshSharedTransactions)
  Future<void> refreshSharedTransactions() async {
    await refresh();
  }

  // ---------------------------------------------------------------------------
  // PRIVATE METHODS
  // ---------------------------------------------------------------------------

  void _resetStateForUnauthenticated() {
    state = state.copyWith(
      monthlyTransactions: [],
      transactions: [],
      sharedStatus: TransactionHistorySharedStatus.initial,
      hasMore: false,
      isLoading: false,
      isListLoading: false,
      isLoadingMore: false,
      sharedErrorMessage: null,
      errorMessage: null,
    );
  }

  Future<void> _loadSharedMonthlyTransactions({
    required bool resetVisibleState,
  }) async {
    final uid = _userId;
    if (uid == null) {
      _resetStateForUnauthenticated();
      return;
    }

    state = state.copyWith(
      sharedStatus: TransactionHistorySharedStatus.loading,
      sharedErrorMessage: null,
      isLoading: resetVisibleState,
      isListLoading: false,
      isLoadingMore: false,
      monthLimit: resetVisibleState ? _kPageSize : state.monthLimit,
    );

    try {
      final record = await _repository.getTransactionsByMonth(uid, DateTime.now());
      final sharedStatus = record.transactions.isEmpty
          ? TransactionHistorySharedStatus.empty
          : TransactionHistorySharedStatus.success;

      state = state.copyWith(
        monthlyTransactions: record.transactions,
        sharedStatus: sharedStatus,
        sharedErrorMessage: null,
      );

      if (!_hasFilter) {
        _syncVisibleTransactionsFromMonthly(resetVisibleLoading: false);
      }
    } catch (error, stackTrace) {
      _handleSharedLoadError(error, stackTrace);
    }
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

    final loadingParams = TransactionHistoryHelpers.calculateLoadingStateParams(
      reset: reset,
      isRefresh: isRefresh,
      hasTransactions: state.transactions.isNotEmpty,
    );

    state = state.copyWith(
      isLoading: loadingParams.isLoading,
      isListLoading: loadingParams.isListLoading,
      isLoadingMore: loadingParams.isLoadingMore,
      transactions: loadingParams.shouldClearTransactions ? [] : state.transactions,
      errorMessage: null,
    );

    try {
      final lastTx = reset
          ? null
          : (state.transactions.isNotEmpty ? state.transactions.last : null);

      final results = await _repository.getTransactionsByFilter(
        uid,
        date: _selectedDate,
        categoryKey: _selectedCategoryKey,
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
      _logger.e(
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

  void _handleLoadError(bool reset, Object e) {
    final errorMessage = TransactionHistoryHelpers.formatErrorMessage(e);

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
    _logger.e(
      'Error loading shared monthly transactions.',
      error: error,
      stackTrace: stackTrace,
    );

    state = state.copyWith(
      sharedStatus: TransactionHistorySharedStatus.error,
      sharedErrorMessage: TransactionHistoryHelpers.formatErrorMessage(error),
      isLoading: false,
      isListLoading: false,
      isLoadingMore: false,
    );
  }
}
