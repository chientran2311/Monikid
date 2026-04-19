import 'package:logger/logger.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/student/transaction/providers/category_provider.dart';
import 'package:monikid/features/student/transaction/transaction_history/transaction_history_provider.dart';
import 'package:monikid/features/student/transaction/transaction_status.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:monikid/models/entities/transaction_model.dart';
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
          state = state.copyWith(
            categories: categories,
            errorMessage: null,
          );
          return;
        }

        final nextCategory = _resolveCurrentCategory(
          categories: categories,
          currentType: state.currentType,
          selectedCategoryEmoji: state.selectedCategoryEmoji,
          originalTransaction: originalTransaction,
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
    final fallbackCategory = _resolveCategoryForType(
      type: type,
      categories: state.categories,
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

  Future<void> submit() async {
    final originalTransaction = state.originalTransaction;
    if (originalTransaction == null) {
      state = state.copyWith(
        status: TransactionStatus.error,
        errorMessage: s.updateTransactionMissingError,
      );
      return;
    }

    final amountText = state.amountText.replaceAll(RegExp(r'[^0-9]'), '').trim();
    if (amountText.isEmpty) {
      state = state.copyWith(
        status: TransactionStatus.error,
        errorMessage: s.validationEnterAmount,
      );
      return;
    }

    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      state = state.copyWith(
        status: TransactionStatus.error,
        errorMessage: s.validationInvalidAmount,
      );
      return;
    }

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
    );

    try {
      _logger.i('Updating transaction ${updatedTransaction.transactionId}');
      await _repository.updateTransaction(updatedTransaction);
      ref
          .read(transactionHistoryProvider.notifier)
          .applyUpdatedTransaction(updatedTransaction);
      state = state.copyWith(
        status: TransactionStatus.success,
        errorMessage: null,
        originalTransaction: updatedTransaction,
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
    final resolvedCategory = _resolveCurrentCategory(
      categories: state.categories,
      currentType: transaction.type,
      selectedCategoryEmoji: transaction.categoryEmoji ?? '',
      originalTransaction: transaction,
    );

    state = state.copyWith(
      currentTransactionId: transaction.transactionId,
      originalTransaction: transaction,
      status: TransactionStatus.ready,
      selectedCategoryKey: transactionCategoryKeyForCategory(resolvedCategory),
      selectedCategory: resolvedCategory.label,
      selectedCategoryEmoji: resolvedCategory.icon,
      amountText: _formatAmount(transaction.amount),
      note: transaction.note ?? '',
      selectedDate: transaction.date,
      transactionType: transactionType,
      errorMessage: null,
    );
  }

  CategoryModel _resolveCurrentCategory({
    required List<CategoryModel> categories,
    required String currentType,
    required String selectedCategoryEmoji,
    required TransactionModel originalTransaction,
  }) {
    final exactMatches = categories.where((category) {
      return category.type == currentType &&
          transactionCategoryKeyForCategory(category) ==
              originalTransaction.categoryKey;
    }).toList();

    if (exactMatches.isNotEmpty) {
      return exactMatches.first;
    }

    final keyMatch = findCategoryByTransactionKey(
      categories,
      originalTransaction.categoryKey,
      type: currentType,
    );
    if (keyMatch != null) {
      return keyMatch;
    }

    final originalMatches = categories.where((category) {
      return category.type == currentType &&
          category.label == originalTransaction.category;
    }).toList();

    if (originalMatches.isNotEmpty) {
      return originalMatches.first;
    }

    final fallback = _resolveCategoryForType(
      type: transactionTypeFromValue(currentType),
      categories: categories,
    );

    return fallback.copyWith(
      icon:
          selectedCategoryEmoji.isNotEmpty ? selectedCategoryEmoji : fallback.icon,
    );
  }

  CategoryModel _resolveCategoryForType({
    required TransactionType type,
    required List<CategoryModel> categories,
    String? preferredLabel,
  }) {
    if (preferredLabel != null && preferredLabel.isNotEmpty) {
      final preferredMatches = categories.where((category) {
        return category.type == type.value && category.label == preferredLabel;
      }).toList();

      if (preferredMatches.isNotEmpty) {
        return preferredMatches.first;
      }
    }

    final sameTypeCategories = categories.where((category) {
      return category.type == type.value;
    }).toList();

    if (sameTypeCategories.isNotEmpty) {
      return sameTypeCategories.first;
    }

    return getDefaultCategoryForType(type.value, categories: defaultCategories);
  }

  String _formatAmount(double amount) {
    if (amount == amount.truncateToDouble()) {
      return amount.toInt().toString();
    }
    return amount.toString();
  }
}
