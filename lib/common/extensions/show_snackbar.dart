import 'package:flutter/material.dart';
import 'package:riverpod_ddd_template/common/theme/colors.dart';

void showSnackBar(
  BuildContext context, {
  required String message,
  SnackBarType type = SnackBarType.info,
  Duration duration = const Duration(seconds: 3),
}) {
  final colors = AppColors.of(context);
  Color backgroundColor;
  Color textColor = colors.onSurface;

  switch (type) {
    case SnackBarType.success:
      backgroundColor = colors.success;
      break;
    case SnackBarType.error:
      backgroundColor = colors.error;
      break;
    case SnackBarType.warning:
      backgroundColor = colors.warning;
      break;
    case SnackBarType.info:
      backgroundColor = colors.info;
      break;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: TextStyle(color: textColor)),
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}

enum SnackBarType { success, error, warning, info }
