import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/repositories/transaction/transaction_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../transaction_history_provider.dart';
import 'transaction_selection_state.dart';

part 'transaction_selection_provider.g.dart';

@Riverpod(keepAlive: true)
class TransactionSelectionNotifier extends _$TransactionSelectionNotifier {
  @override
  TransactionSelectionState build() {
    return const TransactionSelectionState();
  }

  void selectTransaction(TransactionModel transaction) {
    state = state.copyWith(
      selectedTransactionId: transaction.transactionId,
      selectedTransaction: transaction,
      isResolvingSelection: false,
      selectionErrorMessage: null,
    );
  }

  Future<TransactionModel?> ensureSelectedTransaction(String transactionId) async {
    // 1. Try to find in current history state first (to avoid network call)
    final cachedTransaction = ref.read(transactionHistoryProvider.notifier).findTransactionInState(transactionId);
    if (cachedTransaction != null) {
      selectTransaction(cachedTransaction);
      return cachedTransaction;
    }

    // 2. Fetch from repository
    final auth = ref.read(authSessionProvider);
    final uid = auth.isAuthenticated ? auth.user?.uid : null;

    if (uid == null) {
      state = state.copyWith(
        selectedTransactionId: transactionId,
        selectedTransaction: null,
        isResolvingSelection: false,
        selectionErrorMessage: 'Missing authenticated user.',
      );
      return null;
    }

    state = state.copyWith(
      selectedTransactionId: transactionId,
      selectedTransaction: null,
      isResolvingSelection: true,
      selectionErrorMessage: null,
    );

    final repository = ref.read(transactionRepositoryProvider);
    final fetchedTransaction = await repository.getTransactionById(uid, transactionId);

    if (fetchedTransaction == null) {
      state = state.copyWith(
        selectedTransactionId: transactionId,
        selectedTransaction: null,
        isResolvingSelection: false,
        selectionErrorMessage: 'Unable to load transaction.',
      );
      return null;
    }

    selectTransaction(fetchedTransaction);
    return fetchedTransaction;
  }
}
