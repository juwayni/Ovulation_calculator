import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'theme_extension.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        background: AppColors.background,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
        onBackground: AppColors.textPrimary,
      ),
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        displayLarge: GoogleFonts.poppins(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.poppins(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: GoogleFonts.poppins(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: GoogleFonts.poppins(color: AppColors.textPrimary),
        bodyMedium: GoogleFonts.poppins(color: AppColors.textSecondary),
      ),
      extensions: [
        CycleThemeExtension(
          fertile: AppColors.fertile,
          pms: AppColors.pms,
          period: AppColors.period,
          ovulation: AppColors.ovulation,
          follicular: AppColors.follicular,
          luteal: AppColors.luteal,
          temperatureLine: AppColors.temperatureLine,
          temperatureArea: AppColors.temperatureArea,
        ),
      ],
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF121212),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: Colors.blueGrey,
        surface: const Color(0xFF1E1E1E),
        background: const Color(0xFF121212),
        error: AppColors.error,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme)
          .copyWith(
            displayLarge: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            bodyLarge: GoogleFonts.poppins(color: Colors.white70),
          ),
      extensions: [
        CycleThemeExtension(
          fertile: AppColors.fertile,
          pms: AppColors.pms,
          period: AppColors.period,
          ovulation: AppColors.ovulation,
          follicular: AppColors.follicular,
          luteal: AppColors.luteal,
          temperatureLine: AppColors.temperatureLine,
          temperatureArea: AppColors.temperatureArea.withOpacity(0.3),
        ),
      ],
    );
  }
}
