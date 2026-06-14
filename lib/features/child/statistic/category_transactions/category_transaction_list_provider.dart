import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/child/statistic/category_transactions/category_transaction_list_state.dart';
import 'package:monikid/features/child/statistic/category_transactions/category_transactions_args.dart';
import 'package:monikid/features/transaction/transaction_type.dart';
import 'package:monikid/repositories/transaction/transaction_repository.dart';

part 'category_transaction_list_provider.g.dart';

@riverpod
class CategoryTransactionListNotifier
    extends _$CategoryTransactionListNotifier {
  late Logger _logger;
  late TransactionRepository _repository;

  @override
  CategoryTransactionListState build() {
    _logger = getIt<Logger>();
    _repository = ref.read(transactionRepositoryProvider);
    return const CategoryTransactionListState();
  }

  Future<void> load(CategoryTransactionsArgs args) async {
    _logger.d(
      'CategoryTransactionListNotifier.load: '
      'categoryKey=${args.categoryKey}, tabIndex=${args.selectedTabIndex}, '
      'type=${args.transactionType.value}',
    );

    if (args.categoryKey.isEmpty) {
      state = const CategoryTransactionListState(
        status: CategoryTransactionListStatus.empty,
      );
      return;
    }

    state = state.copyWith(
      status: CategoryTransactionListStatus.loading,
      errorMessage: null,
    );

    try {
      final userId = ref.read(authSessionProvider).user?.uid ?? '';
      if (userId.isEmpty) {
        state = state.copyWith(
          status: CategoryTransactionListStatus.error,
          errorMessage: 'User not authenticated.',
        );
        return;
      }

      final transactions = await _repository.getTransactionsByCategoryAndPeriod(
        userId,
        categoryKey: args.categoryKey,
        selectedTabIndex: args.selectedTabIndex,
        anchorDate: args.anchorDate,
        type: args.transactionType,
      );

      _logger.i(
        'CategoryTransactionListNotifier.load: success. count=${transactions.length}',
      );

      state = state.copyWith(
        status: transactions.isEmpty
            ? CategoryTransactionListStatus.empty
            : CategoryTransactionListStatus.success,
        transactions: transactions,
      );
    } catch (error, stackTrace) {
      _logger.e(
        'CategoryTransactionListNotifier.load failed.',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: CategoryTransactionListStatus.error,
        errorMessage: 'Failed to load transactions.',
      );
    }
  }
}
