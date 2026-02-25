import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:monikid/core/di/locator.dart';
import 'package:monikid/repositories/transaction/transaction_repository.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'add_transaction_state.dart';

part 'add_transaction_provider.g.dart';

@riverpod
class AddTransactionNotifier extends _$AddTransactionNotifier {
  late final TransactionRepository _repository;

  @override
  AddTransactionState build() {
    _repository = getIt<TransactionRepository>();
    return const AddTransactionState.initial();
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    state = const AddTransactionState.loading();
    try {
      await _repository.addTransaction(transaction);
      state = const AddTransactionState.success();
    } catch (e) {
      state = AddTransactionState.error(e.toString());
    }
  }
}
