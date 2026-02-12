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
      final sortedPeriods = List<PeriodModel>.from(lastPeriods)
        ..sort((a, b) => b.startDate.compareTo(a.startDate));

      if (sortedPeriods.length >= 2) {
        int totalDays = 0;
        int count = 0;
        for (int i = 0; i < sortedPeriods.length - 1; i++) {
          totalDays += sortedPeriods[i].startDate
              .difference(sortedPeriods[i + 1].startDate)
              .inDays;
          count++;
          if (count >= 3) break;
        }
        avgCycleLength = totalDays ~/ count;
      }

      int totalPeriodDays = 0;
      int periodCount = 0;
      for (var p in sortedPeriods) {
        if (p.endDate != null) {
          totalPeriodDays += p.endDate!.difference(p.startDate).inDays + 1;
          periodCount++;
        } else if (p == sortedPeriods.first) {
          // If current period is ongoing, we don't know the end date yet,
          // but we can use default or last known.
        }
        if (periodCount >= 3) break;
      }
      if (periodCount > 0) {
        avgPeriodLength = totalPeriodDays ~/ periodCount;
      }
    }

    final now = referenceDate ?? DateTime.now();

    // Find the most recent period start date
    DateTime lastStartDate = lastPeriods.isNotEmpty
        ? lastPeriods
              .map((e) => e.startDate)
              .reduce((a, b) => a.isAfter(b) ? a : b)
        : now.subtract(Duration(days: defaultCycleLength));

    // Determine if we are in the current cycle or looking at the next one
    DateTime cycleStartDate = lastStartDate;

    // If the last start date was more than avgCycleLength ago,
    // we should project forward to the "current" cycle.
    while (now.difference(cycleStartDate).inDays >= avgCycleLength) {
      cycleStartDate = cycleStartDate.add(Duration(days: avgCycleLength));
    }

    // If the reference date is BEFORE the last recorded period (unlikely for current status),
    // but let's handle it by going backwards if needed.
    while (now.isBefore(cycleStartDate)) {
      // Only go back if we are trying to find the cycle containing 'now'
      if (now.difference(cycleStartDate).inDays.abs() < avgCycleLength) break;
      cycleStartDate = cycleStartDate.subtract(Duration(days: avgCycleLength));
    }

    final nextStartDate = cycleStartDate.add(Duration(days: avgCycleLength));
    final ovulationDay = nextStartDate.subtract(
      const Duration(days: defaultLutealPhaseLength),
    );

    return CycleEntity(
      startDate: cycleStartDate,
      cycleLength: avgCycleLength,
      periodLength: avgPeriodLength,
      ovulationDay: ovulationDay,
      fertileWindowStart: ovulationDay.subtract(const Duration(days: 5)),
      fertileWindowEnd: ovulationDay.add(const Duration(days: 1)),
      lutealPhaseLength: defaultLutealPhaseLength,
    );
  }
}
