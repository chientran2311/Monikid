import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:monikid/core/di/locator.dart';
import 'package:monikid/repositories/transaction/transaction_repository.dart';
import 'detail_transaction_state.dart';

part 'detail_transaction_provider.g.dart';

@riverpod
class DetailTransactionNotifier extends _$DetailTransactionNotifier {
  late final TransactionRepository _repository;

  @override
  DetailTransactionState build() {
    _repository = getIt<TransactionRepository>();
    return const DetailTransactionState.initial();
  }

  Future<void> deleteTransaction(String transactionId) async {
    state = const DetailTransactionState.loading();
    try {
      await _repository.deleteTransaction(transactionId);
      state = const DetailTransactionState.success();
    } catch (e) {
      state = DetailTransactionState.error(e.toString());
    }
  }
}
