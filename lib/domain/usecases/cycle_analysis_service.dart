import 'dart:math';
import '../entities/cycle_entity.dart';
import '../../data/models/period_model.dart';

class CycleAnalysisService {
  Map<String, dynamic> analyzeLastCycles(List<PeriodModel> periods) {
    if (periods.isEmpty) return {};

    final sorted = List<PeriodModel>.from(periods)
      ..sort((a, b) => b.startDate.compareTo(a.startDate));

    final currentPeriod = sorted[0];
    PeriodModel? lastPeriod;
    if (sorted.length > 1) {
      lastPeriod = sorted[1];
    }

    final averages = calculateAverages(periods);

    return {
      'currentCycle': _calculateCycleForPeriod(currentPeriod, sorted),
      'lastCycle': lastPeriod != null
          ? _calculateCycleForPeriod(lastPeriod, sorted)
          : null,
      'stats': averages,
      'history': _calculateHistory(sorted),
    };
  }

  Map<String, dynamic> calculateAverages(List<PeriodModel> periods) {
    if (periods.length < 2) {
      return {
        'avgCycleLength': 28.0,
        'avgPeriodLength': periods.isNotEmpty
            ? _getPeriodLength(periods.first).toDouble()
            : 5.0,
        'regularity': 1.0, // 1.0 = Very regular, 0.0 = Irregular
      };
    }

    final sorted = List<PeriodModel>.from(periods)
      ..sort((a, b) => a.startDate.compareTo(b.startDate));

    List<int> cycleLengths = [];
    List<int> periodLengths = [];

    for (int i = 0; i < sorted.length; i++) {
      periodLengths.add(_getPeriodLength(sorted[i]));
      if (i < sorted.length - 1) {
        cycleLengths.add(
          sorted[i + 1].startDate.difference(sorted[i].startDate).inDays,
        );
      }
    }

    double avgCycle = cycleLengths.isNotEmpty
        ? cycleLengths.reduce((a, b) => a + b) / cycleLengths.length
        : 28.0;

    double avgPeriod = periodLengths.isNotEmpty
        ? periodLengths.reduce((a, b) => a + b) / periodLengths.length
        : 5.0;

    // Regularity calculation (Standard Deviation)
    double regularity = 1.0;
    if (cycleLengths.length >= 2) {
      double sumOfSquaredDiffs = cycleLengths
          .map((l) => pow(l - avgCycle, 2))
          .reduce((a, b) => a + b)
          .toDouble();
      double stdDev = sqrt(sumOfSquaredDiffs / cycleLengths.length);

      // Map stdDev to a 0-1 scale where 0 is > 5 days variation
      regularity = max(0.0, 1.0 - (stdDev / 5.0));
    }

    return {
      'avgCycleLength': avgCycle,
      'avgPeriodLength': avgPeriod,
      'regularity': regularity,
      'cycleCount': periods.length,
    };
  }

  List<CycleEntity> _calculateHistory(List<PeriodModel> sortedPeriods) {
    List<CycleEntity> history = [];
    // From oldest to newest for the list
    final chronological = sortedPeriods.reversed.toList();
    for (var p in chronological) {
      history.add(_calculateCycleForPeriod(p, sortedPeriods));
    }
    return history.reversed.toList();
  }

  int _getPeriodLength(PeriodModel period) {
    if (period.endDate == null) return 5;
    return period.endDate!.difference(period.startDate).inDays + 1;
  }

  CycleEntity _calculateCycleForPeriod(
    PeriodModel period,
    List<PeriodModel> allPeriods,
  ) {
    final sorted = List<PeriodModel>.from(allPeriods)
      ..sort((a, b) => a.startDate.compareTo(b.startDate));

    final index = sorted.indexOf(period);
    int cycleLength = 28;
    if (index < sorted.length - 1) {
      cycleLength = sorted[index + 1].startDate
          .difference(period.startDate)
          .inDays;
    }

    final periodLength = _getPeriodLength(period);
    final ovulationDay = period.startDate.add(Duration(days: cycleLength - 14));

    return CycleEntity(
      startDate: period.startDate,
      cycleLength: cycleLength,
      periodLength: periodLength,
      ovulationDay: ovulationDay,
      fertileWindowStart: ovulationDay.subtract(const Duration(days: 5)),
      fertileWindowEnd: ovulationDay.add(const Duration(days: 1)),
    );
  }
}
