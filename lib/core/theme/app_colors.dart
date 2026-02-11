import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFFFF6B81);
  static const Color primaryLight = Color(0xFFFFEEF0);
  static const Color secondary = Color(0xFF2D3436);

  static const Color background = Color(0xFFFFE8E9); // Figma Light Pink
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF636E72);
  static const Color textHint = Color(0xFFB2BEC3);

  static const Color error = Color(0xFFD63031);
  static const Color success = Color(0xFF00B894);

  // Domain specific colors matching Figma
  static const Color pms = Color(0xFFFFD93D); // Yellow
  static const Color period = Color(0xFFFF6B81); // Pink
  static const Color fertile = Color(0xFF40E0D0); // Teal
  static const Color follicular = Color(0xFF45B7AF);
  static const Color luteal = Color(0xFF8E44AD);
  static const Color ovulation = Color(0xFF40E0D0); // Usually same as fertile or distinct

  static const Color temperatureLine = Color(0xFFFF6B81);
  static const Color temperatureArea = Color(0xFFFFEEF0);
}
