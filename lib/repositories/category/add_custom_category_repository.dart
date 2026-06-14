import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_custom_category_repository.g.dart';

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
    String icon,
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
    _logger.d('CustomCategoryRepositoryImpl.watchUserCategories: userId=$userId');
    return _customCategoriesOf(userId)
        .orderBy('created_at')
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
          _logger.e('CustomCategoryRepositoryImpl.watchUserCategories failed. userId=$userId',
              error: error, stackTrace: stack);
          // Rethrow so the StreamProvider surfaces AsyncError instead of staying stuck in loading.
          throw error;
        });
  }

  @override
  Future<String> addCategory({
    required String userId,
    required String label,
    required String type,
    String icon = '📦',
  }) async {
    _logger.d('CustomCategoryRepositoryImpl.addCategory: userId=$userId, label=$label, type=$type');
    try {
      final docRef = _customCategoriesOf(userId).doc();
      final categoryId = docRef.id;
      await docRef.set({
        'category_id': categoryId,
        'label': label.trim(),
        'icon': icon,
        'type': type,
        'created_at': FieldValue.serverTimestamp(),
      });
      _logger.i('CustomCategoryRepositoryImpl.addCategory: success. categoryId=$categoryId');
      return categoryId;
    } catch (error, stackTrace) {
      _logger.e('CustomCategoryRepositoryImpl.addCategory failed. userId=$userId, label=$label',
          error: error, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> deleteCategory({
    required String userId,
    required String categoryId,
  }) async {
    _logger.d('CustomCategoryRepositoryImpl.deleteCategory: userId=$userId, categoryId=$categoryId');
    try {
      await _customCategoriesOf(userId).doc(categoryId).delete();
      _logger.i('CustomCategoryRepositoryImpl.deleteCategory: success. categoryId=$categoryId');
    } catch (error, stackTrace) {
      _logger.e('CustomCategoryRepositoryImpl.deleteCategory failed. categoryId=$categoryId',
          error: error, stackTrace: stackTrace);
      rethrow;
    }
  }
}
