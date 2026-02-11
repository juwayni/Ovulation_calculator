import '../models/temperature_model.dart';

abstract class ITemperatureRepository {
  Future<List<TemperatureModel>> getTemperatures();
  Future<void> saveTemperature(TemperatureModel temperature);
  Future<void> deleteTemperature(DateTime date);
}
