// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cycle_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CycleEntity {
  DateTime get startDate => throw _privateConstructorUsedError;
  int get cycleLength => throw _privateConstructorUsedError;
  int get periodLength => throw _privateConstructorUsedError;
  DateTime get ovulationDay => throw _privateConstructorUsedError;
  DateTime get fertileWindowStart => throw _privateConstructorUsedError;
  DateTime get fertileWindowEnd => throw _privateConstructorUsedError;
  int get lutealPhaseLength => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CycleEntityCopyWith<CycleEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CycleEntityCopyWith<$Res> {
  factory $CycleEntityCopyWith(
    CycleEntity value,
    $Res Function(CycleEntity) then,
  ) = _$CycleEntityCopyWithImpl<$Res, CycleEntity>;
  @useResult
  $Res call({
    DateTime startDate,
    int cycleLength,
    int periodLength,
    DateTime ovulationDay,
    DateTime fertileWindowStart,
    DateTime fertileWindowEnd,
    int lutealPhaseLength,
  });
}

/// @nodoc
class _$CycleEntityCopyWithImpl<$Res, $Val extends CycleEntity>
    implements $CycleEntityCopyWith<$Res> {
  _$CycleEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = null,
    Object? cycleLength = null,
    Object? periodLength = null,
    Object? ovulationDay = null,
    Object? fertileWindowStart = null,
    Object? fertileWindowEnd = null,
    Object? lutealPhaseLength = null,
  }) {
    return _then(
      _value.copyWith(
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            cycleLength: null == cycleLength
                ? _value.cycleLength
                : cycleLength // ignore: cast_nullable_to_non_nullable
                      as int,
            periodLength: null == periodLength
                ? _value.periodLength
                : periodLength // ignore: cast_nullable_to_non_nullable
                      as int,
            ovulationDay: null == ovulationDay
                ? _value.ovulationDay
                : ovulationDay // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            fertileWindowStart: null == fertileWindowStart
                ? _value.fertileWindowStart
                : fertileWindowStart // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            fertileWindowEnd: null == fertileWindowEnd
                ? _value.fertileWindowEnd
                : fertileWindowEnd // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            lutealPhaseLength: null == lutealPhaseLength
                ? _value.lutealPhaseLength
                : lutealPhaseLength // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CycleEntityImplCopyWith<$Res>
    implements $CycleEntityCopyWith<$Res> {
  factory _$$CycleEntityImplCopyWith(
    _$CycleEntityImpl value,
    $Res Function(_$CycleEntityImpl) then,
  ) = __$$CycleEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime startDate,
    int cycleLength,
    int periodLength,
    DateTime ovulationDay,
    DateTime fertileWindowStart,
    DateTime fertileWindowEnd,
    int lutealPhaseLength,
  });
}

/// @nodoc
class __$$CycleEntityImplCopyWithImpl<$Res>
    extends _$CycleEntityCopyWithImpl<$Res, _$CycleEntityImpl>
    implements _$$CycleEntityImplCopyWith<$Res> {
  __$$CycleEntityImplCopyWithImpl(
    _$CycleEntityImpl _value,
    $Res Function(_$CycleEntityImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = null,
    Object? cycleLength = null,
    Object? periodLength = null,
    Object? ovulationDay = null,
    Object? fertileWindowStart = null,
    Object? fertileWindowEnd = null,
    Object? lutealPhaseLength = null,
  }) {
    return _then(
      _$CycleEntityImpl(
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        cycleLength: null == cycleLength
            ? _value.cycleLength
            : cycleLength // ignore: cast_nullable_to_non_nullable
                  as int,
        periodLength: null == periodLength
            ? _value.periodLength
            : periodLength // ignore: cast_nullable_to_non_nullable
                  as int,
        ovulationDay: null == ovulationDay
            ? _value.ovulationDay
            : ovulationDay // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        fertileWindowStart: null == fertileWindowStart
            ? _value.fertileWindowStart
            : fertileWindowStart // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        fertileWindowEnd: null == fertileWindowEnd
            ? _value.fertileWindowEnd
            : fertileWindowEnd // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        lutealPhaseLength: null == lutealPhaseLength
            ? _value.lutealPhaseLength
            : lutealPhaseLength // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$CycleEntityImpl implements _CycleEntity {
  const _$CycleEntityImpl({
    required this.startDate,
    required this.cycleLength,
    required this.periodLength,
    required this.ovulationDay,
    required this.fertileWindowStart,
    required this.fertileWindowEnd,
    this.lutealPhaseLength = 14,
  });

  @override
  final DateTime startDate;
  @override
  final int cycleLength;
  @override
  final int periodLength;
  @override
  final DateTime ovulationDay;
  @override
  final DateTime fertileWindowStart;
  @override
  final DateTime fertileWindowEnd;
  @override
  @JsonKey()
  final int lutealPhaseLength;

  @override
  String toString() {
    return 'CycleEntity(startDate: $startDate, cycleLength: $cycleLength, periodLength: $periodLength, ovulationDay: $ovulationDay, fertileWindowStart: $fertileWindowStart, fertileWindowEnd: $fertileWindowEnd, lutealPhaseLength: $lutealPhaseLength)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CycleEntityImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.cycleLength, cycleLength) ||
                other.cycleLength == cycleLength) &&
            (identical(other.periodLength, periodLength) ||
                other.periodLength == periodLength) &&
            (identical(other.ovulationDay, ovulationDay) ||
                other.ovulationDay == ovulationDay) &&
            (identical(other.fertileWindowStart, fertileWindowStart) ||
                other.fertileWindowStart == fertileWindowStart) &&
            (identical(other.fertileWindowEnd, fertileWindowEnd) ||
                other.fertileWindowEnd == fertileWindowEnd) &&
            (identical(other.lutealPhaseLength, lutealPhaseLength) ||
                other.lutealPhaseLength == lutealPhaseLength));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    startDate,
    cycleLength,
    periodLength,
    ovulationDay,
    fertileWindowStart,
    fertileWindowEnd,
    lutealPhaseLength,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CycleEntityImplCopyWith<_$CycleEntityImpl> get copyWith =>
      __$$CycleEntityImplCopyWithImpl<_$CycleEntityImpl>(this, _$identity);
}

abstract class _CycleEntity implements CycleEntity {
  const factory _CycleEntity({
    required final DateTime startDate,
    required final int cycleLength,
    required final int periodLength,
    required final DateTime ovulationDay,
    required final DateTime fertileWindowStart,
    required final DateTime fertileWindowEnd,
    final int lutealPhaseLength,
  }) = _$CycleEntityImpl;

  @override
  DateTime get startDate;
  @override
  int get cycleLength;
  @override
  int get periodLength;
  @override
  DateTime get ovulationDay;
  @override
  DateTime get fertileWindowStart;
  @override
  DateTime get fertileWindowEnd;
  @override
  int get lutealPhaseLength;
  @override
  @JsonKey(ignore: true)
  _$$CycleEntityImplCopyWith<_$CycleEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
