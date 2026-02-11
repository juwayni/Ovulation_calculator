import 'package:hive/hive.dart';
import '../../domain/repositories/temperature_repository.dart';
import '../models/temperature_model.dart';

class HiveTemperatureRepository implements ITemperatureRepository {
  static const String boxName = 'temperatures';

  Future<Box<TemperatureModel>> _getBox() async {
    return await Hive.openBox<TemperatureModel>(boxName);
  }

  @override
  Future<List<TemperatureModel>> getTemperatures() async {
    final box = await _getBox();
    return box.values.toList();
  }

  @override
  Future<void> saveTemperature(TemperatureModel temperature) async {
    final box = await _getBox();
    await box.put(temperature.date.toIso8601String(), temperature);
  }

  @override
  Future<void> deleteTemperature(DateTime date) async {
    final box = await _getBox();
    await box.delete(date.toIso8601String());
  }
}
