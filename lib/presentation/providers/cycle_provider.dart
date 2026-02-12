import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/cycle_entity.dart';
import '../../domain/usecases/ovulation_calculator_service.dart';
import 'period_provider.dart';

final ovulationCalculatorProvider = Provider(
  (ref) => OvulationCalculatorService(),
);

final currentCycleProvider = FutureProvider<CycleEntity>((ref) async {
  final periodsAsync = ref.watch(periodsProvider);
  final calculator = ref.watch(ovulationCalculatorProvider);

  final periods = periodsAsync.value ?? [];
  return calculator.calculatePrediction(lastPeriods: periods);
});
