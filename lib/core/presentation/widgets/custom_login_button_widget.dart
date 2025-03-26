import 'package:allevents_pro/core/config/app_colors.dart';
import 'package:allevents_pro/core/config/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoginButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final String buttonText;
  final String image;
  final bool isLoading;
  const CustomLoginButtonWidget({
    super.key,
    this.onTap,
    required this.buttonText,
    required this.image,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: isLoading ? 0 : 12,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.whiteColor),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image, width: 28),
              Spacer(),
              isLoading
                  ? SizedBox(
                    width: 50,
                    height: 50,
                    child: Lottie.asset(
                      'assets/lottie/Animation - 1743004383417.json',
                    ),
                  )
                  : Text(buttonText, style: AppTextStyles.titleMedium2),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
