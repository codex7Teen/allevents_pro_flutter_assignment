import 'package:allevents_pro/core/config/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle headingLarge = GoogleFonts.poppins(
    color: AppColors.whiteColor,
    decoration: TextDecoration.none,
    fontSize: 40,
    fontWeight: FontWeight.w600,
  );

  static TextStyle titleMedium = GoogleFonts.poppins(
    color: AppColors.whiteColor,
    fontSize: 17,
    decoration: TextDecoration.none,
    letterSpacing: 0.01,
    wordSpacing: 1,
  );

  static TextStyle titleMedium2 = GoogleFonts.poppins(
    color: AppColors.whiteColor,
    fontSize: 17,
    decoration: TextDecoration.none,
    wordSpacing: 1,
    fontWeight: FontWeight.w500,
  );

  static TextStyle bodySmall = GoogleFonts.poppins(
    color: AppColors.greyColor,
    fontSize: 13,
    letterSpacing: 0.01,
    wordSpacing: 1,
    fontWeight: FontWeight.w400,
  );

    static TextStyle bodySmall2 = GoogleFonts.poppins(
    color: AppColors.whiteColor,
    fontSize: 13.5,
    letterSpacing: 0.01,
    wordSpacing: 1,
    fontWeight: FontWeight.w500,
  );
}
