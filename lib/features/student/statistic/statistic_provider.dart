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
  StreamSubscription<({List<TransactionModel> transactions, DateTime start, DateTime end})>? _subscription;

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
  
  ({DateTime start, DateTime end}) _getPeriodRange() {
    final now = DateTime.now();
    final targetDate = state.selectedDate ?? now;
    if (state.selectedMonthIndex == 0) {
      // Theo tuần (By Week): Monday to Sunday
      final referenceDate = DateTime(targetDate.year, targetDate.month, targetDate.day);
      final int currentDay = referenceDate.weekday;
      final DateTime startOfWeek = referenceDate.subtract(Duration(days: currentDay - 1));
      final DateTime start = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
      final DateTime end = DateTime(start.year, start.month, start.day + 6, 23, 59, 59, 999);
      return (start: start, end: end);
    } else {
      // Theo tháng (By Month)
      final start = DateTime(targetDate.year, targetDate.month, 1);
      final end = DateTime(targetDate.year, targetDate.month + 1, 0, 23, 59, 59, 999);
      return (start: start, end: end);
    }
  }
  
  ({DateTime start, DateTime end}) _getPreviousPeriodRange() {
    final now = DateTime.now();
    final targetDate = state.selectedDate ?? now;
    if (state.selectedMonthIndex == 0) {
      // Previous week
      final referenceDate = DateTime(targetDate.year, targetDate.month, targetDate.day);
      final int currentDay = referenceDate.weekday;
      final DateTime startOfPrevWeek = referenceDate.subtract(Duration(days: currentDay - 1 + 7));
      final DateTime start = DateTime(startOfPrevWeek.year, startOfPrevWeek.month, startOfPrevWeek.day);
      final DateTime end = DateTime(start.year, start.month, start.day + 6, 23, 59, 59, 999);
      return (start: start, end: end);
    } else {
      // Previous month
      final start = DateTime(targetDate.year, targetDate.month - 1, 1);
      final end = DateTime(targetDate.year, targetDate.month, 0, 23, 59, 59, 999);
      return (start: start, end: end);
    }
  }

  Future<void> loadFirstPage() async {
    final uid = _userId;
    if (uid == null) return;

    _subscription?.cancel();

    state = state.copyWith(
      isLoading: true,
      transactions: [],
      hasMore: true,
      pageLimit: _kPageSize,
      errorMessage: null,
    );

    try {
      final targetRange = _getPeriodRange();
      final prevRange = _getPreviousPeriodRange();
      
      final prevRecord = await _repository.getExpenseTransactionsByDateRange(
        uid, 
        prevRange.start, 
        prevRange.end, 
        limit: 1000
      ).first;
      
      double prevPeriodTotal = 0;
      for (var tx in prevRecord.transactions) {
        prevPeriodTotal += tx.amount;
      }
      
      _subscription = _repository.getExpenseTransactionsByDateRange(
        uid,
        targetRange.start,
        targetRange.end,
        limit: _kPageSize,
      ).listen(
        (record) {
          double currentTotal = 0;
          for (var tx in record.transactions) {
            currentTotal += tx.amount;
          }
          
          state = state.copyWith(
            isLoading: false,
            transactions: record.transactions,
            previousPeriodTransactions: prevRecord.transactions,
            totalExpense: currentTotal,
            previousPeriodTotalExpense: prevPeriodTotal,
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
    state = state.copyWith(isLoadingMore: true, pageLimit: state.pageLimit + _kPageSize);
      
    final uid = _userId;
    if (uid == null) {
      state = state.copyWith(isLoadingMore: false);
      return;
    }
    
    _subscription?.cancel();
    
    final targetRange = _getPeriodRange();
    
    _subscription = _repository.getExpenseTransactionsByDateRange(
      uid,
      targetRange.start,
      targetRange.end,
      limit: state.pageLimit,
    ).listen(
      (record) {
        double currentTotal = 0;
        for (var tx in record.transactions) {
          currentTotal += tx.amount;
        }

        state = state.copyWith(
          transactions: record.transactions,
          totalExpense: currentTotal,
          hasMore: record.transactions.length >= state.pageLimit,
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
    state = state.copyWith(selectedMonthIndex: index, selectedDate: DateTime.now());
    await loadFirstPage();
  }

  Future<void> setSelectedDate(DateTime date) async {
    final currentTarget = state.selectedDate ?? DateTime.now();
    if (currentTarget.year == date.year && currentTarget.month == date.month && currentTarget.day == date.day) return;
    state = state.copyWith(selectedDate: date);
    await loadFirstPage();
  }
}
