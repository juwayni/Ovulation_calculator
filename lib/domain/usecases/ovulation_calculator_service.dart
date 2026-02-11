import '../entities/cycle_entity.dart';
import '../../data/models/period_model.dart';

class OvulationCalculatorService {
  static const int defaultCycleLength = 28;
  static const int defaultPeriodLength = 5;
  static const int defaultLutealPhaseLength = 14;

  CycleEntity calculatePrediction({
    required List<PeriodModel> lastPeriods,
    DateTime? referenceDate,
  }) {
    int avgCycleLength = defaultCycleLength;
    int avgPeriodLength = defaultPeriodLength;

    if (lastPeriods.isNotEmpty) {
      // Sort periods by date
      final sortedPeriods = List<PeriodModel>.from(lastPeriods)
        ..sort((a, b) => b.startDate.compareTo(a.startDate));

      if (sortedPeriods.length >= 2) {
        int totalDays = 0;
        int count = 0;
        for (int i = 0; i < sortedPeriods.length - 1; i++) {
          totalDays += sortedPeriods[i].startDate.difference(sortedPeriods[i + 1].startDate).inDays;
          count++;
          if (count >= 3) break; // Use last 3 cycles as per requirement
        }
        avgCycleLength = totalDays ~/ count;
      }

      // Calculate avg period length
      int totalPeriodDays = 0;
      int periodCount = 0;
      for (var p in sortedPeriods) {
        if (p.endDate != null) {
          totalPeriodDays += p.endDate!.difference(p.startDate).inDays + 1;
          periodCount++;
        }
        if (periodCount >= 3) break;
      }
      if (periodCount > 0) {
        avgPeriodLength = totalPeriodDays ~/ periodCount;
      }
    }

    final lastStartDate = lastPeriods.isNotEmpty
        ? lastPeriods.map((e) => e.startDate).reduce((a, b) => a.isAfter(b) ? a : b)
        : referenceDate ?? DateTime.now();

    final nextStartDate = lastStartDate.add(Duration(days: avgCycleLength));
    final ovulationDay = nextStartDate.subtract(const Duration(days: defaultLutealPhaseLength));

    return CycleEntity(
      startDate: nextStartDate,
      cycleLength: avgCycleLength,
      periodLength: avgPeriodLength,
      ovulationDay: ovulationDay,
      fertileWindowStart: ovulationDay.subtract(const Duration(days: 5)),
      fertileWindowEnd: ovulationDay.add(const Duration(days: 1)),
      lutealPhaseLength: defaultLutealPhaseLength,
    );
  }
}
