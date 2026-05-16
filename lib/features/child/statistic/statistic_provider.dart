import 'dart:async';

import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/features/auth/providers/auth_session_state.dart';
import 'package:monikid/features/child/statistic/statistic_helpers.dart';
import 'package:monikid/features/child/statistic/statistic_models.dart';
import 'package:monikid/repositories/set_money_limit/set_money_limit_repository.dart';
import 'package:monikid/repositories/statistic/statistic_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'statistic_state.dart';

part 'statistic_provider.g.dart';

const _kPageSize = 8;

@riverpod
class Statistic extends _$Statistic {
  late final StatisticRepository _repository;
  late final SetMoneyLimitRepository _setMoneyLimitRepository;
  late final Logger _logger;

  @override
  StatisticState build() {
    _repository = ref.read(statisticRepositoryProvider);
    _setMoneyLimitRepository = ref.read(setMoneyLimitRepositoryProvider);
    _logger = getIt<Logger>();

    ref.listen<AuthSessionState>(authSessionProvider, (previous, next) {
      final previousUid = previous?.user?.uid;
      final nextUid = next.user?.uid;
      final hasAuthTransition =
          previous?.isAuthenticated != next.isAuthenticated ||
          previousUid != nextUid;

      if (!hasAuthTransition) {
        return;
      }

      unawaited(_handleAuthStateChanged(next));
    });

    final authState = ref.read(authSessionProvider);
    if (authState.isAuthenticated && authState.user?.uid != null) {
      Future.microtask(loadFirstPage);
    }

    return StatisticState(selectedDate: DateTime.now());
  }

  String? get _userId {
    final authState = ref.read(authSessionProvider);
    return authState.isAuthenticated ? authState.user?.uid : null;
  }

  Future<void> _handleAuthStateChanged(AuthSessionState authState) async {
    if (authState.isAuthenticated && authState.user?.uid != null) {
      await loadFirstPage();
      return;
    }

    state = state.copyWith(
      transactions: const [],
      previousPeriodTransactions: const [],
      visibleTransactions: const [],
      status: StatisticStatus.initial,
      isLoadingMore: false,
      isRefreshing: false,
      hasMore: true,
      pageLimit: _kPageSize,
      totalExpense: 0,
      previousPeriodTotalExpense: 0,
      currentOverview: null,
      previousOverview: null,
      budgetOverview: null,
      errorMessage: null,
    );
  }

  Future<void> loadFirstPage() async {
    final uid = _userId;
    if (uid == null) {
      return;
    }

    final anchorDate = state.selectedDate ?? DateTime.now();
    final range = statisticGetPeriodRange(
      selectedMonthIndex: state.selectedMonthIndex,
      anchorDate: anchorDate,
    );

    state = state.copyWith(
      status: StatisticStatus.loading,
      isLoadingMore: false,
      pageLimit: _kPageSize,
      errorMessage: null,
    );

    try {
      final overviewFuture = _repository.getOverview(
        userId: uid,
        selectedMonthIndex: state.selectedMonthIndex,
        anchorDate: anchorDate,
      );
      final pageFuture = _repository.getExpenseTransactionsPage(
        userId: uid,
        start: range.start,
        end: range.end,
        limit: _kPageSize,
      );
      final limitFuture = _setMoneyLimitRepository.readMonthlyLimitMinor(uid);

      final overview = await overviewFuture;
      final page = await pageFuture;
      final limitMinor = await limitFuture;

      if (overview == null) {
        state = state.copyWith(
          status: StatisticStatus.error,
          errorMessage: 'Unable to load statistic data.',
        );
        return;
      }

      final budgetOverview = StatisticHelpers.buildBudgetOverview(
        limitMinor: limitMinor,
        currentTotalExpenseMinor: overview.currentPeriod.totalExpenseMinor,
        previousTotalExpenseMinor: overview.previousPeriod.totalExpenseMinor,
      );
      final nextStatus = overview.currentTransactions.isEmpty
          ? StatisticStatus.empty
          : StatisticStatus.success;

      state = state.copyWith(
        transactions: overview.currentTransactions,
        previousPeriodTransactions: overview.previousTransactions,
        visibleTransactions: page.transactions,
        status: nextStatus,
        hasMore: page.hasMore,
        totalExpense: StatisticHelpers.minorToDouble(overview.currentPeriod.totalExpenseMinor),
        previousPeriodTotalExpense: StatisticHelpers.minorToDouble(
          overview.previousPeriod.totalExpenseMinor,
        ),
        currentOverview: overview.currentPeriod,
        previousOverview: overview.previousPeriod,
        budgetOverview: budgetOverview,
        errorMessage: null,
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to load the statistic first page.',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: StatisticStatus.error,
        errorMessage: 'Unable to load statistic data.',
      );
    }
  }

  Future<void> loadMore() async {
    if (state.isLoading || state.isLoadingMore || state.isRefreshing || !state.hasMore) {
      return;
    }

    final uid = _userId;
    if (uid == null) {
      return;
    }

    final anchorDate = state.selectedDate ?? DateTime.now();
    final range = statisticGetPeriodRange(
      selectedMonthIndex: state.selectedMonthIndex,
      anchorDate: anchorDate,
    );
    final lastVisibleTransaction = state.visibleTransactions.isNotEmpty
        ? state.visibleTransactions.last
        : null;

    state = state.copyWith(isLoadingMore: true);

    try {
      final page = await _repository.getExpenseTransactionsPage(
        userId: uid,
        start: range.start,
        end: range.end,
        lastTransaction: lastVisibleTransaction,
        limit: _kPageSize,
      );

      state = state.copyWith(
        visibleTransactions: [
          ...state.visibleTransactions,
          ...page.transactions,
        ],
        hasMore: page.hasMore,
        isLoadingMore: false,
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to load more statistic transactions.',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        isLoadingMore: false,
        errorMessage: 'Unable to load more statistic transactions.',
      );
    }
  }

  Future<void> refresh() async {
    if (state.isRefreshing) {
      return;
    }

    state = state.copyWith(isRefreshing: true);
    await loadFirstPage();
    state = state.copyWith(isRefreshing: false);
  }

  Future<void> setMonthIndex(int index) async {
    if (state.selectedMonthIndex == index) {
      return;
    }

    state = state.copyWith(
      selectedMonthIndex: index,
      selectedDate: DateTime.now(),
    );
    await loadFirstPage();
  }

  Future<void> setSelectedDate(DateTime date) async {
    final currentTarget = state.selectedDate ?? DateTime.now();
    if (currentTarget.year == date.year &&
        currentTarget.month == date.month &&
        currentTarget.day == date.day) {
      return;
    }

    state = state.copyWith(selectedDate: date);
    await loadFirstPage();
  }

}
