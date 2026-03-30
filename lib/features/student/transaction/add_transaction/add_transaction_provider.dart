import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/student/transaction/transaction_status.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/repositories/transaction/transaction_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'add_transaction_state.dart';

part 'add_transaction_provider.g.dart';

@riverpod
class AddTransactionNotifier extends _$AddTransactionNotifier {
  late final TransactionRepository _repository;
  late final Logger _logger;

  @override
  AddTransactionState build() {
    _repository = getIt<TransactionRepository>();
    _logger = getIt<Logger>();
    return const AddTransactionState();
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    state = state.copyWith(
      status: TransactionStatus.loading,
      errorMessage: null,
    );

    try {
      _logger.i('Adding transaction ${transaction.transactionId}');
      await _repository.addTransaction(transaction);
      state = state.copyWith(
        status: TransactionStatus.success,
        errorMessage: null,
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Add transaction failed',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: TransactionStatus.error,
        errorMessage: 'Không thể thêm giao dịch. Vui lòng thử lại.',
      );
    }
  }
}
