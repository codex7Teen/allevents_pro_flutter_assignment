import 'package:allevents_pro/core/config/app_colors.dart';
import 'package:allevents_pro/core/config/app_text_styles.dart';
import 'package:allevents_pro/core/utils/screen_dimesions_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = ScreenDimensionsUtil.getScreenHeight(context);
    return Scaffold(
      //! A P P - B A R
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.155),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Image.asset(
                            'assets/images/allevents_logo_nobg.png',
                            width: 30,
                          ),
                        ),
                        Text('Ahmedabad', style: AppTextStyles.bodySmall2),
                        Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.whiteColor,
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 14),
                          child: Icon(
                            Icons.notifications,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14),
                    Container(
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
                                hintStyle: GoogleFonts.poppins(
                                  color: AppColors.greyColor2,
                                  fontSize: 13.5,
                                  letterSpacing: 0.01,
                                  wordSpacing: 1,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      body: Column(
        children: [

        ],
      ),
    );
  }
}
