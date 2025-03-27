import 'package:allevents_pro/data/models/category_model.dart';
import 'package:allevents_pro/data/services/category_services.dart';

class CategoryRepository {
  final CategoryService _categoryService = CategoryService();

  Future<List<CategoryModel>> getCategories() async {
    return await _categoryService.fetchCategories();
  }
}