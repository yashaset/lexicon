import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,

      scaffoldBackgroundColor: AppColors.background,

      colorScheme: const ColorScheme.light(
        brightness: Brightness.light,

        primary: AppColors.accent,

        surface: AppColors.surface,

        onSurface: AppColors.textPrimary,

        onPrimary: Colors.white,

        outline: AppColors.divider,
      ),
      fontFamily: 'IBMPlexSans',
      cardColor: AppColors.surface,
      dividerColor: AppColors.divider,
      splashFactory: NoSplash.splashFactory,
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
      highlightColor: Colors.transparent,
      cardTheme: const CardThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),

        elevation: 0,
      ),
      hoverColor: AppColors.accent.withOpacity(.06),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.accent,

        selectionColor: Color(0x33F47C20),

        selectionHandleColor: AppColors.accent,
      ),
    );
  }
}
