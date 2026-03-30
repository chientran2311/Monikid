import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/student/transaction/providers/category_provider.dart';
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
  UpdateTransactionState build(TransactionModel transaction) {
    _repository = ref.read(transactionRepositoryProvider);
    _logger = getIt<Logger>();

    _listenCategories(transaction);

    return UpdateTransactionState(
      originalTransaction: transaction,
      status: TransactionStatus.loading,
      selectedCategory: transaction.category,
      selectedCategoryEmoji: transaction.categoryEmoji ?? '',
      amountText: _formatAmount(transaction.amount),
      note: transaction.note ?? '',
      selectedDate: transaction.date,
      transactionType: transactionTypeFromValue(transaction.type),
    );
  }

  void _listenCategories(TransactionModel transaction) {
    ref.listen(categoryStreamProvider, (previous, next) {
      next.whenData((categories) {
        final nextCategory = _resolveCurrentCategory(
          categories: categories,
          currentType: state.currentType,
          selectedCategory: state.selectedCategory,
          selectedCategoryEmoji: state.selectedCategoryEmoji,
          originalTransaction: transaction,
        );

        state = state.copyWith(
          status: state.isSubmitting
              ? TransactionStatus.submitting
              : TransactionStatus.ready,
          categories: categories,
          selectedCategory: nextCategory.label,
          selectedCategoryEmoji: nextCategory.icon,
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
            errorMessage: 'Không thể tải danh mục. Vui lòng thử lại.',
          );
        },
      );
    });
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
      selectedCategory: fallbackCategory.label,
      selectedCategoryEmoji: fallbackCategory.icon,
      status: TransactionStatus.ready,
      errorMessage: null,
    );
  }

  Future<void> submit() async {
    final amountText = state.amountText.replaceAll(RegExp(r'[^0-9]'), '').trim();

    if (amountText.isEmpty) {
      state = state.copyWith(
        status: TransactionStatus.error,
        errorMessage: 'Vui lòng nhập số tiền.',
      );
      return;
    }

    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      state = state.copyWith(
        status: TransactionStatus.error,
        errorMessage: 'Số tiền không hợp lệ.',
      );
      return;
    }

    state = state.copyWith(
      status: TransactionStatus.submitting,
      errorMessage: null,
    );

    final trimmedNote = state.note.trim();
    final updatedTransaction = state.originalTransaction.copyWith(
      amount: amount,
      type: state.transactionType.value,
      category: state.selectedCategory,
      categoryEmoji: state.selectedCategoryEmoji,
      date: state.effectiveSelectedDate,
      note: trimmedNote.isEmpty ? null : trimmedNote,
    );

    try {
      _logger.i('Updating transaction ${updatedTransaction.transactionId}');
      await _repository.updateTransaction(updatedTransaction);
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
        errorMessage: 'Không thể cập nhật giao dịch. Vui lòng thử lại.',
      );
    }
  }

  CategoryModel _resolveCurrentCategory({
    required List<CategoryModel> categories,
    required String currentType,
    required String selectedCategory,
    required String selectedCategoryEmoji,
    required TransactionModel originalTransaction,
  }) {
    final exactMatches = categories.where((category) {
      return category.type == currentType && category.label == selectedCategory;
    }).toList();

    if (exactMatches.isNotEmpty) {
      return exactMatches.first;
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
      icon: selectedCategoryEmoji.isNotEmpty ? selectedCategoryEmoji : fallback.icon,
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

    return CategoryModel(
      id: '',
      label: type == TransactionType.income ? 'Thu nhập' : 'Chi tiêu',
      type: type.value,
      icon: type == TransactionType.income ? '💵' : '💸',
    );
  }

  String _formatAmount(double amount) {
    if (amount == amount.truncateToDouble()) {
      return amount.toInt().toString();
    }
    return amount.toString();
  }
}
