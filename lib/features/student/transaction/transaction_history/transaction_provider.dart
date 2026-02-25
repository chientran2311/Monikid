import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/repositories/transaction/transaction_repository.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/providers/auth_provider.dart';

part 'transaction_provider.g.dart';

@riverpod
class TransactionNotifier extends _$TransactionNotifier {
  late final TransactionRepository _repository;

  @override
  Stream<List<TransactionModel>> build() {
    _repository = getIt<TransactionRepository>();

    // Listen to changes in authentication state
    final authState = ref.watch(authProvider);

    if (authState.isAuthenticated && authState.user != null) {
      return _repository.getTransactions(authState.user!.uid);
    }

    return const Stream.empty();
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    state = const AsyncValue.loading();
    try {
      await _repository.addTransaction(transaction);
      // We don't need to manually update state here because the Stream from build()
      // will automatically emit the new list when Firestore updates.
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateTransaction(TransactionModel transaction) async {
    state = const AsyncValue.loading();
    try {
      await _repository.updateTransaction(transaction);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> deleteTransaction(String transactionId) async {
    state = const AsyncValue.loading();
    try {
      await _repository.deleteTransaction(transactionId);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Stream<List<TransactionModel>> getTransactionsByMonth(DateTime month) {
    final authState = ref.read(authProvider);
    if (authState.isAuthenticated && authState.user != null) {
      return _repository.getTransactionsByMonth(authState.user!.uid, month);
    }
    return const Stream.empty();
  }
}
