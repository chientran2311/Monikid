import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'custom_category_repository.g.dart';

@riverpod
CustomCategoryRepository customCategoryRepository(Ref ref) {
  return getIt<CustomCategoryRepository>();
}

abstract class CustomCategoryRepository {
  Stream<List<CategoryModel>> watchUserCategories(String userId);
  Future<String> addCategory({
    required String userId,
    required String label,
    required String type,
  });
  Future<void> deleteCategory({
    required String userId,
    required String categoryId,
  });
}

class CustomCategoryRepositoryImpl implements CustomCategoryRepository {
  CustomCategoryRepositoryImpl(this._firestore, this._logger);

  final FirebaseFirestore _firestore;
  final Logger _logger;

  CollectionReference<Map<String, dynamic>> _customCategoriesOf(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('custom_categories');
  }

  @override
  Stream<List<CategoryModel>> watchUserCategories(String userId) {
    return _customCategoriesOf(userId)
        .where('is_active', isEqualTo: true)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map(
                (doc) => CategoryModel(
                  id: (doc.data()['category_id'] as String?)?.trim().isNotEmpty == true
                      ? (doc.data()['category_id'] as String).trim()
                      : doc.id,
                  label: (doc.data()['label'] as String?)?.trim() ?? '',
                  icon: (doc.data()['icon'] as String?)?.trim() ?? '',
                  type: (doc.data()['type'] as String?)?.trim().isNotEmpty == true
                      ? (doc.data()['type'] as String).trim()
                      : 'expense',
                  isDefault: false,
                ),
              )
              .toList(),
        )
        .handleError((Object error, StackTrace stack) {
          _logger.e('CustomCategoryRepository: stream error', error: error, stackTrace: stack);
        });
  }

  @override
  Future<String> addCategory({
    required String userId,
    required String label,
    required String type,
  }) async {
    final docRef = _customCategoriesOf(userId).doc();
    final categoryId = docRef.id;
    await docRef.set({
      'category_id': categoryId,
      'label': label.trim(),
      'type': type,
      'is_active': true,
      'created_at': FieldValue.serverTimestamp(),
    });
    _logger.i('CustomCategoryRepository: added $categoryId ($label)');
    return categoryId;
  }

  @override
  Future<void> deleteCategory({
    required String userId,
    required String categoryId,
  }) async {
    await _customCategoriesOf(userId).doc(categoryId).delete();
    _logger.i('CustomCategoryRepository: deleted $categoryId');
  }
}
