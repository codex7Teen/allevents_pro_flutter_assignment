// Category Repository - Handles fetching event categories
import 'package:allevents_pro/data/models/category_model.dart';
import 'package:allevents_pro/data/services/category_services.dart';

class CategoryRepository {
  final CategoryService _categoryService =
      CategoryService(); // Instance of category service

  /// Fetches a list of event categories
  Future<List<CategoryModel>> getCategories() async {
    return await _categoryService.fetchCategories();
  }
}
