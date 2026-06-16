import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/parent/home/parent_home_notifier.dart';
import 'package:monikid/features/parent/statistic/parent_statistic_state.dart';
import 'package:monikid/repositories/parent_statistic/parent_statistic_repository.dart';

part 'parent_statistic_provider.g.dart';

@Riverpod(keepAlive: false)
class ParentStatisticNotifier extends _$ParentStatisticNotifier {
  late final ParentStatisticRepository _repository;
  late final Logger _logger;

  @override
  ParentStatisticState build() {
    _repository = getIt<ParentStatisticRepository>();
    _logger = getIt<Logger>();

    ref.listen(
      parentHomeNotifierProvider.select((state) => state.selectedMemberId),
      (previous, next) {
        if (next != null && next.isNotEmpty && next != previous) {
          fetchForChild(next);
        }
      },
    );

    return const ParentStatisticState();
  }

  void setPeriod(ParentStatisticPeriod period) {
    if (state.period == period) return;
    // Reset the anchor to "now" when switching period, then refetch — matches
    // the child statistic screen's setTabIndex behavior.
    state = state.copyWith(period: period, selectedDate: DateTime.now());
    if (state.selectedChildId.isNotEmpty) {
      fetchForChild(state.selectedChildId);
    }
  }

  void setSelectedDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
    if (state.selectedChildId.isNotEmpty) {
      fetchForChild(state.selectedChildId);
    }
  }

  Future<void> fetchForChild(String childUid) async {
    if (childUid.isEmpty) return;

    _logger.i('ParentStatisticNotifier: fetching for child=$childUid.');

    state = state.copyWith(
      status: ParentStatisticStatus.loading,
      selectedChildId: childUid,
      errorMessage: null,
    );

    try {
      final overview = await _repository.getChildOverview(
        childUid: childUid,
        anchorDate: state.selectedDate ?? DateTime.now(),
        selectedTabIndex: state.period.index,
      );

      final newStatus = overview.totalExpenseMinor == 0 &&
              overview.topCategories.isEmpty &&
              overview.topIncomeCategories.isEmpty
          ? ParentStatisticStatus.empty
          : ParentStatisticStatus.success;

      state = state.copyWith(
        status: newStatus,
        totalExpenseMinor: overview.totalExpenseMinor,
        prevTotalExpenseMinor: overview.prevTotalExpenseMinor,
        dailyData: overview.dailyData,
        topCategories: overview.topCategories,
        incomeCategories: overview.topIncomeCategories,
      );

      _logger.i(
        'ParentStatisticNotifier: loaded child=$childUid '
        'total=${overview.totalExpenseMinor} categories=${overview.topCategories.length}.',
      );
    } catch (error, stackTrace) {
      _logger.e(
        'ParentStatisticNotifier: failed to load for child=$childUid.',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: ParentStatisticStatus.error,
        errorMessage: error.toString(),
      );
    }
  }

  Future<void> retry() async {
    if (state.selectedChildId.isEmpty) return;
    await fetchForChild(state.selectedChildId);
  }
}
