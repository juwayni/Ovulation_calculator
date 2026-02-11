import 'package:flutter/material.dart';

class CycleThemeExtension extends ThemeExtension<CycleThemeExtension> {
  final Color fertile;
  final Color pms;
  final Color period;
  final Color ovulation;
  final Color follicular;
  final Color luteal;
  final Color temperatureLine;
  final Color temperatureArea;

  CycleThemeExtension({
    required this.fertile,
    required this.pms,
    required this.period,
    required this.ovulation,
    required this.follicular,
    required this.luteal,
    required this.temperatureLine,
    required this.temperatureArea,
  });

  @override
  ThemeExtension<CycleThemeExtension> copyWith({
    Color? fertile,
    Color? pms,
    Color? period,
    Color? ovulation,
    Color? follicular,
    Color? luteal,
    Color? temperatureLine,
    Color? temperatureArea,
  }) {
    return CycleThemeExtension(
      fertile: fertile ?? this.fertile,
      pms: pms ?? this.pms,
      period: period ?? this.period,
      ovulation: ovulation ?? this.ovulation,
      follicular: follicular ?? this.follicular,
      luteal: luteal ?? this.luteal,
      temperatureLine: temperatureLine ?? this.temperatureLine,
      temperatureArea: temperatureArea ?? this.temperatureArea,
    );
  }

  @override
  ThemeExtension<CycleThemeExtension> lerp(
    ThemeExtension<CycleThemeExtension>? other,
    double t,
  ) {
    if (other is! CycleThemeExtension) {
      return this;
    }
    return CycleThemeExtension(
      fertile: Color.lerp(fertile, other.fertile, t)!,
      pms: Color.lerp(pms, other.pms, t)!,
      period: Color.lerp(period, other.period, t)!,
      ovulation: Color.lerp(ovulation, other.ovulation, t)!,
      follicular: Color.lerp(follicular, other.follicular, t)!,
      luteal: Color.lerp(luteal, other.luteal, t)!,
      temperatureLine: Color.lerp(temperatureLine, other.temperatureLine, t)!,
      temperatureArea: Color.lerp(temperatureArea, other.temperatureArea, t)!,
    );
  }
}
