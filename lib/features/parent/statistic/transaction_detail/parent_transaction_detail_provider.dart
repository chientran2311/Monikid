import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/parent/statistic/transaction_detail/parent_transaction_detail_state.dart';
import 'package:monikid/repositories/parent_statistic/parent_statistic_repository.dart';

part 'parent_transaction_detail_provider.g.dart';

@riverpod
class ParentTransactionDetailNotifier extends _$ParentTransactionDetailNotifier {
  late final Logger _logger;
  late final ParentStatisticRepository _repository;

  @override
  ParentTransactionDetailState build() {
    _logger = getIt<Logger>();
    _repository = ref.read(parentStatisticRepositoryProvider);
    return const ParentTransactionDetailState();
  }

  Future<void> load({
    required String childUid,
    required String transactionId,
  }) async {
    if (childUid.isEmpty || transactionId.isEmpty) {
      state = const ParentTransactionDetailState(
        status: ParentTransactionDetailStatus.empty,
      );
      return;
    }

    state = state.copyWith(
      status: ParentTransactionDetailStatus.loading,
      errorMessage: null,
    );

    try {
      final transaction = await _repository.getChildTransactionById(
        childUid: childUid,
        transactionId: transactionId,
      );

      state = state.copyWith(
        status: transaction == null
            ? ParentTransactionDetailStatus.empty
            : ParentTransactionDetailStatus.success,
        transaction: transaction,
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to load parent transaction detail.',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: ParentTransactionDetailStatus.error,
        errorMessage: error.toString(),
      );
    }
  }
}
