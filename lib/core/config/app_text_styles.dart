import 'package:allevents_pro/core/config/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle headingLarge = GoogleFonts.poppins(
    color: AppColors.whiteColor,
    decoration: TextDecoration.none,
    fontSize: 38,
    fontWeight: FontWeight.w600,
  );

    static TextStyle titleMedium = GoogleFonts.poppins(
                    color: AppColors.whiteColor,
                    fontSize: 17,
                    decoration: TextDecoration.none,
                    letterSpacing: 0.01,
                    wordSpacing: 1,
                  );
}
