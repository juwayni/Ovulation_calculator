import 'package:flutter_test/flutter_test.dart';
import 'package:ovulation_calculator/domain/usecases/prediction_confidence_calculator.dart';
import 'package:ovulation_calculator/data/models/period_model.dart';

void main() {
  late PredictionConfidenceCalculator calculator;

  setUp(() {
    calculator = PredictionConfidenceCalculator();
  });

  test('Confidence is low for few data points', () {
    final confidence = calculator.calculateConfidence([]);
    expect(confidence, 0.5);
  });

  test('Confidence increases with more regular data', () {
    final p1 = PeriodModel(id: '1', startDate: DateTime(2023, 1, 1));
    final p2 = PeriodModel(id: '2', startDate: DateTime(2023, 1, 29)); // 28 days
    final p3 = PeriodModel(id: '3', startDate: DateTime(2023, 2, 26)); // 28 days
    final p4 = PeriodModel(id: '4', startDate: DateTime(2023, 3, 26)); // 28 days
    final p5 = PeriodModel(id: '5', startDate: DateTime(2023, 4, 23)); // 28 days
    final p6 = PeriodModel(id: '6', startDate: DateTime(2023, 5, 21)); // 28 days

    final confidence = calculator.calculateConfidence([p1, p2, p3, p4, p5, p6]);
    expect(confidence, greaterThan(0.8));
  });
}
