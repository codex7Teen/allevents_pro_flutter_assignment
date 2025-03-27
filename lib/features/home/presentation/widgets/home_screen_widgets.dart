import 'package:allevents_pro/core/config/app_colors.dart';
import 'package:allevents_pro/core/config/app_text_styles.dart';
import 'package:allevents_pro/data/models/category_model.dart';
import 'package:allevents_pro/features/home/providers/category_provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class HomeScreenWidgets {
  static PreferredSizeWidget buildAppbar(
    double screenHeight,
    CategoryProvider categoryProvider,
    BuildContext context,
  ) {
    return PreferredSize(
      preferredSize: Size.fromHeight(screenHeight * 0.145),
      child: AppBar(
        elevation: 0,
        flexibleSpace: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/appbar_bg_image.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Container(color: AppColors.blackColor.withValues(alpha: 0.7)),

            //! A P P - B A R   C O N T E N T
            Padding(
              padding: const EdgeInsets.only(left: 22, top: 40, right: 22),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 8,
                    children: [
                      FadeInLeft(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Image.asset(
                            'assets/images/allevents_logo_nobg.png',
                            width: 30,
                          ),
                        ),
                      ),
                      FadeInLeft(
                        child: Text(
                          'Ahmedabad',
                          style: AppTextStyles.bodySmall2,
                        ),
                      ),
                      FadeInLeft(
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      Spacer(),
                      FadeInRight(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 14),
                          child: Icon(
                            Icons.notifications,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),

                  //! Search Bar
                  GestureDetector(
                    onTap:
                        categoryProvider.isCategoriesLoading
                            ? null
                            : () => categoryProvider.navigateToCategoryDetails(
                              context,
                              categoryProvider.categories[0],
                            ),
                    child: Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.search_rounded,
                            color: AppColors.greyColor2,
                            size: 22,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: "What’s your next adventure? 🎉",
                                border: InputBorder.none,
                                hintStyle: AppTextStyles.hintTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static buildExploreCategoriesButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14, top: 20),
      child: FadeInLeft(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Explore Categories', style: AppTextStyles.subHeadings),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.greyColor2,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  static buildCategoriesError(
    BuildContext context,
    CategoryProvider categoryProvider,
  ) {
    return Center(
      child: Column(
        children: [
          Text('Error loading categories', style: TextStyle(color: Colors.red)),
          ElevatedButton(
            onPressed: () => categoryProvider.fetchCategories(context),
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }

  static buildScreenbottomQuote() {
    return FadeInUp(
      child: Image.asset(
        'assets/images/home_screen_quote.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  static buildCategoriesList(CategoryProvider categoryProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: SizedBox(
        height: 130,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryProvider.categories.length,
          itemBuilder: (context, index) {
            final category = categoryProvider.categories[index];
            return HomeScreenWidgets.buildCategoriesCard(
              categoryProvider,
              context,
              category,
            );
          },
        ),
      ),
    );
  }

  static buildCategoriesCard(
    CategoryProvider categoryProvider,
    BuildContext context,
    CategoryModel category,
  ) {
    return GestureDetector(
      onTap: () {
        // Navigate to category details when tapped
        categoryProvider.navigateToCategoryDetails(context, category);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Column(
          children: [
            //! Image
            SizedBox(
              width: 90,
              height: 90,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  CategoryModel.getGenreImagePath(category.category),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 5),
            //! Text
            Text(
              category.category[0].toUpperCase() +
                  category.category.substring(1),
              style: AppTextStyles.bodySmall2.copyWith(
                color: AppColors.blackColor,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
