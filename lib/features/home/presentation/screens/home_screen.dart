import 'package:allevents_pro/core/config/app_colors.dart';
import 'package:allevents_pro/core/utils/screen_dimesions_util.dart';
import 'package:allevents_pro/features/home/presentation/widgets/categories_shimmer.dart';
import 'package:allevents_pro/features/home/presentation/widgets/category_bottom_sheet.dart';
import 'package:allevents_pro/features/home/presentation/widgets/home_screen_widgets.dart';
import 'package:allevents_pro/features/home/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      //! B A C K G R O U N D  -  C O L O R
      backgroundColor: AppColors.whiteColor,
      //! A P P - B A R
      appBar: HomeScreenWidgets.buildAppbar(
        screenHeight,
        categoryProvider,
        context,
      ),

      //! B O D Y
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              //! B O T T O M  -  S H E E T
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) {
                  final categoryProvider = Provider.of<CategoryProvider>(
                    context,
                    listen: false,
                  );
                  return CategoryBottomSheet(
                    categoryProvider: categoryProvider,
                  );
                },
              );
            },
            //! E X P L O R E  -  C A T E G O R I E S - B U T T O N
            child: HomeScreenWidgets.buildExploreCategoriesButton(),
          ),

          const SizedBox(height: 20),
          //! A L L  -  C A T E G O R I E S
          Consumer<CategoryProvider>(
            builder: (context, categoryProvider, child) {
              //! Showing shimmer effect while loading categories
              if (categoryProvider.isCategoriesLoading) {
                return CategoriesShimmer();
              }

              //! Categories loading error
              if (categoryProvider.categoryError != null) {
                return HomeScreenWidgets.buildCategoriesError(
                  context,
                  categoryProvider,
                );
              }

              //! When categories are successfully loaded, show categories
              return HomeScreenWidgets.buildCategoriesList(categoryProvider);
            },
          ),
          Spacer(),
          //! S C R E E N - B O T T O M   Q U O T E
          HomeScreenWidgets.buildScreenbottomQuote(),
        ],
      ),
    );
  }
}
