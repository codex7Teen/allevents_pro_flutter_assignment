class CategoryModel {
  final String category;
  final String data;

  CategoryModel({required this.category, required this.data});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      category: json['category'] ?? 'Unknown',
      data: json['data'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'category': category, 'data': data};
  }

  static List<CategoryModel> fromJsonList(List<dynamic> json) {
    return json.map((item) => CategoryModel.fromJson(item)).toList();
  }

  // Method to get image path based on api data
  static String getGenreImagePath(String genreName) {
    switch (genreName) {
      case 'all':
        return 'assets/images/category_images/party.jpeg';
      case 'music':
        return 'assets/images/category_images/music.jpeg';
      case 'business':
        return 'assets/images/category_images/business.jpeg';
      case 'sports':
        return 'assets/images/category_images/sports.jpeg';
      case 'workshops':
        return 'assets/images/category_images/workshops.jpeg';
      case 'cooking':
        return 'assets/images/category_images/cooking.jpeg';
      case 'parties':
        return 'assets/images/category_images/party.jpeg';
      case 'comedy':
        return 'assets/images/category_images/comedy.jpeg';
      default:
        return 'assets/images/category_images/party.jpeg';
    }
  }
}
