import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final FirebaseFirestore _firestore;

  CategoryRepositoryImpl(this._firestore);

  @override
  Stream<List<CategoryModel>> getUserCategories(String userId) {
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
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .doc(category.id)
        .set(category.toFirestore());
  }

  @override
  Future<void> deleteCategory(String userId, String categoryId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .doc(categoryId)
        .delete();
  }
}
