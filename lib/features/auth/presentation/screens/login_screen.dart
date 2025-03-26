import 'dart:ui';
import 'package:allevents_pro/core/config/app_colors.dart';
import 'package:allevents_pro/core/config/app_text_styles.dart';
import 'package:allevents_pro/core/utils/screen_dimesions_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  // bool to shoow animation for image
  bool _imageLoaded = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = ScreenDimensionsUtil.getScreenHeight(context);
    return Stack(
      children: [
        // Black placeholder background while image loads
        Container(color: AppColors.blackColor),

        // Background image with fade
        AnimatedOpacity(
          opacity: _imageLoaded ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: SizedBox.expand(
            child: Image.asset(
              'assets/images/login_background.jpg',
              fit: BoxFit.cover,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (frame != null) {
                  // Image has loaded
                  Future.delayed(const Duration(milliseconds: 100), () {
                    if (mounted) {
                      setState(() {
                        _imageLoaded = true;
                      });
                    }
                  });
                }
                return child;
              },
            ),
          ),
        ),

        // Applying blur
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(color: Colors.black.withValues(alpha: 0.8)),
          ),
        ),

        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.05),
              //! S I G N - I N    T E X T
              Text(
                textAlign: TextAlign.center,
                'Sign In',
                style: AppTextStyles.headingLarge,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                //! D I S C O V E R   T E X T
                child: Text(
                  textAlign: TextAlign.center,
                  'Discover events, meet new people and\nmake memories',
                  style: AppTextStyles.titleMedium.copyWith(height: 1.7),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),

              //! G O O G L E - S I G N I N
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.whiteColor),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/facebook-circle-logo-no_bg.png',
                          width: 28,
                        ),
                        Spacer(),
                        Text(
                          'Continue with Facebook',
                          style: GoogleFonts.poppins(
                            color: AppColors.whiteColor,
                            fontSize: 17,
                            decoration: TextDecoration.none,
                            letterSpacing: 0.01,
                            wordSpacing: 1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.1),
            ],
          ),
        ),
      ],
    );
  }
}
