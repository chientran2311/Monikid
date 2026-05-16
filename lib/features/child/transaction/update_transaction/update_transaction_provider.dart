import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:logger/logger.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/child/transaction/providers/category_provider.dart';
import 'package:monikid/features/child/transaction/transaction_history/transaction_history_provider.dart';
import 'package:monikid/features/child/transaction/transaction_status.dart';
import 'package:monikid/features/child/transaction/update_transaction/update_transaction_helpers.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/repositories/transaction/transaction_evidence_storage.dart';
import 'package:monikid/repositories/transaction/transaction_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'update_transaction_state.dart';

part 'update_transaction_provider.g.dart';

@riverpod
class UpdateTransactionNotifier extends _$UpdateTransactionNotifier {
  late final TransactionRepository _repository;
  late final Logger _logger;

  @override
  UpdateTransactionState build() {
    _repository = ref.read(transactionRepositoryProvider);
    _logger = getIt<Logger>();
    final initialCategories =
        ref.read(categoryStreamProvider).value ?? defaultCategories;
    _listenCategories();
    return UpdateTransactionState(categories: initialCategories);
  }

  void _listenCategories() {
    ref.listen(categoryStreamProvider, (previous, next) {
      next.whenData((categories) {
        final originalTransaction = state.originalTransaction;
        if (originalTransaction == null) {
          state = state.copyWith(categories: categories, errorMessage: null);
          return;
        }

        final nextCategory = UpdateTransactionHelpers.resolveCurrentCategory(
          categories: categories,
          currentType: state.currentType,
          selectedCategoryEmoji: state.selectedCategoryEmoji,
          originalTransaction: originalTransaction,
          defaultCategoryGetter: (type) => getDefaultCategoryForType(type.value, categories: defaultCategories),
        );

        state = state.copyWith(
          categories: categories,
          selectedCategoryKey: transactionCategoryKeyForCategory(nextCategory),
          selectedCategory: nextCategory.label,
          selectedCategoryEmoji: nextCategory.icon,
          status: state.isSubmitting
              ? TransactionStatus.submitting
              : TransactionStatus.ready,
          errorMessage: null,
        );
      });

      next.whenOrNull(
        error: (error, stackTrace) {
          _logger.e(
            'Update transaction category stream error',
            error: error,
            stackTrace: stackTrace,
          );
          state = state.copyWith(
            status: TransactionStatus.error,
            errorMessage: s.transactionCategoryLoadError,
          );
        },
      );
    });
  }

  Future<void> initialize(String transactionId) async {
    state = state.copyWith(
      currentTransactionId: transactionId,
      status: TransactionStatus.loading,
      errorMessage: null,
    );

    final transaction = await ref
        .read(transactionHistoryProvider.notifier)
        .ensureSelectedTransaction(transactionId);

    if (transaction == null) {
      state = state.copyWith(
        status: TransactionStatus.error,
        originalTransaction: null,
        errorMessage: s.transactionLoadError,
      );
      return;
    }

    _applyTransaction(transaction);
  }

  void updateAmount(String amountText) {
    state = state.copyWith(
      amountText: amountText,
      status: TransactionStatus.ready,
      errorMessage: null,
    );
  }

  void updateNote(String note) {
    state = state.copyWith(
      note: note,
      status: TransactionStatus.ready,
      errorMessage: null,
    );
  }

  void updateDate(DateTime date) {
    state = state.copyWith(
      selectedDate: date,
      status: TransactionStatus.ready,
      errorMessage: null,
    );
  }

  void updateCategory(CategoryModel category) {
    state = state.copyWith(
      selectedCategoryKey: transactionCategoryKeyForCategory(category),
      selectedCategory: category.label,
      selectedCategoryEmoji: category.icon,
      status: TransactionStatus.ready,
      errorMessage: null,
    );
  }

  void updateTransactionType(TransactionType type) {
    final fallbackCategory = UpdateTransactionHelpers.resolveCategoryForType(
      type: type,
      categories: state.categories,
      defaultCategoryGetter: (t) => getDefaultCategoryForType(t.value, categories: defaultCategories),
      preferredLabel: state.selectedCategory,
    );

    state = state.copyWith(
      transactionType: type,
      selectedCategoryKey: transactionCategoryKeyForCategory(fallbackCategory),
      selectedCategory: fallbackCategory.label,
      selectedCategoryEmoji: fallbackCategory.icon,
      status: TransactionStatus.ready,
      errorMessage: null,
    );
  }

  void setNewEvidenceImage({
    required Uint8List bytes,
    required String fileName,
    required String mimeType,
    String? filePath,
  }) {
    state = state.copyWith(
      newEvidenceImageBytes: bytes,
      newEvidenceImageFileName: fileName,
      newEvidenceImageMimeType: mimeType,
      newEvidenceImageFilePath: filePath,
      removeExistingEvidenceImage: false,
      status: TransactionStatus.ready,
      errorMessage: null,
    );
  }

  void removeEvidenceImage() {
    state = state.copyWith(
      newEvidenceImageBytes: null,
      newEvidenceImageFileName: null,
      newEvidenceImageMimeType: null,
      removeExistingEvidenceImage: true,
      status: TransactionStatus.ready,
      errorMessage: null,
    );
  }

  void clearPendingEvidenceImageSelection() {
    state = state.copyWith(
      newEvidenceImageBytes: null,
      newEvidenceImageFileName: null,
      newEvidenceImageMimeType: null,
      removeExistingEvidenceImage: false,
      status: TransactionStatus.ready,
      errorMessage: null,
    );
  }

  Future<void> submit() async {
    final originalTransaction = state.originalTransaction;
    if (originalTransaction == null) {
      state = state.copyWith(
        status: TransactionStatus.error,
        errorMessage: s.updateTransactionMissingError,
      );
      return;
    }

    final validationResult = UpdateTransactionHelpers.validateAmount(
      amountText: state.amountText,
      emptyError: s.validationEnterAmount,
      invalidError: s.validationInvalidAmount,
    );

    if (!validationResult.isValid) {
      state = state.copyWith(
        status: TransactionStatus.error,
        errorMessage: validationResult.error,
      );
      return;
    }

    final amount = validationResult.value!;
    state = state.copyWith(
      status: TransactionStatus.submitting,
      errorMessage: null,
    );

    final trimmedNote = state.note.trim();
    final updatedTransaction = originalTransaction.copyWith(
      amountMinor: amount.round(),
      type: state.transactionType.value,
      categoryLabel: state.selectedCategory,
      categoryKey: state.selectedCategoryKey,
      categoryIcon: state.selectedCategoryEmoji,
      dateTs: state.effectiveSelectedDate,
      note: trimmedNote.isEmpty ? null : trimmedNote,
      evidenceImage: state.removeExistingEvidenceImage
          ? null
          : originalTransaction.evidenceImage,
    );

    try {
      _logger.i('Updating transaction ${updatedTransaction.transactionId}');
      final newEvidenceUpload = state.hasNewEvidenceImageSelection
          ? TransactionEvidenceUploadPayload(
              bytes: state.newEvidenceImageBytes!,
              fileName: state.newEvidenceImageFileName!,
              mimeType: state.newEvidenceImageMimeType!,
              categoryKey: updatedTransaction.categoryKey,
              filePath: state.newEvidenceImageFilePath,
            )
          : null;
      final persistedTransaction = await _repository.updateTransaction(
        updatedTransaction,
        newEvidenceUpload: newEvidenceUpload,
        previousEvidenceImage: originalTransaction.evidenceImage,
        removeExistingEvidence: state.removeExistingEvidenceImage,
      );
      ref
          .read(transactionHistoryProvider.notifier)
          .applyUpdatedTransaction(persistedTransaction);
      state = state.copyWith(
        status: TransactionStatus.success,
        errorMessage: null,
        originalTransaction: persistedTransaction,
        newEvidenceImageBytes: null,
        newEvidenceImageFileName: null,
        newEvidenceImageMimeType: null,
        removeExistingEvidenceImage: false,
      );
    } on TimeoutException catch (error, stackTrace) {
      _logger.e(
        'Update transaction evidence upload timed out',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: TransactionStatus.error,
        errorMessage: s.transactionEvidenceUploadTimeout,
      );
    } on FirebaseException catch (error, stackTrace) {
      _logger.e(
        'Update transaction firebase failure',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: TransactionStatus.error,
        errorMessage: UpdateTransactionHelpers.resolveFirebaseErrorMessage(
          error: error,
          hasNewEvidenceImage: state.hasNewEvidenceImageSelection,
          removeExistingEvidence: state.removeExistingEvidenceImage,
          defaultErrorMessage: s.updateTransactionFailed,
        ),
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Update transaction failed',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: TransactionStatus.error,
        errorMessage: s.updateTransactionFailed,
      );
    }
  }



  void _applyTransaction(TransactionModel transaction) {
    final transactionType = transactionTypeFromValue(transaction.type);
    final resolvedCategory = UpdateTransactionHelpers.resolveCurrentCategory(
      categories: state.categories,
      currentType: transaction.type,
      selectedCategoryEmoji: transaction.categoryEmoji ?? '',
      originalTransaction: transaction,
      defaultCategoryGetter: (type) => getDefaultCategoryForType(type.value, categories: defaultCategories),
    );

    state = state.copyWith(
      currentTransactionId: transaction.transactionId,
      originalTransaction: transaction,
      status: TransactionStatus.ready,
      selectedCategoryKey: transactionCategoryKeyForCategory(resolvedCategory),
      selectedCategory: resolvedCategory.label,
      selectedCategoryEmoji: resolvedCategory.icon,
      amountText: UpdateTransactionHelpers.formatAmount(transaction.amount),
      note: transaction.note ?? '',
      selectedDate: transaction.date,
      transactionType: transactionType,
      errorMessage: null,
    );
  }

}
