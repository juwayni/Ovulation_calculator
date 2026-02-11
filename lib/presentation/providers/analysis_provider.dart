import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/cycle_analysis_service.dart';
import 'period_provider.dart';

final cycleAnalysisServiceProvider = Provider((ref) => CycleAnalysisService());

final cycleAnalysisProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final periodsAsync = ref.watch(periodsProvider);
  final service = ref.watch(cycleAnalysisServiceProvider);

  final periods = periodsAsync.value ?? [];
  return service.analyzeLastCycles(periods);
});
