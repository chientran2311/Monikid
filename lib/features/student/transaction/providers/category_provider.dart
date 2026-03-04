import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/providers/auth_provider.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:monikid/repositories/category/category_repository.dart';

part 'category_provider.g.dart';

const defaultCategories = [
  CategoryModel(
    id: 'Ăn uống',
    label: 'Ăn uống',
    icon: '🍜',
    colorHex: '0xFF4ADE80',
    isDefault: true,
  ),
  CategoryModel(
    id: 'Di chuyển',
    label: 'Di chuyển',
    icon: '🚌',
    colorHex: '0xFF60A5FA',
    isDefault: true,
  ),
  CategoryModel(
    id: 'Học tập',
    label: 'Học tập',
    icon: '📚',
    colorHex: '0xFFA78BFA',
    isDefault: true,
  ),
  CategoryModel(
    id: 'Giải trí',
    label: 'Giải trí',
    icon: '🎬',
    colorHex: '0xFFF472B6',
    isDefault: true,
  ),
  CategoryModel(
    id: 'Mua sắm',
    label: 'Mua sắm',
    icon: '🛍️',
    colorHex: '0xFFFBBF24',
    isDefault: true,
  ),
  CategoryModel(
    id: 'Sức khỏe',
    label: 'Sức khỏe',
    icon: '💊',
    colorHex: '0xFFF87171',
    isDefault: true,
  ),
  CategoryModel(
    id: 'Sinh hoạt',
    label: 'Sinh hoạt',
    icon: '🏠',
    colorHex: '0xFFFB923C',
    isDefault: true,
  ),
  CategoryModel(
    id: 'Khác',
    label: 'Khác',
    icon: '📦',
    colorHex: '0xFF94A3B8',
    isDefault: true,
  ),
];

@riverpod
Stream<List<CategoryModel>> categoryStream(CategoryStreamRef ref) {
  final authState = ref.watch(authProvider);
  final userId = authState.user?.uid;

  if (userId == null) {
    return Stream.value(defaultCategories);
  }

  final repo = getIt<CategoryRepository>();
  return repo.getUserCategories(userId).map((customCategories) {
    // Merge defaults and custom ones
    return [...defaultCategories, ...customCategories];
  });
}
