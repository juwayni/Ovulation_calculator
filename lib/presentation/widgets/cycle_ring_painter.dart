import 'dart:math';
import 'package:flutter/material.dart';

class CycleRingPainter extends CustomPainter {
  final int totalDays;
  final int currentDay;
  final List<int> periodDays;
  final List<int> fertileDays;
  final int? ovulationDay;
  final List<int> pmsDays;
  final Color periodColor;
  final Color fertileColor;
  final Color pmsColor;
  final Color defaultColor;

  CycleRingPainter({
    required this.totalDays,
    required this.currentDay,
    required this.periodDays,
    required this.fertileDays,
    this.ovulationDay,
    required this.pmsDays,
    required this.periodColor,
    required this.fertileColor,
    required this.pmsColor,
    this.defaultColor = const Color(0xFFD3D3D3), // Light grey for inactive
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - 10;

    final double angleStep = (2 * pi) / totalDays;
    const double dotRadius = 6.0;

    for (int i = 0; i < totalDays; i++) {
      final day = i + 1;
      Color color = defaultColor;

      if (periodDays.contains(day)) {
        color = periodColor;
      } else if (fertileDays.contains(day)) {
        color = fertileColor;
      } else if (pmsDays.contains(day)) {
        color = pmsColor;
      }

      final angle = -pi / 2 + (i * angleStep);
      final dotCenter = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );

      // Current day highlight
      if (day == currentDay) {
        final outerPaint = Paint()
          ..color = color.withOpacity(0.3)
          ..style = PaintingStyle.fill;
        canvas.drawCircle(dotCenter, dotRadius + 6, outerPaint);

        final borderPaint = Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
        canvas.drawCircle(dotCenter, dotRadius + 6, borderPaint);
      }

      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      canvas.drawCircle(dotCenter, dotRadius, paint);

      // If it's the ovulation day, add a white dot inside
      if (day == ovulationDay) {
        final whitePaint = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;
        canvas.drawCircle(dotCenter, 2, whitePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CycleRingPainter oldDelegate) {
    return oldDelegate.currentDay != currentDay ||
        oldDelegate.totalDays != totalDays ||
        oldDelegate.ovulationDay != ovulationDay;
  }
}
