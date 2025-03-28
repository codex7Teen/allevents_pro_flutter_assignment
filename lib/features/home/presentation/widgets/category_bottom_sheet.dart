import 'package:allevents_pro/core/config/app_colors.dart';
import 'package:allevents_pro/core/config/app_text_styles.dart';
import 'package:allevents_pro/data/models/category_model.dart';
import 'package:allevents_pro/features/home/providers/category_provider.dart';
import 'package:flutter/material.dart';

/// A bottom sheet widget to display event categories
class CategoryBottomSheet extends StatelessWidget {
  final CategoryProvider categoryProvider; // Instance of CategoryProvider

  const CategoryBottomSheet({super.key, required this.categoryProvider});

  @override
  Widget build(BuildContext context) {
    final screenHeight =
        MediaQuery.of(context).size.height; // Get screen height

    // Show loading indicator if categories are still loading
    if (categoryProvider.isCategoriesLoading) {
      return SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    // Show error message if there is an issue loading categories
    if (categoryProvider.categoryError != null) {
      return SizedBox(
        height: 200,
        child: Center(child: Text("Error loading categories")),
      );
    }

    return Container(
      padding: EdgeInsets.all(16),
      height: screenHeight * 0.42,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top indicator bar for bottom sheet
          Align(
            alignment: Alignment.center,
            child: FractionallySizedBox(
              widthFactor: 0.2,
              child: Container(
                height: 5.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(2.5)),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),

          // Title text with highlighted category word
          RichText(
            text: TextSpan(
              text: "Choose your preferred",
              style: AppTextStyles.subHeadings,
              children: [
                TextSpan(
                  text: " Category",
                  style: AppTextStyles.subHeadings.copyWith(
                    color: AppColors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),

          // List of categories
          Expanded(
            child: ListView.separated(
              itemCount: categoryProvider.categories.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                final category = categoryProvider.categories[index];
                return ListTile(
                  leading: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        CategoryModel.getGenreImagePath(category.category),
                      ),
                    ),
                  ),
                  title: Text(
                    // Capitalize first letter of category name
                    category.category[0].toUpperCase() +
                        category.category.substring(1),
                    style: AppTextStyles.bodySmall2.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                  onTap: () {
                    // Close bottom sheet and navigate to category details
                    Navigator.pop(context);
                    categoryProvider.navigateToCategoryDetails(
                      context,
                      category,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
