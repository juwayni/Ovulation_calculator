import 'package:flutter_test/flutter_test.dart';
import 'package:ovulation_calculator/domain/usecases/ovulation_calculator_service.dart';
import 'package:ovulation_calculator/data/models/period_model.dart';

void main() {
  late OvulationCalculatorService service;

  setUp(() {
    service = OvulationCalculatorService();
  });

  group('OvulationCalculatorService Tests', () {
    test('calculatePrediction returns default for no periods', () {
      final now = DateTime(2023, 1, 1);
      final prediction = service.calculatePrediction(lastPeriods: [], referenceDate: now);

      expect(prediction.cycleLength, 28);
      expect(prediction.startDate, now.add(const Duration(days: 28)));
    });

    test('calculatePrediction adapts to average cycle length', () {
      final p1 = PeriodModel(id: '1', startDate: DateTime(2023, 1, 1));
      final p2 = PeriodModel(id: '2', startDate: DateTime(2023, 1, 31)); // 30 days diff

      final prediction = service.calculatePrediction(lastPeriods: [p1, p2]);

      expect(prediction.cycleLength, 30);
      expect(prediction.startDate, p2.startDate.add(const Duration(days: 30)));
    });

    test('fertile window calculation is correct', () {
      final p1 = PeriodModel(id: '1', startDate: DateTime(2023, 1, 1));
      final prediction = service.calculatePrediction(lastPeriods: [p1]);

      // Default cycle 28, next start 2023-01-29
      // Ovulation = 2023-01-29 - 14 = 2023-01-15
      expect(prediction.ovulationDay, DateTime(2023, 1, 15));
      expect(prediction.fertileWindowStart, DateTime(2023, 1, 10));
      expect(prediction.fertileWindowEnd, DateTime(2023, 1, 16));
    });
   group('Confidence Calculator Tests', () {
      // I'll add them here or in a separate file if needed
    });
  });
}
