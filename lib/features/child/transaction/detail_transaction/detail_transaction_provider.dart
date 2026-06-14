import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/child/transaction/detail_transaction/detail_transaction_state.dart';
import 'package:monikid/features/child/transaction/transaction_history/transaction_history_provider.dart';
import 'package:monikid/features/child/transaction/transaction_status.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/repositories/transaction/transaction_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'detail_transaction_provider.g.dart';

@riverpod
class DetailTransactionNotifier extends _$DetailTransactionNotifier {
  late final Logger _logger;

  @override
  DetailTransactionState build() {
    _logger = getIt<Logger>();

    ref.listen(transactionHistoryProvider, (previous, next) {
      final currentTransactionId = state.currentTransactionId;
      if (currentTransactionId == null) {
        return;
      }

      if (next.selectedTransaction?.transactionId == currentTransactionId) {
        final selectedTransaction = next.selectedTransaction;
        state = state.copyWith(
          status: TransactionStatus.ready,
          transaction: selectedTransaction,
          errorMessage: null,
        );
        if (selectedTransaction != null) {
          _syncEvidenceImageUrl(selectedTransaction);
        }
        return;
      }

      if (next.selectedTransactionId == currentTransactionId &&
          next.selectionErrorMessage != null) {
        state = state.copyWith(
          status: TransactionStatus.error,
          transaction: null,
          errorMessage: next.selectionErrorMessage,
        );
      }
    });

    return const DetailTransactionState();
  }

  Future<void> initialize(String transactionId) async {
    state = state.copyWith(
      status: TransactionStatus.loading,
      currentTransactionId: transactionId,
      transaction: null,
      errorMessage: null,
    );

    final transaction = await ref
        .read(transactionHistoryProvider.notifier)
        .ensureSelectedTransaction(transactionId);

    if (transaction == null) {
      state = state.copyWith(
        status: TransactionStatus.error,
        transaction: null,
        errorMessage: 'Unable to load transaction.',
      );
      return;
    }

    state = state.copyWith(
      status: TransactionStatus.ready,
      transaction: transaction,
      errorMessage: null,
    );
    await _syncEvidenceImageUrl(transaction);
  }

  Future<void> retryEvidenceImage() async {
    final transaction = state.transaction;
    if (transaction == null) {
      return;
    }
    await _syncEvidenceImageUrl(transaction, forceRefresh: true);
  }

  Future<void> _syncEvidenceImageUrl(
    TransactionModel transaction, {
    bool forceRefresh = false,
  }) async {
    if (!transaction.hasEvidenceImage) {
      state = state.copyWith(
        evidenceImageUrl: null,
        evidenceImageErrorMessage: null,
        isResolvingEvidenceImage: false,
      );
      return;
    }

    final storagePath = transaction.evidenceImage?.imageUrl;
    final currentStoragePath = state.transaction?.evidenceImage?.imageUrl;
    if (!forceRefresh &&
        storagePath == currentStoragePath &&
        state.evidenceImageUrl != null) {
      return;
    }

    state = state.copyWith(
      isResolvingEvidenceImage: true,
      evidenceImageErrorMessage: null,
    );

    try {
      final imageUrl = await ref
          .read(transactionRepositoryProvider)
          .getEvidenceDownloadUrl(transaction.evidenceImage);

      if (state.currentTransactionId != transaction.transactionId) {
        return;
      }

      if (imageUrl == null) {
        state = state.copyWith(
          isResolvingEvidenceImage: false,
          evidenceImageUrl: null,
          evidenceImageErrorMessage: 'Unable to load evidence image.',
        );
        return;
      }

      state = state.copyWith(
        isResolvingEvidenceImage: false,
        evidenceImageUrl: imageUrl,
        evidenceImageErrorMessage: null,
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Resolve evidence image failed',
        error: error,
        stackTrace: stackTrace,
      );
      if (state.currentTransactionId != transaction.transactionId) {
        return;
      }
      state = state.copyWith(
        isResolvingEvidenceImage: false,
        evidenceImageUrl: null,
        evidenceImageErrorMessage: 'Unable to load evidence image.',
      );
    }
  }
}
