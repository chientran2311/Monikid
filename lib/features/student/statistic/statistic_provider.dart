import 'dart:async';

import 'package:logger/logger.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/features/auth/providers/auth_session_state.dart';
import 'package:monikid/features/student/statistic/statistic_models.dart';
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
    _logger = Logger();

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

      final budgetOverview = _buildBudgetOverview(
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
        totalExpense: _minorToDouble(overview.currentPeriod.totalExpenseMinor),
        previousPeriodTotalExpense: _minorToDouble(
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

  StatisticBudgetOverview _buildBudgetOverview({
    required int? limitMinor,
    required int currentTotalExpenseMinor,
    required int previousTotalExpenseMinor,
  }) {
    if (limitMinor == null || limitMinor <= 0) {
      return StatisticBudgetOverview(
        spentMinor: currentTotalExpenseMinor,
        comparisonDirection: _comparisonDirection(
          currentTotalExpenseMinor,
          previousTotalExpenseMinor,
        ),
        comparisonPercent: _comparisonPercent(
          currentTotalExpenseMinor,
          previousTotalExpenseMinor,
        ),
      );
    }

    final remainingMinor = limitMinor - currentTotalExpenseMinor;
    final usageRatio = currentTotalExpenseMinor <= 0
        ? 0.0
        : currentTotalExpenseMinor / limitMinor;

    return StatisticBudgetOverview(
      limitMinor: limitMinor,
      spentMinor: currentTotalExpenseMinor,
      remainingMinor: remainingMinor,
      usageRatio: usageRatio.clamp(0.0, 1.0),
      status: _budgetStatus(usageRatio, remainingMinor),
      comparisonDirection: _comparisonDirection(
        currentTotalExpenseMinor,
        previousTotalExpenseMinor,
      ),
      comparisonPercent: _comparisonPercent(
        currentTotalExpenseMinor,
        previousTotalExpenseMinor,
      ),
    );
  }

  StatisticBudgetStatus _budgetStatus(double usageRatio, int remainingMinor) {
    if (remainingMinor < 0) {
      return StatisticBudgetStatus.exceeded;
    }
    if (usageRatio >= 0.8) {
      return StatisticBudgetStatus.warning;
    }
    return StatisticBudgetStatus.onTrack;
  }

  StatisticTrendDirection _comparisonDirection(
    int currentTotalExpenseMinor,
    int previousTotalExpenseMinor,
  ) {
    if (currentTotalExpenseMinor > previousTotalExpenseMinor) {
      return StatisticTrendDirection.up;
    }
    if (currentTotalExpenseMinor < previousTotalExpenseMinor) {
      return StatisticTrendDirection.down;
    }
    if (currentTotalExpenseMinor == 0 && previousTotalExpenseMinor == 0) {
      return StatisticTrendDirection.none;
    }
    return StatisticTrendDirection.stable;
  }

  double? _comparisonPercent(
    int currentTotalExpenseMinor,
    int previousTotalExpenseMinor,
  ) {
    if (previousTotalExpenseMinor <= 0) {
      if (currentTotalExpenseMinor <= 0) {
        return null;
      }
      return 100.0;
    }

    final difference = (currentTotalExpenseMinor - previousTotalExpenseMinor).abs();
    return (difference / previousTotalExpenseMinor) * 100;
  }

  double _minorToDouble(int amountMinor) {
    return amountMinor.toDouble();
  }
}
