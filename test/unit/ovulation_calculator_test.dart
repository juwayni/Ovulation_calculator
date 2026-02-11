import 'package:flutter_test/flutter_test.dart';
import 'package:ovulation_calculator/domain/usecases/ovulation_calculator_service.dart';
import 'package:ovulation_calculator/data/models/period_model.dart';

void main() {
  late OvulationCalculatorService service;

  setUp(() {
    service = OvulationCalculatorService();
  });

  group('OvulationCalculatorService Tests', () {
    test('calculatePrediction returns current cycle for no periods', () {
      final now = DateTime(2023, 1, 1);
      final prediction = service.calculatePrediction(lastPeriods: [], referenceDate: now);

      expect(prediction.cycleLength, 28);
      // It should return the cycle that starts ON 'now' or just before it.
      // With no periods, it projects from 'now - 28'.
      expect(prediction.startDate, now);
    });

    test('calculatePrediction adapts to average cycle length and projects to reference date', () {
      final ref = DateTime(2023, 3, 5);
      final p1 = PeriodModel(id: '1', startDate: DateTime(2023, 1, 1));
      final p2 = PeriodModel(id: '2', startDate: DateTime(2023, 1, 31)); // 30 days diff

      final prediction = service.calculatePrediction(lastPeriods: [p1, p2], referenceDate: ref);

      expect(prediction.cycleLength, 30);
      // Cycle 1: Jan 1
      // Cycle 2: Jan 31
      // Cycle 3: Jan 31 + 30 = Mar 2
      // Since ref is Mar 5, it should return Cycle 3.
      expect(prediction.startDate, DateTime(2023, 3, 2));
    });

    test('fertile window calculation is correct', () {
      final ref = DateTime(2023, 1, 15);
      final p1 = PeriodModel(id: '1', startDate: DateTime(2023, 1, 1));
      final prediction = service.calculatePrediction(lastPeriods: [p1], referenceDate: ref);

      // Cycle starts Jan 1. Next start Jan 29.
      // Ovulation = Jan 29 - 14 = Jan 15.
      expect(prediction.ovulationDay, DateTime(2023, 1, 15));
      expect(prediction.fertileWindowStart, DateTime(2023, 1, 10));
      expect(prediction.fertileWindowEnd, DateTime(2023, 1, 16));
    });
  });
}
