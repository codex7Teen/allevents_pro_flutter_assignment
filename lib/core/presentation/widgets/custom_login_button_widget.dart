import 'package:allevents_pro/core/config/app_colors.dart';
import 'package:allevents_pro/core/config/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomLoginButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final String buttonText;
  final String image;
  const CustomLoginButtonWidget({
    super.key,
    this.onTap,
    required this.buttonText,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.whiteColor),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image, width: 28),
              Spacer(),
              Text(buttonText, style: AppTextStyles.titleMedium2),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
