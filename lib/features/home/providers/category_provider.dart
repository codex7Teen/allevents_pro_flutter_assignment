import 'package:allevents_pro/core/config/app_router.dart';
import 'package:allevents_pro/data/models/category_model.dart';
import 'package:allevents_pro/data/repositories/category_repository.dart';
import 'package:allevents_pro/shared/custom_snackbar.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryRepository _categoryRepository = CategoryRepository();

  // List to store categories
  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  // Loading state for categories
  bool _isCategoriesLoading = false;
  bool get isCategoriesLoading => _isCategoriesLoading;

  // Error state
  String? _categoryError;
  String? get categoryError => _categoryError;

  // Fetch categories method
  Future<void> fetchCategories(BuildContext context) async {
    try {
      // Set loading state to true
      _isCategoriesLoading = true;
      _categoryError = null;
      notifyListeners();

      // Fetch categories from repository
      final fetchedCategories = await _categoryRepository.getCategories();

      // Update categories
      _categories = fetchedCategories;

      // Optional: Show success message
      CustomSnackbar.show(
        context,
        message: 'Categories loaded successfully',
        type: SnackBarType.success,
      );
    } catch (e) {
      // Set error state
      _categoryError = e.toString();

      // Show error snackbar
      CustomSnackbar.show(
        context,
        message: 'Failed to load categories: $e',
        type: SnackBarType.error,
      );
    } finally {
      // Set loading state to false
      _isCategoriesLoading = false;
      notifyListeners();
    }
  }

  // Method to get a category by its name
  CategoryModel? getCategoryByName(String categoryName) {
    try {
      return _categories.firstWhere(
        (category) =>
            category.category.toLowerCase() == categoryName.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  // Method to navigate to category details
  void navigateToCategoryDetails(BuildContext context, CategoryModel category) {
    try {
      // Example navigation - adjust based on your app's routing
      router.pushNamed('event_screen', extra: category);
    } catch (e) {
      CustomSnackbar.show(
        context,
        message: 'Failed to navigate to category details',
        type: SnackBarType.error,
      );
    }
  }

  // Method to refresh categories
  Future<void> refreshCategories(BuildContext context) async {
    await fetchCategories(context);
  }
}
