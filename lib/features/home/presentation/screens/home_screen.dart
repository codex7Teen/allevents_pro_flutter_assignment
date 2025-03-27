import 'package:allevents_pro/core/config/app_colors.dart';
import 'package:allevents_pro/core/config/app_router.dart';
import 'package:allevents_pro/core/config/app_text_styles.dart';
import 'package:allevents_pro/core/utils/screen_dimesions_util.dart';
import 'package:allevents_pro/data/models/category_model.dart';
import 'package:allevents_pro/features/home/providers/category_provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    super.initState();

    // Fetch categories when the screen is first loaded
    // Use a post-frame callback to ensure the context is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Call fetchCategories with the current context
      Provider.of<CategoryProvider>(
        context,
        listen: false,
      ).fetchCategories(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = ScreenDimensionsUtil.getScreenHeight(context);
    final categoryProvider = Provider.of<CategoryProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      //! A P P - B A R
      appBar: PreferredSize(
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
                              : () =>
                                  categoryProvider.navigateToCategoryDetails(
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
      ),

      //! B O D Y
      body: Column(
        children: [
          //! E X P L O R E  -  T E X T
          GestureDetector(
            onTap: () {
              //! B O T T O M  -  S H E E T
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) {
                  return Consumer<CategoryProvider>(
                    builder: (context, categoryProvider, child) {
                      if (categoryProvider.isCategoriesLoading) {
                        return SizedBox(
                          height: 200,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      if (categoryProvider.categoryError != null) {
                        return SizedBox(
                          height: 200,
                          child: Center(
                            child: Text("Error loading categories"),
                          ),
                        );
                      }

                      return Container(
                        padding: EdgeInsets.all(16),
                        height: screenHeight * 0.42,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: FractionallySizedBox(
                                widthFactor: 0.2, // width of top divider bar
                                child: Container(
                                  height: 5.0,
                                  decoration: BoxDecoration(
                                    color:
                                        Colors
                                            .white, // color of top divider bar
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(2.5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
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
                            Expanded(
                              child: ListView.separated(
                                itemCount: categoryProvider.categories.length,
                                separatorBuilder: (context, index) {
                                  return Divider();
                                },
                                itemBuilder: (context, index) {
                                  final category =
                                      categoryProvider.categories[index];
                                  return ListTile(
                                    leading: SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                          CategoryModel.getGenreImagePath(
                                            category.category,
                                          ),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      category.category[0].toUpperCase() +
                                          category.category.substring(1),
                                      style: AppTextStyles.bodySmall2.copyWith(
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pop(
                                        context,
                                      ); // Close bottom sheet
                                      categoryProvider
                                          .navigateToCategoryDetails(
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
                    },
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, top: 20),
              child: FadeInLeft(
                // delay: Duration(milliseconds: 400),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Explore Categories',
                      style: AppTextStyles.subHeadings,
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.greyColor2,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),

          //! A L L  -  C A T E G O R I E S
          const SizedBox(height: 20),

          // Consumer to listen to CategoryProvider changes
          Consumer<CategoryProvider>(
            builder: (context, categoryProvider, child) {
              // Show shimmer effect while loading categories
              if (categoryProvider.isCategoriesLoading) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: SizedBox(
                    height: 130,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6, // Placeholder shimmer items
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            children: [
                              //! Shimmer Image
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              //! Shimmer Text
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 70,
                                  height: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              }

              //! Show error if any
              if (categoryProvider.categoryError != null) {
                return Center(
                  child: Column(
                    children: [
                      Text(
                        'Error loading categories',
                        style: TextStyle(color: Colors.red),
                      ),
                      ElevatedButton(
                        onPressed:
                            () => categoryProvider.fetchCategories(context),
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              //! Show categories
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryProvider.categories.length,
                    itemBuilder: (context, index) {
                      final category = categoryProvider.categories[index];
                      return GestureDetector(
                        onTap: () {
                          // Navigate to category details when tapped
                          categoryProvider.navigateToCategoryDetails(
                            context,
                            category,
                          );
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
                                    CategoryModel.getGenreImagePath(
                                      category.category,
                                    ),
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
                    },
                  ),
                ),
              );
            },
          ),
          Spacer(),
          FadeInUp(
            child: Image.asset(
              'assets/images/home_screen_quote.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
