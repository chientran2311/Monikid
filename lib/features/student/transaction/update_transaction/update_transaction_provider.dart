import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:monikid/core/di/locator.dart';
import 'package:monikid/repositories/transaction/transaction_repository.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'update_transaction_state.dart';

part 'update_transaction_provider.g.dart';

@riverpod
class UpdateTransactionNotifier extends _$UpdateTransactionNotifier {
  late final TransactionRepository _repository;

  @override
  UpdateTransactionState build() {
    _repository = getIt<TransactionRepository>();
    return const UpdateTransactionState.initial();
  }

  Future<void> updateTransaction(TransactionModel transaction) async {
    state = const UpdateTransactionState.loading();
    try {
      await _repository.updateTransaction(transaction);
      state = const UpdateTransactionState.success();
    } catch (e) {
      state = UpdateTransactionState.error(e.toString());
    }
  }
}
