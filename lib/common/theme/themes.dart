import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData theme(Brightness brightness) {
    final colorScheme = AppColors.withBrightness(brightness);

    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.inter().fontFamily,
      colorScheme: ColorScheme.fromSeed(
        seedColor: colorScheme.primary,
        brightness: brightness,
        primary: colorScheme.primary,
        secondary: colorScheme.secondary,
        error: colorScheme.error,
        background: colorScheme.background,
        surface: colorScheme.surface,
        onPrimary: colorScheme.onPrimary,
        onSecondary: colorScheme.onSecondary,
        onError: colorScheme.onError,
        onBackground: colorScheme.onBackground,
        onSurface: colorScheme.onSurface,
        shadow: colorScheme.shadow,
      ),
    );
  }
}

extension AppThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  AppColorScheme get appColors => AppColors.of(this);

  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}