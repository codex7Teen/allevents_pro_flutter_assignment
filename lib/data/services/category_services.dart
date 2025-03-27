import 'package:dio/dio.dart';
import '../models/category_model.dart';

class CategoryService {
  final Dio _dio = Dio();
  final String baseUrl = "https://allevents.s3.amazonaws.com/tests/categories.json";

  //! Fetches categories from the API
  //! Uses Dio for network requests and handles different HTTP status codes
  Future<List<CategoryModel>> fetchCategories() async {
    try {
      //! Making a GET request to fetch categories
      final response = await _dio.get(baseUrl);

      // Checking response status codes and handling errors accordingly
      if (response.statusCode == 200) {
        // Successfully retrieved category data, parsing JSON
        return CategoryModel.fromJsonList(response.data);
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized: Invalid request");
      } else if (response.statusCode == 404) {
        throw Exception("Not Found: The requested resource was not found");
      } else {
        throw Exception(
          "Failed to load categories. Status Code: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Error fetching categories: $e");
    }
  }
}