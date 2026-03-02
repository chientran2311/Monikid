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

  @override
  TransactionHistoryState build() {
    _repository = getIt<TransactionRepository>();
    return const TransactionHistoryState(selectedDate: null);
  }

  String? get _userId {
    final authState = ref.read(authProvider);
    return authState.isAuthenticated ? authState.user?.uid : null;
  }

  // -------------------------------------------------------------------------
  // PUBLIC API
  // -------------------------------------------------------------------------

  /// Tải trang đầu tiên (reset list)
  Future<void> loadFirstPage() async {
    final uid = _userId;
    if (uid == null) return;

    state = state.copyWith(
      isLoading: true,
      transactions: [],
      hasMore: true,
      errorMessage: null,
    );

    try {
      final results = await _repository.getTransactionsByDateAndCategory(
        uid,
        date: state.selectedDate,
        category: state.selectedCategory,
        limit: _kPageSize,
      );

      state = state.copyWith(
        isLoading: false,
        transactions: results,
        hasMore: results.length >= _kPageSize,
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
    if (!state.hasMore || state.isLoadingMore || state.isLoading) return;

    final uid = _userId;
    if (uid == null) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final lastTx = state.transactions.isNotEmpty
          ? state.transactions.last
          : null;

      final results = await _repository.getTransactionsByDateAndCategory(
        uid,
        date: state.selectedDate,
        category: state.selectedCategory,
        lastTransaction: lastTx,
        limit: _kPageSize,
      );

      state = state.copyWith(
        isLoadingMore: false,
        transactions: [...state.transactions, ...results],
        hasMore: results.length >= _kPageSize,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
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
    state = state.copyWith(selectedDate: date, selectedCategory: null);
    await loadFirstPage();
  }

  /// Thay đổi category filter → reload trang đầu
  Future<void> setCategory(String? category) async {
    if (state.selectedCategory == category) return;
    state = state.copyWith(selectedCategory: category);
    await loadFirstPage();
  }
}
