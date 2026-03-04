import 'package:monikid/models/entities/category_model.dart';

abstract class CategoryRepository {
  Stream<List<CategoryModel>> getUserCategories(String userId);
  Future<void> addCategory(String userId, CategoryModel category);
  Future<void> deleteCategory(String userId, String categoryId);
}
