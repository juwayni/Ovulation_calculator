import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'symptom_model.freezed.dart';
part 'symptom_model.g.dart';

@freezed
class SymptomModel with _$SymptomModel {
  @HiveType(typeId: 2, adapterName: 'SymptomModelAdapter')
  const factory SymptomModel({
    @HiveField(0) required DateTime date,
    @HiveField(1) required String name,
    @HiveField(2) @Default(1) int severity, // 1: Mild, 2: Moderate, 3: Severe
  }) = _SymptomModel;

  factory SymptomModel.fromJson(Map<String, dynamic> json) => _$SymptomModelFromJson(json);
}
