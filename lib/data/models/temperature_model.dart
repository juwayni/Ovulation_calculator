import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'temperature_model.freezed.dart';
part 'temperature_model.g.dart';

@freezed
class TemperatureModel with _$TemperatureModel {
  @HiveType(typeId: 1, adapterName: 'TemperatureModelAdapter')
  const factory TemperatureModel({
    @HiveField(0) required String id,
    @HiveField(1) required DateTime date,
    @HiveField(2) required double value,
  }) = _TemperatureModel;

  factory TemperatureModel.fromJson(Map<String, dynamic> json) =>
      _$TemperatureModelFromJson(json);
}
