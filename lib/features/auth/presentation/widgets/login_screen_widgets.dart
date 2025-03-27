import 'dart:ui';

import 'package:allevents_pro/core/config/app_colors.dart';
import 'package:allevents_pro/core/config/app_text_styles.dart';
import 'package:allevents_pro/core/presentation/widgets/custom_login_button_widget.dart';
import 'package:allevents_pro/features/auth/providers/auth_service_provider.dart';
import 'package:allevents_pro/shared/custom_snackbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreenWidgets {
  static buildBackgroundImage(
    bool imageLoaded,
    bool mounted,
    VoidCallback onTap,
  ) {
    return AnimatedOpacity(
      opacity: imageLoaded ? 1.0 : 0.0,
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
                  onTap;
                }
              });
            }
            return child;
          },
        ),
      ),
    );
  }

  static buildBlur() {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(color: Colors.black.withValues(alpha: 0.75)),
      ),
    );
  }

  static buildSignuptext() {
    return Text(
      textAlign: TextAlign.center,
      'Sign In',
      style: AppTextStyles.headingLarge,
    );
  }

  static buildDiscoverText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Text(
        textAlign: TextAlign.center,
        'Discover events, meet new people and\nmake memories',
        style: AppTextStyles.titleMedium.copyWith(height: 1.7),
      ),
    );
  }

  static buildFacebooksignin(BuildContext context) {
    return CustomLoginButtonWidget(
      onTap:
          () => CustomSnackbar.show(
            context,
            message: 'This feature is coming soon...',
            type: SnackBarType.info,
          ),
      buttonText: 'Continue with Facebook',
      image: 'assets/images/facebook-circle-logo-no_bg.png',
    );
  }

  static buildGoogleLogin() {
    return Consumer<AuthServiceProvider>(
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
    );
  }

  static buildEmailLogin(BuildContext context) {
    return CustomLoginButtonWidget(
      onTap:
          () => CustomSnackbar.show(
            context,
            message: 'This feature is coming soon...',
            type: SnackBarType.info,
          ),
      buttonText: 'Sign In with Email',
      image: 'assets/images/mail_log_nobg.png',
    );
  }

  static buildTermsAndConditions() {
    return Padding(
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
                    },
            ),
          ],
        ),
      ),
    );
  }
}
