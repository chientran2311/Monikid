import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:monikid/core/constants/app_constants.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:monikid/repositories/category/add_custom_category_repository.dart';

part 'category_provider.g.dart';

// Alias kept for backward compatibility with all existing callers.
// Source of truth: AppConstants.defaultTransactionCategories.
const defaultCategories = AppConstants.defaultTransactionCategories;

@riverpod
Stream<List<CategoryModel>> categoryStream(Ref ref) {
  final authState = ref.watch(authSessionProvider);
  final userId = authState.user?.uid;

  if (!authState.isAuthenticated || userId == null) {
    return Stream.value(defaultCategories);
  }

  final repo = ref.watch(customCategoryRepositoryProvider);
  return repo.watchUserCategories(userId).map(mergeTransactionCategories);
}

List<CategoryModel> mergeTransactionCategories(List<CategoryModel> customCategories) {
  final merged = <String, CategoryModel>{};

  for (final category in defaultCategories) {
    merged[_categoryKey(category)] = category;
  }

  for (final category in customCategories) {
    final normalizedCategory = category.copyWith(
      type: category.type.trim().isEmpty ? 'expense' : category.type,
    );
    merged[_categoryKey(normalizedCategory)] = normalizedCategory;
  }

  return merged.values.toList()
    ..sort((a, b) {
      final typeCompare = a.type.compareTo(b.type);
      if (typeCompare != 0) {
        return typeCompare;
      }
      return a.label.compareTo(b.label);
    });
}

List<CategoryModel> filterCategoriesByType(
  Iterable<CategoryModel> categories,
  String? type,
) {
  if (type == null || type == 'all') {
    return categories.toList();
  }

  return categories.where((category) => category.type == type).toList();
}

String transactionCategoryKeyForCategory(CategoryModel category) {
  return category.id;
}

CategoryModel? findCategoryByTransactionKey(
  Iterable<CategoryModel> categories,
  String? categoryKey, {
  String? type,
}) {
  if (categoryKey == null || categoryKey.trim().isEmpty) {
    return null;
  }

  for (final category in categories) {
    final typeMatches = type == null || type == 'all' || category.type == type;
    if (!typeMatches) {
      continue;
    }

    if (category.id == categoryKey) {
      return category;
    }
  }

  return null;
}

CategoryModel getDefaultCategoryForType(
  String type, {
  Iterable<CategoryModel>? categories,
}) {
  final source = categories ?? defaultCategories;
  return source.firstWhere(
    (category) => category.type == type,
    orElse: () => defaultCategories.first,
  );
}

CategoryModel? findCategoryByLabel(
  Iterable<CategoryModel> categories,
  String? label, {
  String? type,
}) {
  if (label == null) {
    return null;
  }

  for (final category in categories) {
    final typeMatches = type == null || type == 'all' || category.type == type;
    if (typeMatches && category.label == label) {
      return category;
    }
  }
  return null;
}

String _categoryKey(CategoryModel category) {
  return category.id;
}
