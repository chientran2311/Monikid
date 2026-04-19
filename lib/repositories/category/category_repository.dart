import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_repository.g.dart';

const _kUsersCollection = 'users';
const _kCustomCategoriesCollection = 'custom_categories';

@riverpod
CategoryRepository categoryRepository(Ref ref) {
  return getIt<CategoryRepository>();
}

abstract class CategoryRepository {
  Stream<List<CategoryModel>> getUserCategories(String userId);

  Future<void> addCategory(String userId, CategoryModel category);

  Future<void> deleteCategory(String userId, String categoryId);
}

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl(this._firestore, this._logger);

  final FirebaseFirestore _firestore;
  final Logger _logger;

  CollectionReference<Map<String, dynamic>> _customCategoriesOfUser(
    String userId,
  ) {
    return _firestore
        .collection(_kUsersCollection)
        .doc(userId)
        .collection(_kCustomCategoriesCollection);
  }

  @override
  Stream<List<CategoryModel>> getUserCategories(String userId) {
    _logger.i('Listening custom categories for user: $userId.');

    return _customCategoriesOfUser(userId).snapshots().map((snapshot) {
      final categories = snapshot.docs
          .map(_mapCategory)
          .nonNulls
          .toList(growable: false);

      categories.sort((a, b) {
        final typeCompare = a.type.compareTo(b.type);
        if (typeCompare != 0) {
          return typeCompare;
        }
        return a.label.compareTo(b.label);
      });

      return categories;
    }).handleError((error, stackTrace) {
      _logger.e(
        'Failed to listen custom categories.',
        error: error,
        stackTrace: stackTrace,
      );
      throw error;
    });
  }

  @override
  Future<void> addCategory(String userId, CategoryModel category) async {
    try {
      _logger.i('Adding custom category ${category.id} for user: $userId.');
      await _customCategoriesOfUser(userId)
          .doc(category.id)
          .set(_toFirestore(category));
      _logger.i('Custom category added successfully.');
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to add custom category.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> deleteCategory(String userId, String categoryId) async {
    try {
      _logger.i('Deleting custom category $categoryId for user: $userId.');
      await _customCategoriesOfUser(userId).doc(categoryId).delete();
      _logger.i('Custom category deleted successfully.');
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to delete custom category.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  CategoryModel? _mapCategory(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    final isActive = data['is_active'];
    if (isActive is bool && !isActive) {
      return null;
    }

    return CategoryModel(
      id: (data['category_id'] as String?)?.trim().isNotEmpty == true
          ? (data['category_id'] as String).trim()
          : doc.id,
      label: (data['label'] as String?)?.trim() ?? '',
      icon: (data['icon'] as String?)?.trim() ?? '',
      type: (data['type'] as String?)?.trim().isNotEmpty == true
          ? (data['type'] as String).trim()
          : 'expense',
    );
  }

  Map<String, dynamic> _toFirestore(CategoryModel category) {
    return {
      'category_id': category.id,
      'category_key': _categoryKey(category.label),
      'label': category.label.trim(),
      'icon': category.icon.trim(),
      'type': category.type.trim().isEmpty ? 'expense' : category.type.trim(),
      'is_active': true,
      'created_at': Timestamp.now(),
    };
  }

  String _categoryKey(String value) {
    return value
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'^_+|_+$'), '');
  }
}
