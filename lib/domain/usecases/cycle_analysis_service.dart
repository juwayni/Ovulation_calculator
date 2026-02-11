import '../entities/cycle_entity.dart';
import '../../data/models/period_model.dart';
import 'ovulation_calculator_service.dart';

class CycleAnalysisService {
  final OvulationCalculatorService _calculator = OvulationCalculatorService();

  Map<String, dynamic> analyzeLastCycles(List<PeriodModel> periods) {
    if (periods.isEmpty) return {};

    final sorted = List<PeriodModel>.from(periods)
      ..sort((a, b) => b.startDate.compareTo(a.startDate));

    final currentPeriod = sorted[0];
    PeriodModel? lastPeriod;
    if (sorted.length > 1) {
      lastPeriod = sorted[1];
    }

    // This is a simplified analysis for the UI
    return {
      'currentCycle': _calculateCycleForPeriod(currentPeriod, sorted),
      'lastCycle': lastPeriod != null ? _calculateCycleForPeriod(lastPeriod, sorted) : null,
    };
  }

  CycleEntity _calculateCycleForPeriod(PeriodModel period, List<PeriodModel> allPeriods) {
    // Find next period to determine actual cycle length if available
    final sorted = List<PeriodModel>.from(allPeriods)
      ..sort((a, b) => a.startDate.compareTo(b.startDate));

    final index = sorted.indexOf(period);
    int cycleLength = 28;
    if (index < sorted.length - 1) {
      cycleLength = sorted[index + 1].startDate.difference(period.startDate).inDays;
    }

    final periodLength = period.endDate != null
        ? period.endDate!.difference(period.startDate).inDays + 1
        : 5;

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
