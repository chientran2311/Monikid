import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_repository.g.dart';

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
  final FirebaseFirestore _firestore;
  final Logger _logger;

  CategoryRepositoryImpl(this._firestore, this._logger);

  @override
  Stream<List<CategoryModel>> getUserCategories(String userId) {
    _logger.i('Listening categories for user: $userId');
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => CategoryModel.fromFirestore(doc))
              .toList();
        });
  }

  @override
  Future<void> addCategory(String userId, CategoryModel category) async {
    try {
      _logger.i('Adding category ${category.id} for user: $userId');
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('categories')
          .doc(category.id)
          .set(category.toFirestore());
      _logger.i('Category added successfully');
    } catch (e, stackTrace) {
      _logger.e('Error adding category', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> deleteCategory(String userId, String categoryId) async {
    try {
      _logger.i('Deleting category $categoryId for user: $userId');
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('categories')
          .doc(categoryId)
          .delete();
      _logger.i('Category deleted successfully');
    } catch (e, stackTrace) {
      _logger.e('Error deleting category', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
