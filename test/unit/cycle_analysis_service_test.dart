import 'package:flutter_test/flutter_test.dart';
import 'package:ovulation_calculator/domain/usecases/cycle_analysis_service.dart';
import 'package:ovulation_calculator/data/models/period_model.dart';

void main() {
  late CycleAnalysisService service;

  setUp(() {
    service = CycleAnalysisService();
  });

  group('CycleAnalysisService Stats Tests', () {
    test('calculateAverages returns defaults for empty list', () {
      final stats = service.calculateAverages([]);
      expect(stats['avgCycleLength'], 28.0);
      expect(stats['avgPeriodLength'], 5.0);
      expect(stats['regularity'], 1.0);
    });

    test(
      'calculateAverages calculates correct averages for regular cycles',
      () {
        final periods = [
          PeriodModel(
            id: '1',
            startDate: DateTime(2023, 1, 1),
            endDate: DateTime(2023, 1, 5),
          ),
          PeriodModel(
            id: '2',
            startDate: DateTime(2023, 1, 29),
            endDate: DateTime(2023, 2, 2),
          ), // 28 days cycle
          PeriodModel(
            id: '3',
            startDate: DateTime(2023, 2, 26),
            endDate: DateTime(2023, 3, 2),
          ), // 28 days cycle
        ];

        final stats = service.calculateAverages(periods);
        expect(stats['avgCycleLength'], 28.0);
        expect(stats['avgPeriodLength'], 5.0);
        expect(stats['regularity'], 1.0);
      },
    );

    test('calculateAverages detects irregularity', () {
      final periods = [
        PeriodModel(
          id: '1',
          startDate: DateTime(2023, 1, 1),
          endDate: DateTime(2023, 1, 5),
        ),
        PeriodModel(
          id: '2',
          startDate: DateTime(2023, 1, 26),
          endDate: DateTime(2023, 1, 30),
        ), // 25 days
        PeriodModel(
          id: '3',
          startDate: DateTime(2023, 2, 26),
          endDate: DateTime(2023, 3, 2),
        ), // 31 days
      ];

      final stats = service.calculateAverages(periods);
      expect(stats['avgCycleLength'], 28.0);
      expect(stats['regularity'], lessThan(1.0));
    });
  });
}
