import 'dart:async';
import 'package:flutter/material.dart';
import 'package:allevents_pro/core/config/app_colors.dart';
import 'package:allevents_pro/core/config/app_text_styles.dart';

enum SnackBarType { standard, success, error, warning, info }

class RateLimiter {
  // ignore: unused_field
  Timer? _timer;
  bool _canShow = true;

  void run(
    VoidCallback action, {
    Duration duration = const Duration(seconds: 2),
  }) {
    if (_canShow) {
      action();
      _canShow = false;
      _timer = Timer(duration, () => _canShow = true);
    }
  }
}

class CustomSnackbar {
  static final RateLimiter _rateLimiter = RateLimiter();

  static void show(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onActionPressed,
    SnackBarType type = SnackBarType.standard,
    Duration duration = const Duration(seconds: 4),
  }) {
    _rateLimiter.run(() {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      scaffoldMessenger.hideCurrentSnackBar();

      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(_getIcon(type), color: Colors.white, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          duration: duration,
          backgroundColor: _getBackgroundColor(type),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 6,
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.05,
            vertical: 12,
          ),
          action:
              actionLabel != null
                  ? SnackBarAction(
                    label: actionLabel,
                    onPressed: onActionPressed ?? () {},
                    textColor: AppColors.whiteColor,
                  )
                  : null,
        ),
      );
    });
  }

  static Color _getBackgroundColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Colors.green[600]!;
      case SnackBarType.error:
        return Colors.red[600]!;
      case SnackBarType.warning:
        return Colors.orange[700]!;
      case SnackBarType.info:
        return Colors.blue[600]!;
      default:
        return Colors.black87;
    }
  }

  static IconData _getIcon(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle_outline;
      case SnackBarType.error:
        return Icons.error_outline;
      case SnackBarType.warning:
        return Icons.warning_amber_rounded;
      case SnackBarType.info:
        return Icons.info_outline;
      default:
        return Icons.info_outline;
    }
  }
}
