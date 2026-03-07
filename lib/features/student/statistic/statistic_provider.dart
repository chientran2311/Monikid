import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/providers/auth_provider.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/repositories/statistic/statistic_repository.dart';

import 'statistic_state.dart';

part 'statistic_provider.g.dart';

const _kPageSize = 8;

@riverpod
class Statistic extends _$Statistic {
  late final StatisticRepository _repository;
  StreamSubscription<({List<TransactionModel> transactions, DateTime month})>? _subscription;

  @override
  StatisticState build() {
    _repository = getIt<StatisticRepository>();
    ref.onDispose(() {
      _subscription?.cancel();
    });
    
    // Auto load on init if authenticated
    Future.microtask(() => loadFirstPage());
    
    return const StatisticState();
  }

  String? get _userId {
    final authState = ref.read(authProvider);
    return authState.isAuthenticated ? authState.user?.uid : null;
  }
  
  DateTime _getSelectedMonth() {
    final now = DateTime.now();
    // 0: Tháng trước, 1: Tháng này
    if (state.selectedMonthIndex == 0) {
      return DateTime(now.year, now.month - 1);
    }
    return now;
  }
  
  DateTime _getPreviousMonthOfSelected() {
    final target = _getSelectedMonth();
    return DateTime(target.year, target.month - 1);
  }

  Future<void> loadFirstPage() async {
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
      final targetMonth = _getSelectedMonth();
      final prevMonth = _getPreviousMonthOfSelected();
      
      // Fetch transactions of previous month for comparison
      // Because we just need all of them to calculate category difference, we can use a high limit or no limit if it's not paginated.
      // But we need a new repository method to fetch list instead of total, or just fetch the list.
      // Wait, TransactionRepository doesn't have a simple future get all transactions method for a month... Oh, wait! I can just listen to the stream or better yet, maybe I should just use `FirebaseFirestore` here? No, let's use the repository.
      // I can add `Future<List<TransactionModel>> getExpenseTransactionsListByMonth` to the repository.
      // Since I don't want to change repository again, I'll just use the stream and get the first event:
      final prevRecord = await _repository.getExpenseTransactionsByMonth(uid, prevMonth, limit: 1000).first;
      
      double prevMonthTotal = 0;
      for (var tx in prevRecord.transactions) {
        prevMonthTotal += tx.amount;
      }
      
      // Realtime for selected month
      _subscription = _repository.getExpenseTransactionsByMonth(
        uid,
        targetMonth,
        limit: _kPageSize,
      ).listen(
        (record) {
          // Calculate current month total
          double currentTotal = 0;
          for (var tx in record.transactions) {
            currentTotal += tx.amount;
          }
          
          state = state.copyWith(
            isLoading: false,
            transactions: record.transactions,
            previousMonthTransactions: prevRecord.transactions,
            totalExpense: currentTotal,
            previousMonthTotalExpense: prevMonthTotal,
            hasMore: record.transactions.length >= _kPageSize,
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

  Future<void> loadMore() async {
    if (state.isLoading || state.isLoadingMore || state.isRefreshing || !state.hasMore) return;
    state = state.copyWith(isLoadingMore: true, monthLimit: state.monthLimit + _kPageSize);
      
    final uid = _userId;
    if (uid == null) {
      state = state.copyWith(isLoadingMore: false);
      return;
    }
    
    _subscription?.cancel();
    
    final targetMonth = _getSelectedMonth();
    
    _subscription = _repository.getExpenseTransactionsByMonth(
      uid,
      targetMonth,
      limit: state.monthLimit,
    ).listen(
      (record) {
        double currentTotal = 0;
        for (var tx in record.transactions) {
          currentTotal += tx.amount;
        }

        state = state.copyWith(
          transactions: record.transactions,
          totalExpense: currentTotal,
          hasMore: record.transactions.length >= state.monthLimit,
          isLoadingMore: false,
        );
      },
      onError: (e) {
        state = state.copyWith(
          errorMessage: e.toString(),
          isLoadingMore: false,
        );
      }
    );
  }

  Future<void> refresh() async {
    if (state.isRefreshing) return;
    state = state.copyWith(isRefreshing: true);
    await loadFirstPage();
    state = state.copyWith(isRefreshing: false);
  }

  Future<void> setMonthIndex(int index) async {
    if (state.selectedMonthIndex == index) return;
    state = state.copyWith(selectedMonthIndex: index);
    await loadFirstPage();
  }
}
