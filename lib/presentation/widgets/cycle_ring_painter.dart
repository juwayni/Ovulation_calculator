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
    this.defaultColor = const Color(0xFFF0F0F0),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;
    const strokeWidth = 25.0;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final double sweepAngle = (2 * pi) / totalDays;
    const double gap = 0.05;

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

      paint.color = color;

      // If it's the current day, we might want to highlight it or draw it differently
      // But for the ring segments, we just draw them.

      final startAngle = -pi / 2 + (i * sweepAngle) + gap;
      final drawAngle = sweepAngle - (2 * gap);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle,
        drawAngle,
        false,
        paint,
      );
    }

    // Draw indicator for current day
    final indicatorPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final indicatorAngle = -pi / 2 + ((currentDay - 1) * sweepAngle) + sweepAngle / 2;
    final indicatorX = center.dx + (radius - strokeWidth / 2) * cos(indicatorAngle);
    final indicatorY = center.dy + (radius - strokeWidth / 2) * sin(indicatorAngle);

    canvas.drawCircle(Offset(indicatorX, indicatorY), strokeWidth / 2 + 2, shadowPaint);
    canvas.drawCircle(Offset(indicatorX, indicatorY), strokeWidth / 2 - 2, indicatorPaint);

    // Draw dot for ovulation
    if (ovulationDay != null) {
        final ovAngle = -pi / 2 + ((ovulationDay! - 1) * sweepAngle) + sweepAngle / 2;
        final ovX = center.dx + (radius - strokeWidth / 2) * cos(ovAngle);
        final ovY = center.dy + (radius - strokeWidth / 2) * sin(ovAngle);

        final ovPaint = Paint()..color = Colors.white..style = PaintingStyle.fill;
        canvas.drawCircle(Offset(ovX, ovY), 4, ovPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CycleRingPainter oldDelegate) {
    return oldDelegate.currentDay != currentDay ||
           oldDelegate.totalDays != totalDays ||
           oldDelegate.ovulationDay != ovulationDay;
  }
}
