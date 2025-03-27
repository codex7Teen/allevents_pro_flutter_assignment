class CategoryModel {
  final String category; // Category name
  final String data; // Additional data related to category

  CategoryModel({required this.category, required this.data});

  //! F A C T O R Y   C O N S T R U C T O R
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      category: json['category'] ?? 'Unknown', // Handle missing category
      data: json['data'] ?? '', // Handle missing data
    );
  }

  //! C O N V E R T   T O   J S O N
  Map<String, dynamic> toJson() {
    return {'category': category, 'data': data};
  }

  //! C O N V E R T   J S O N   L I S T   T O   M O D E L   L I S T
  static List<CategoryModel> fromJsonList(List<dynamic> json) {
    return json.map((item) => CategoryModel.fromJson(item)).toList();
  }

  //! G E T   I M A G E   P A T H   B A S E D   O N   G E N R E
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
        return 'assets/images/category_images/party.jpeg'; // Default image
    }
  }
}
