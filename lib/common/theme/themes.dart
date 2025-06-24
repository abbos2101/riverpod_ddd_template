import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

abstract class AppThemes {
  const AppThemes._();

  static ThemeData get light {
    return ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hintColor: const Color(0x660D1126),
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      fontFamily: GoogleFonts.inter().fontFamily,
      appBarTheme: _appBarTheme,
      expansionTileTheme: _expansionTileTheme,
      inputDecorationTheme: _inputDecorationTheme,
      textTheme: _textTheme,
    );
  }

  static AppBarTheme get _appBarTheme {
    return const AppBarTheme(
      centerTitle: false,
      elevation: 2,
      scrolledUnderElevation: 2,
      shadowColor: Color(0x0F14151A),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      actionsIconTheme: IconThemeData(color: AppColors.dark, size: 24),
    );
  }

  static ExpansionTileThemeData get _expansionTileTheme {
    return const ExpansionTileThemeData(
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      collapsedBackgroundColor: Colors.white,
      iconColor: AppColors.green,
      collapsedIconColor: AppColors.green,
      textColor: AppColors.green,
      collapsedTextColor: AppColors.darkBlue,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.transparent),
      ),
      collapsedShape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.transparent),
      ),
    );
  }

  static InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      hintStyle: const TextStyle(
        color: Color(0x660D1126),
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: const TextStyle(
        color: AppColors.red,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 1, color: Color(0xFFBCBFCC)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 1, color: AppColors.darkBlue),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 1, color: Color(0xFFBCBFCC)),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 1, color: Color(0x55BCBFCC)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(width: 1, color: AppColors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(width: 1.5, color: AppColors.red),
      ),
    );
  }

  static TextTheme get _textTheme {
    return const TextTheme(
      // for TextField
      bodyLarge: TextStyle(color: AppColors.dark, fontWeight: FontWeight.w400),
      // for Text
      bodyMedium: TextStyle(color: AppColors.dark, fontWeight: FontWeight.w500),
    );
  }
}
