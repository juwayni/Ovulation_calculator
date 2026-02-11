import '../../data/models/period_model.dart';

abstract class IPeriodRepository {
  Future<List<PeriodModel>> getPeriods();
  Future<void> savePeriod(PeriodModel period);
  Future<void> deletePeriod(String id);
}
