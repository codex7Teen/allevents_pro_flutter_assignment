import 'dart:ui';
import 'package:allevents_pro/core/config/app_colors.dart';
import 'package:allevents_pro/core/config/app_text_styles.dart';
import 'package:allevents_pro/core/presentation/widgets/custom_login_button_widget.dart';
import 'package:allevents_pro/core/utils/screen_dimesions_util.dart';
import 'package:allevents_pro/features/auth/providers/auth_service_provider.dart';
import 'package:allevents_pro/shared/custom_snackbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return Scaffold(
      body: Stack(
        children: [
          // Black placeholder background while image loads
          Container(color: AppColors.blackColor),

          // Background image with fade
          AnimatedOpacity(
            opacity: _imageLoaded ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: SizedBox.expand(
              child: Image.asset(
                'assets/images/login_screen_background.jpg',
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
              child: Container(color: Colors.black.withValues(alpha: 0.75)),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.06),
                //! S I G N - I N    T E X T
                Text(
                  textAlign: TextAlign.center,
                  'Sign In',
                  style: AppTextStyles.headingLarge,
                ),
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  //! D I S C O V E R   T E X T
                  child: Text(
                    textAlign: TextAlign.center,
                    'Discover events, meet new people and\nmake memories',
                    style: AppTextStyles.titleMedium.copyWith(height: 1.7),
                  ),
                ),
                SizedBox(height: screenHeight * 0.055),

                //! F A C E B O O K - S I G N I N
                CustomLoginButtonWidget(
                  onTap:
                      () => CustomSnackbar.show(
                        context,
                        message: 'This feature is coming soon...',
                        type: SnackBarType.info,
                      ),
                  buttonText: 'Continue with Facebook',
                  image: 'assets/images/facebook-circle-logo-no_bg.png',
                ),
                SizedBox(height: screenHeight * 0.014),

                //! G O O G L E - S I G N I N
                Consumer<AuthServiceProvider>(
                  builder: (context, authProvider, child) {
                    return CustomLoginButtonWidget(
                      onTap:
                          authProvider.isGoogleLoginLoading
                              ? null
                              : () => authProvider.signInWithGoogle(context),
                      buttonText: 'Sign In with Google',
                      image: 'assets/images/google_logo_nobg.png',
                      isLoading: authProvider.isGoogleLoginLoading,
                    );
                  },
                ),
                SizedBox(height: screenHeight * 0.014),

                //! E M A I L - S I G N I N
                CustomLoginButtonWidget(
                  onTap:
                      () => CustomSnackbar.show(
                        context,
                        message: 'This feature is coming soon...',
                        type: SnackBarType.info,
                      ),
                  buttonText: 'Sign In with Email',
                  image: 'assets/images/mail_log_nobg.png',
                ),
                SizedBox(height: screenHeight * 0.065),

                //! T E R M S   &   C O N D I T I O N S
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: "By signing in, I agree to AllEvent's ",
                      style: AppTextStyles.bodySmall,
                      children: [
                        TextSpan(
                          text: "Privacy Policy",
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.blueAccent,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  // Open Privacy Policy URL
                                  launchUrl(
                                    Uri.parse(
                                      "https://you-privacy-policy-url.com",
                                    ),
                                  );
                                },
                        ),
                        TextSpan(
                          text: " and ",
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.greyColor,
                          ),
                        ),
                        TextSpan(
                          text: "Terms of Service.",
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.blueAccent,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  // Open Terms of Service URL
                                  launchUrl(
                                    Uri.parse("https://your-terms-url.com"),
                                  );
                                },
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.04),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
