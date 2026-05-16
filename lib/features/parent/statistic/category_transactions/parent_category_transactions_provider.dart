import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/parent/statistic/category_transactions/parent_category_transactions_state.dart';
import 'package:monikid/features/parent/statistic/parent_statistic_state.dart';
import 'package:monikid/repositories/parent_statistic/parent_statistic_repository.dart';

part 'parent_category_transactions_provider.g.dart';

@riverpod
class ParentCategoryTransactionsNotifier
    extends _$ParentCategoryTransactionsNotifier {
  late final Logger _logger;
  late final ParentStatisticRepository _repository;

  @override
  ParentCategoryTransactionsState build() {
    _logger = getIt<Logger>();
    _repository = ref.read(parentStatisticRepositoryProvider);
    return const ParentCategoryTransactionsState();
  }

  Future<void> load({
    required String childUid,
    required String categoryKey,
    required ParentStatisticPeriod period,
  }) async {
    if (childUid.isEmpty || categoryKey.isEmpty) {
      state = const ParentCategoryTransactionsState(
        status: ParentCategoryTransactionsStatus.empty,
      );
      return;
    }

    state = state.copyWith(
      status: ParentCategoryTransactionsStatus.loading,
      errorMessage: null,
    );

    try {
      final transactions = await _repository.getChildTransactionsByCategory(
        childUid: childUid,
        categoryKey: categoryKey,
        selectedMonthIndex: period == ParentStatisticPeriod.week ? 0 : 1,
        anchorDate: DateTime.now(),
      );

      state = state.copyWith(
        status: transactions.isEmpty
            ? ParentCategoryTransactionsStatus.empty
            : ParentCategoryTransactionsStatus.success,
        transactions: transactions,
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to load parent category transactions.',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: ParentCategoryTransactionsStatus.error,
        errorMessage: error.toString(),
      );
    }
  }
}
