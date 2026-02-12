import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'period_model.freezed.dart';
part 'period_model.g.dart';

@freezed
class PeriodModel with _$PeriodModel {
  @HiveType(typeId: 0, adapterName: 'PeriodModelAdapter')
  const factory PeriodModel({
    @HiveField(0) required String id,
    @HiveField(1) required DateTime startDate,
    @HiveField(2) DateTime? endDate,
  }) = _PeriodModel;

  factory PeriodModel.fromJson(Map<String, dynamic> json) =>
      _$PeriodModelFromJson(json);
}
