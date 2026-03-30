import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/repositories/transaction/transaction_repository.dart';
import 'package:logger/logger.dart';
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
      .watchSummary(uid, date: date, month: month)
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

@riverpod
class TransactionHistory extends _$TransactionHistory {
  late final TransactionRepository _repository;
  StreamSubscription<({List<TransactionModel> transactions, DateTime month})>?
      _subscription;

  @override
  TransactionHistoryState build() {
    _repository = ref.read(transactionRepositoryProvider);
    ref.onDispose(() => _subscription?.cancel());
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
      state.selectedCategory != null ||
      state.transactionTypeFilter != 'all';

  String? get _activeType {
    final t = state.transactionTypeFilter;
    return t == 'all' ? null : t;
  }

  void _cancelStream() {
    _subscription?.cancel();
    _subscription = null;
  }

  // ---------------------------------------------------------------------------
  // PUBLIC METHODS
  // ---------------------------------------------------------------------------

  /// 1. PUBLIC METHOD: Initialize data
  Future<void> init() async {
    if (state.transactions.isNotEmpty && !state.isLoading) return;
    ref.invalidate(streamSummaryCardProvider);
    await _loadData(reset: true);
  }

  /// 2. PUBLIC METHOD: Pull to refresh
  Future<void> refresh() async {
    ref.invalidate(streamSummaryCardProvider);
    await _loadData(reset: true, isRefresh: true);
  }

  /// 3. PUBLIC METHOD: Load next page
  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore || state.isLoading) {
      return;
    }
    await _loadData(reset: false);
  }

  /// 4. PUBLIC METHOD: Filter by Date
  Future<void> getTransByDate(DateTime? date) async {
    if (state.selectedDate == date) return;
    state = state.copyWith(selectedDate: date);
    ref.invalidate(streamSummaryCardProvider);
    await _loadData(reset: true);
  }

  /// 5. PUBLIC METHOD: Filter by Category
  Future<void> getTransByCategory(String? category) async {
    if (state.selectedCategory == category) return;
    state = state.copyWith(selectedCategory: category);
    await _loadData(reset: true);
  }

  /// 6. PUBLIC METHOD: Filter by Type
  Future<void> setTypeFilter(String type) async {
    if (state.transactionTypeFilter == type) return;
    state = state.copyWith(transactionTypeFilter: type);
    await _loadData(reset: true);
  }

  // ---------------------------------------------------------------------------
  // PRIVATE METHOD: CORE LOGIC
  // ---------------------------------------------------------------------------

  Future<void> _loadData({required bool reset, bool isRefresh = false}) async {
    final uid = _userId;
    if (uid == null) {
      _cancelStream();
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
      if (_hasFilter) {
        // --- FUTURE / HTTP PATTERN ---
        _cancelStream();
        final lastTx = reset
            ? null
            : (state.transactions.isNotEmpty ? state.transactions.last : null);

        final results = await _repository.getTransactionsByFilter(
          uid,
          date: state.selectedDate,
          category: state.selectedCategory,
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
      } else {
        // --- REALTIME STREAM PATTERN ---
        if (reset) {
          _cancelStream();
          state = state.copyWith(monthLimit: _kPageSize);
        } else {
          state = state.copyWith(monthLimit: state.monthLimit + _kPageSize);
          _cancelStream(); // Resubscribe with new limit
        }

        _subscription = _repository
            .getTransactionsByMonth(
              uid,
              DateTime.now(),
              limit: state.monthLimit + 1,
            )
            .listen(
          (record) {
            final hasMore = record.transactions.length > state.monthLimit;
            final visibleTransactions = hasMore
                ? record.transactions.take(state.monthLimit).toList()
                : record.transactions;

            state = state.copyWith(
              isLoading: false,
              isListLoading: false,
              isLoadingMore: false,
              transactions: visibleTransactions,
              hasMore: hasMore,
              errorMessage: null,
            );
          },
          onError: (e) => _handleLoadError(reset, e),
        );
      }
    } catch (e, stack) {
      Logger().e('Error loading transactions: $e', error: e, stackTrace: stack);
      _handleLoadError(reset, e);
    }
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
}
