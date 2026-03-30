import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/student/transaction/transaction_status.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/repositories/transaction/transaction_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'detail_transaction_state.dart';

part 'detail_transaction_provider.g.dart';

@riverpod
class DetailTransactionNotifier extends _$DetailTransactionNotifier {
  late final Logger _logger;

  @override
  DetailTransactionState build() {
    _logger = getIt<Logger>();
    return const DetailTransactionState();
  }

  void setTransaction(TransactionModel transaction) {
    state = state.copyWith(
      status: TransactionStatus.ready,
      transaction: transaction,
      errorMessage: null,
    );
  }

  Future<void> deleteTransaction(String transactionId) async {
    state = state.copyWith(
      status: TransactionStatus.submitting,
      errorMessage: null,
    );

    try {
      _logger.i('Deleting transaction $transactionId');
      await ref.read(transactionRepositoryProvider).deleteTransaction(transactionId);
      state = state.copyWith(
        status: TransactionStatus.success,
        errorMessage: null,
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Delete transaction failed',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: TransactionStatus.error,
        errorMessage: 'Không thể xóa giao dịch. Vui lòng thử lại.',
      );
    }
  }
}
