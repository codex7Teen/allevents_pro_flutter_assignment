import 'package:allevents_pro/core/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScreenSplash1 extends StatefulWidget {
  final String? screenName;
  const ScreenSplash1({super.key, this.screenName});

  @override
  State<ScreenSplash1> createState() => _ScreenSplash1State();
}

class _ScreenSplash1State extends State<ScreenSplash1> {
  bool _animateTextLogo = false;
  bool _animateLogo = false;

  @override
  void initState() {
    super.initState();

    // Delay for 1.5 second before triggering the animations
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _animateLogo = true;
        });

        // After triggering the logo animation, delay for the text logo animation
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted) {
            setState(() {
              _animateTextLogo = true;
            });
          }
        });
      }
    });

    // Navigate to intro-screen or Main screen based on argument
    Future.delayed(const Duration(milliseconds: 3000), () {
  if (mounted) {
    if (widget.screenName != null) {
      context.goNamed(widget.screenName!);
    }
  }
});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: ClipRect(
          child: SizedBox(
            width: 220,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Wulflex text that moves from right to center (background) with opacity animation
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 800),
                  left: _animateTextLogo ? 80 : 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 800),
                    opacity: _animateTextLogo ? 1.0 : 0.0,
                    child: Image.asset(
                      'assets/images/allevents_text_nobg.png',
                      width: 135,
                    ),
                  ),
                ),
                // Logo that stays centered initially, then moves slightly left (foreground)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 800),
                  left: _animateLogo ? -77 : 0,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 75,
                        height: 75,
                        child: ColoredBox(color: AppColors.whiteColor),
                      ),
                      Image.asset(
                        'assets/images/allevents_logo_whitebg.jpg',
                        width: 75,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
