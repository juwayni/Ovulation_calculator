import 'package:freezed_annotation/freezed_annotation.dart';

part 'cycle_entity.freezed.dart';

@freezed
class CycleEntity with _$CycleEntity {
  const factory CycleEntity({
    required DateTime startDate,
    required int cycleLength,
    required int periodLength,
    required DateTime ovulationDay,
    required DateTime fertileWindowStart,
    required DateTime fertileWindowEnd,
    @Default(14) int lutealPhaseLength,
  }) = _CycleEntity;
}
