import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/period_model.dart';
import '../providers/repository_providers.dart';
import '../../domain/repositories/period_repository.dart';

final periodsProvider = FutureProvider<List<PeriodModel>>((ref) async {
  final repository = ref.watch(periodRepositoryProvider);
  return repository.getPeriods();
});

class PeriodNotifier extends StateNotifier<AsyncValue<void>> {
  final IPeriodRepository _repository;
  final Ref _ref;

  PeriodNotifier(this._repository, this._ref) : super(const AsyncValue.data(null));

  Future<void> addPeriod(PeriodModel period) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.savePeriod(period);
      _ref.invalidate(periodsProvider);
      // currentCycleProvider will be invalidated automatically if it watches periodsProvider
    });
  }
}

final periodActionProvider = StateNotifierProvider<PeriodNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(periodRepositoryProvider);
  return PeriodNotifier(repository, ref);
});
