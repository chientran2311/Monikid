import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/providers/auth_provider.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/repositories/transaction/transaction_repository.dart';

import 'transaction_history_state.dart';

part 'transaction_history_provider.g.dart';

const _kPageSize = 8;

@riverpod
class TransactionHistory extends _$TransactionHistory {
  late final TransactionRepository _repository;
  StreamSubscription<({List<TransactionModel> transactions, DateTime month})>? _subscription;

  @override
  TransactionHistoryState build() {
    _repository = getIt<TransactionRepository>();
    ref.onDispose(() {
      _subscription?.cancel();
    });
    return const TransactionHistoryState(selectedDate: null);
  }

  String? get _userId {
    final authState = ref.read(authProvider);
    return authState.isAuthenticated ? authState.user?.uid : null;
  }

  // -------------------------------------------------------------------------
  // PUBLIC API
  // -------------------------------------------------------------------------

  Future<void> fetchSummary() async {
    final uid = _userId;
    if (uid == null) return;

    try {
      final summary = await _repository.getSummary(
        uid,
        date: state.selectedDate,
        month: state.selectedDate == null ? DateTime.now() : null,
      );
      state = state.copyWith(
        totalIncome: summary.totalIncome,
        totalExpense: summary.totalExpense,
      );
    } catch (e) {
      // Keep previous totals if error occurs
    }
  }

  Future<void> loadFilteredTransactions({bool isLoadMore = false}) async {
    final uid = _userId;
    if (uid == null) return;

    if (!isLoadMore) {
      _subscription?.cancel();
      state = state.copyWith(
        isLoading: true,
        transactions: [],
        hasMore: true,
        errorMessage: null,
      );
    } else {
      if (!state.hasMore || state.isLoadingMore || state.isLoading) return;
      state = state.copyWith(isLoadingMore: true);
    }

    try {
      final lastTx = isLoadMore && state.transactions.isNotEmpty
          ? state.transactions.last
          : null;

      final results = await _repository.getTransactionsByFilter(
        uid,
        date: state.selectedDate,
        category: state.selectedCategory,
        type: state.transactionTypeFilter,
        lastTransaction: lastTx,
        limit: _kPageSize,
      );

      if (isLoadMore) {
        state = state.copyWith(
          isLoadingMore: false,
          transactions: [...state.transactions, ...results],
          hasMore: results.length >= _kPageSize,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          transactions: results,
          hasMore: results.length >= _kPageSize,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  /// Tải trang đầu tiên (reset list)
  Future<void> loadFirstPage() async {
    if (state.totalIncome == null && state.totalExpense == null) {
       fetchSummary(); // Initial load
    }

    bool isFiltering = state.selectedDate != null ||
        state.selectedCategory != null ||
        (state.transactionTypeFilter != 'all' && state.transactionTypeFilter.isNotEmpty);

    if (isFiltering) {
      return loadFilteredTransactions(isLoadMore: false);
    }

    final uid = _userId;
    if (uid == null) return;

    _subscription?.cancel();

    state = state.copyWith(
      isLoading: true,
      transactions: [],
      hasMore: true,
      monthLimit: _kPageSize,
      errorMessage: null,
    );

    try {
      // Realtime
      _subscription = _repository.getTransactionsByMonth(
        uid,
        DateTime.now(),
        limit: state.monthLimit,
        type: state.transactionTypeFilter,
      ).listen(
        (record) {
          state = state.copyWith(
            isLoading: false,
            transactions: record.transactions,
            hasMore: record.transactions.length >= state.monthLimit,
          );
        },
        onError: (e) {
          state = state.copyWith(
            isLoading: false,
            errorMessage: e.toString(),
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  /// Tải thêm (append) — gọi khi scroll gần cuối
  Future<void> loadMore() async {
    bool isFiltering = state.selectedDate != null ||
        state.selectedCategory != null ||
        (state.transactionTypeFilter != 'all' && state.transactionTypeFilter.isNotEmpty);

    if (isFiltering) {
      return loadFilteredTransactions(isLoadMore: true);
    } else {
      // Tăng limit stream
      state = state.copyWith(monthLimit: state.monthLimit + _kPageSize);
      
      final uid = _userId;
      if (uid == null) return;
      
      _subscription?.cancel();
      _subscription = _repository.getTransactionsByMonth(
        uid,
        DateTime.now(),
        limit: state.monthLimit,
        type: state.transactionTypeFilter,
      ).listen(
        (record) {
          state = state.copyWith(
            transactions: record.transactions,
            hasMore: record.transactions.length >= state.monthLimit,
          );
        },
      );
    }
  }

  /// Pull-to-refresh
  Future<void> refresh() async {
    if (state.isRefreshing) return;
    state = state.copyWith(isRefreshing: true);
    await loadFirstPage();
    state = state.copyWith(isRefreshing: false);
  }

  /// Thay đổi ngày filter → reload trang đầu
  Future<void> setDate(DateTime? date) async {
    if (state.selectedDate?.year == date?.year &&
        state.selectedDate?.month == date?.month &&
        state.selectedDate?.day == date?.day) {
      return;
    }
    state = state.copyWith(selectedDate: date);
    fetchSummary(); // Update summary when date changes
    await loadFirstPage();
  }

  /// Thay đổi category filter → reload trang đầu
  Future<void> setCategory(String? category) async {
    if (state.selectedCategory == category) return;
    state = state.copyWith(selectedCategory: category);
    await loadFirstPage();
  }

  /// Thay đổi lọc hiển thị Thu
  Future<void> loadIncome() async {
    if (state.transactionTypeFilter == 'income') return;
    state = state.copyWith(transactionTypeFilter: 'income');
    await loadFirstPage();
  }

  /// Thay đổi lọc hiển thị Chi
  Future<void> loadExpense() async {
    if (state.transactionTypeFilter == 'expense') return;
    state = state.copyWith(transactionTypeFilter: 'expense');
    await loadFirstPage();
  }
}
