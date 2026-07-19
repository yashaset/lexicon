import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  const AppTypography._();

  static TextTheme get textTheme => TextTheme(
    headlineLarge: GoogleFonts.ibmPlexSans(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      height: 1.15,
    ),

    headlineMedium: GoogleFonts.ibmPlexSans(
      fontSize: 22,
      fontWeight: FontWeight.w600,
    ),

    titleLarge: GoogleFonts.ibmPlexSans(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),

    titleMedium: GoogleFonts.ibmPlexSans(
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),

    bodyLarge: GoogleFonts.ibmPlexSans(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),

    bodyMedium: GoogleFonts.ibmPlexSans(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.45,
    ),

    bodySmall: GoogleFonts.ibmPlexSans(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      height: 1.4,
    ),

    labelLarge: GoogleFonts.ibmPlexSans(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.2,
    ),
  );
}