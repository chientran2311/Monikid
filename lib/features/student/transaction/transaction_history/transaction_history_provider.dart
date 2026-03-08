import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/providers/auth_provider.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/repositories/transaction/transaction_repository.dart';
import 'package:logger/logger.dart';

import 'transaction_history_state.dart';

part 'transaction_history_provider.g.dart';

const _kPageSize = 8;

@riverpod
Stream<({double totalIncome, double totalExpense})> streamSummaryCard(
  Ref ref, {
  DateTime? date,
  DateTime? month,
}) {
  final log = getIt<Logger>();
  final authState = ref.watch(authProvider);
  final uid = authState.user?.uid;

  log.i('🔍 streamSummaryCard called | uid=$uid | date=$date | month=$month');

  if (uid == null) {
    log.w('⚠️ uid is null → returning empty stream');
    return Stream.value((totalIncome: 0.0, totalExpense: 0.0));
  }

  final repository = getIt<TransactionRepository>();
  return repository.watchSummary(uid, date: date, month: month).map((data) {
    log.i('✅ watchSummary emit | income=${data.totalIncome} | expense=${data.totalExpense}');
    return data;
  }).handleError((e, st) {
    log.e('❌ watchSummary error: $e', error: e, stackTrace: st);
    throw e;
  });
}

@riverpod
class TransactionHistory extends _$TransactionHistory {
  late final TransactionRepository _repository;
  StreamSubscription<({List<TransactionModel> transactions, DateTime month})>?
  _subscription;

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

  Future<void> loadFilteredTransactions({bool isLoadMore = false}) async {
    final uid = _userId;
    if (uid == null) return;

    if (!isLoadMore) {
      _subscription?.cancel();
      final isFirst = state.transactions.isEmpty;
      state = state.copyWith(
        isLoading: isFirst,
        isListLoading: !isFirst,
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
          isListLoading: false,
          transactions: results,
          hasMore: results.length >= _kPageSize,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isListLoading: false,
        isLoadingMore: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  /// Tải trang đầu tiên (reset list)
  Future<void> loadFirstPage() async {
    bool isFiltering =
        state.selectedDate != null || state.selectedCategory != null;

    if (isFiltering) {
      return loadFilteredTransactions(isLoadMore: false);
    }

    final uid = _userId;
    if (uid == null) return;

    _subscription?.cancel();

    final isFirst = state.transactions.isEmpty;
    state = state.copyWith(
      isLoading: isFirst,
      isListLoading: !isFirst,
      transactions: [],
      hasMore: true,
      monthLimit: _kPageSize,
      errorMessage: null,
    );

    try {
      // Realtime
      _subscription = _repository
          .getTransactionsByMonth(uid, DateTime.now(), limit: state.monthLimit)
          .listen(
            (record) {
              state = state.copyWith(
                isLoading: false,
                isListLoading: false,
                transactions: record.transactions,
                hasMore: record.transactions.length >= state.monthLimit,
              );
            },
            onError: (e) {
              state = state.copyWith(
                isLoading: false,
                isListLoading: false,
                errorMessage: e.toString(),
              );
            },
          );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isListLoading: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  /// Tải thêm (append) — gọi khi scroll gần cuối
  Future<void> loadMore() async {
    bool isFiltering =
        state.selectedDate != null || state.selectedCategory != null;

    if (isFiltering) {
      return loadFilteredTransactions(isLoadMore: true);
    } else {
      // Tăng limit stream
      state = state.copyWith(monthLimit: state.monthLimit + _kPageSize);

      final uid = _userId;
      if (uid == null) return;

      _subscription?.cancel();
      _subscription = _repository
          .getTransactionsByMonth(uid, DateTime.now(), limit: state.monthLimit)
          .listen((record) {
            state = state.copyWith(
              transactions: record.transactions,
              hasMore: record.transactions.length >= state.monthLimit,
            );
          });
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
    await loadFirstPage();
  }

  /// Thay đổi category filter → reload trang đầu
  Future<void> setCategory(String? category) async {
    if (state.selectedCategory == category) return;
    state = state.copyWith(selectedCategory: category);
    await loadFirstPage();
  }

  /// Thay đổi lọc hiển thị (chỉ cập nhật UI client-side)
  void setTypeFilter(String type) {
    if (state.transactionTypeFilter == type) return;
    state = state.copyWith(transactionTypeFilter: type);
  }
}
