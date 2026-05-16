import 'package:firebase_core/firebase_core.dart';
import 'package:monikid/features/child/transaction/transaction_status.dart';
import 'package:monikid/features/child/transaction/providers/category_provider.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:monikid/models/entities/transaction_model.dart';

/// Pure utility functions for update transaction operations.
/// Extracted from update_transaction_provider.dart to reduce file size.
class UpdateTransactionHelpers {
  UpdateTransactionHelpers._();

  /// Formats amount value for display (removes decimal if whole number).
  static String formatAmount(double amount) {
    if (amount == amount.truncateToDouble()) {
      return amount.toInt().toString();
    }
    return amount.toString();
  }

  /// Validates amount text and returns parsed value or validation error.
  static ValidationResult<double> validateAmount({
    required String amountText,
    required String emptyError,
    required String invalidError,
  }) {
    final cleanedText = amountText.replaceAll(RegExp(r'[^0-9]'), '').trim();
    
    if (cleanedText.isEmpty) {
      return ValidationResult.error(emptyError);
    }

    final amount = double.tryParse(cleanedText);
    if (amount == null || amount <= 0) {
      return ValidationResult.error(invalidError);
    }

    return ValidationResult.success(amount);
  }

  /// Resolves Firebase error message based on error code and context.
  static String resolveFirebaseErrorMessage({
    required FirebaseException error,
    required bool hasNewEvidenceImage,
    required bool removeExistingEvidence,
    required String defaultErrorMessage,
  }) {
    if (error.code == 'permission-denied') {
      if (hasNewEvidenceImage || removeExistingEvidence) {
        return 'Không thể cập nhật ảnh minh chứng. Kiểm tra Firestore rules cho evidence_image Cloudinary.';
      }
      return 'Rules hiện tại đang từ chối cập nhật transaction. Kiểm tra lại schema Firestore/rules.';
    }

    if (error.message != null && error.message!.trim().isNotEmpty) {
      return error.message!;
    }

    return defaultErrorMessage;
  }

  /// Resolves current category based on transaction and available categories.
  static CategoryModel resolveCurrentCategory({
    required List<CategoryModel> categories,
    required String currentType,
    required String selectedCategoryEmoji,
    required TransactionModel originalTransaction,
    required CategoryModel Function(TransactionType) defaultCategoryGetter,
  }) {
    // Try exact match first
    final exactMatches = categories.where((category) {
      return category.type == currentType &&
          transactionCategoryKeyForCategory(category) ==
              originalTransaction.categoryKey;
    }).toList();

    if (exactMatches.isNotEmpty) {
      return exactMatches.first;
    }

    // Try key match
    final keyMatch = findCategoryByTransactionKey(
      categories,
      originalTransaction.categoryKey,
      type: currentType,
    );
    if (keyMatch != null) {
      return keyMatch;
    }

    // Try label match
    final originalMatches = categories.where((category) {
      return category.type == currentType &&
          category.label == originalTransaction.category;
    }).toList();

    if (originalMatches.isNotEmpty) {
      return originalMatches.first;
    }

    // Fallback
    final fallback = resolveCategoryForType(
      type: transactionTypeFromValue(currentType),
      categories: categories,
      defaultCategoryGetter: defaultCategoryGetter,
    );

    return fallback.copyWith(
      icon: selectedCategoryEmoji.isNotEmpty
          ? selectedCategoryEmoji
          : fallback.icon,
    );
  }

  /// Resolves category for a given transaction type with optional preference.
  static CategoryModel resolveCategoryForType({
    required TransactionType type,
    required List<CategoryModel> categories,
    required CategoryModel Function(TransactionType) defaultCategoryGetter,
    String? preferredLabel,
  }) {
    // Try preferred label first
    if (preferredLabel != null && preferredLabel.isNotEmpty) {
      final preferredMatches = categories.where((category) {
        return category.type == type.value && category.label == preferredLabel;
      }).toList();

      if (preferredMatches.isNotEmpty) {
        return preferredMatches.first;
      }
    }

    // Try same type categories
    final sameTypeCategories = categories.where((category) {
      return category.type == type.value;
    }).toList();

    if (sameTypeCategories.isNotEmpty) {
      return sameTypeCategories.first;
    }

    // Default fallback
    return defaultCategoryGetter(type);
  }
}

/// Result wrapper for validation operations.
class ValidationResult<T> {
  final T? value;
  final String? error;
  final bool isValid;

  const ValidationResult._({
    this.value,
    this.error,
    required this.isValid,
  });

  factory ValidationResult.success(T value) {
    return ValidationResult._(value: value, isValid: true);
  }

  factory ValidationResult.error(String error) {
    return ValidationResult._(error: error, isValid: false);
  }
}
