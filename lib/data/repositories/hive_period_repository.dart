import 'package:hive/hive.dart';
import '../../domain/repositories/period_repository.dart';
import '../models/period_model.dart';

class HivePeriodRepository implements IPeriodRepository {
  static const String boxName = 'periods';

  Future<Box<PeriodModel>> _getBox() async {
    return await Hive.openBox<PeriodModel>(boxName);
  }

  @override
  Future<List<PeriodModel>> getPeriods() async {
    final box = await _getBox();
    return box.values.toList();
  }

  @override
  Future<void> savePeriod(PeriodModel period) async {
    final box = await _getBox();
    await box.put(period.id, period);
  }

  @override
  Future<void> deletePeriod(String id) async {
    final box = await _getBox();
    await box.delete(id);
  }
}
