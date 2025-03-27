import 'package:allevents_pro/core/config/app_colors.dart';
import 'package:allevents_pro/core/utils/screen_dimesions_util.dart';
import 'package:allevents_pro/features/auth/presentation/widgets/login_screen_widgets.dart';
import 'package:flutter/material.dart';

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
          LoginScreenWidgets.buildBackgroundImage(
            _imageLoaded,
            mounted,
            () => setState(() {
              _imageLoaded = true;
            }),
          ),

          // Applying blur
          LoginScreenWidgets.buildBlur(),

          //! C O N T E N T
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.06),
                //! S I G N - I N    T E X T
                LoginScreenWidgets.buildSignuptext(),
                SizedBox(height: screenHeight * 0.02),
                //! D I S C O V E R   T E X T
                LoginScreenWidgets.buildDiscoverText(),
                SizedBox(height: screenHeight * 0.055),

                //! F A C E B O O K - S I G N I N
                LoginScreenWidgets.buildFacebooksignin(context),
                SizedBox(height: screenHeight * 0.014),

                //! G O O G L E - S I G N I N
                LoginScreenWidgets.buildGoogleLogin(),
                SizedBox(height: screenHeight * 0.014),

                //! E M A I L - S I G N I N
                LoginScreenWidgets.buildEmailLogin(context),
                SizedBox(height: screenHeight * 0.065),

                //! T E R M S   &   C O N D I T I O N S
                LoginScreenWidgets.buildTermsAndConditions(),

                SizedBox(height: screenHeight * 0.04),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
