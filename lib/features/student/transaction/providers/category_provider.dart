import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:monikid/repositories/category/category_repository.dart';

part 'category_provider.g.dart';

const defaultCategories = [
  CategoryModel(
    id: 'expense-an-uong',
    label: 'Ăn uống',
    icon: '🍜',
    type: 'expense',
    colorHex: '0xFF4ADE80',
    isDefault: true,
  ),
  CategoryModel(
    id: 'expense-di-chuyen',
    label: 'Di chuyển',
    icon: '🚌',
    type: 'expense',
    colorHex: '0xFF60A5FA',
    isDefault: true,
  ),
  CategoryModel(
    id: 'expense-hoc-tap',
    label: 'Học tập',
    icon: '📚',
    type: 'expense',
    colorHex: '0xFFA78BFA',
    isDefault: true,
  ),
  CategoryModel(
    id: 'expense-giai-tri',
    label: 'Giải trí',
    icon: '🎮',
    type: 'expense',
    colorHex: '0xFFF472B6',
    isDefault: true,
  ),
  CategoryModel(
    id: 'expense-mua-sam',
    label: 'Mua sắm',
    icon: '🛍️',
    type: 'expense',
    colorHex: '0xFFFBBF24',
    isDefault: true,
  ),
  CategoryModel(
    id: 'expense-suc-khoe',
    label: 'Sức khỏe',
    icon: '💊',
    type: 'expense',
    colorHex: '0xFFF87171',
    isDefault: true,
  ),
  CategoryModel(
    id: 'expense-sinh-hoat',
    label: 'Sinh hoạt',
    icon: '🏠',
    type: 'expense',
    colorHex: '0xFFFB923C',
    isDefault: true,
  ),
  CategoryModel(
    id: 'expense-khac',
    label: 'Khác',
    icon: '📦',
    type: 'expense',
    colorHex: '0xFF94A3B8',
    isDefault: true,
  ),
  CategoryModel(
    id: 'income-tien-tieu-vat',
    label: 'Tiền tiêu vặt',
    icon: '💵',
    type: 'income',
    colorHex: '0xFF22C55E',
    isDefault: true,
  ),
  CategoryModel(
    id: 'income-thuong',
    label: 'Thưởng',
    icon: '🏆',
    type: 'income',
    colorHex: '0xFFF59E0B',
    isDefault: true,
  ),
  CategoryModel(
    id: 'income-li-xi',
    label: 'Lì xì',
    icon: '🧧',
    type: 'income',
    colorHex: '0xFFEF4444',
    isDefault: true,
  ),
  CategoryModel(
    id: 'income-ban-keo-do',
    label: 'Bán kẹo/đồ',
    icon: '🍡',
    type: 'income',
    colorHex: '0xFF8B5CF6',
    isDefault: true,
  ),
  CategoryModel(
    id: 'income-khac',
    label: 'Khác',
    icon: '✨',
    type: 'income',
    colorHex: '0xFF64748B',
    isDefault: true,
  ),
];

@riverpod
Stream<List<CategoryModel>> categoryStream(CategoryStreamRef ref) {
  final authState = ref.watch(authSessionProvider);
  final userId = authState.user?.uid;

  if (userId == null) {
    return Stream.value(defaultCategories);
  }

  final repo = getIt<CategoryRepository>();
  return repo.getUserCategories(userId).map(mergeTransactionCategories);
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
  final normalizedLabel = category.label.trim().toLowerCase();
  final normalizedType = category.type.trim().isEmpty ? 'expense' : category.type;
  return '$normalizedType::$normalizedLabel';
}
