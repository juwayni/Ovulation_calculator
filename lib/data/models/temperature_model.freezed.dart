// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'temperature_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TemperatureModel _$TemperatureModelFromJson(Map<String, dynamic> json) {
  return _TemperatureModel.fromJson(json);
}

/// @nodoc
mixin _$TemperatureModel {
  @HiveField(0)
  DateTime get date => throw _privateConstructorUsedError;
  @HiveField(1)
  double get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TemperatureModelCopyWith<TemperatureModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TemperatureModelCopyWith<$Res> {
  factory $TemperatureModelCopyWith(
          TemperatureModel value, $Res Function(TemperatureModel) then) =
      _$TemperatureModelCopyWithImpl<$Res, TemperatureModel>;
  @useResult
  $Res call({@HiveField(0) DateTime date, @HiveField(1) double value});
}

/// @nodoc
class _$TemperatureModelCopyWithImpl<$Res, $Val extends TemperatureModel>
    implements $TemperatureModelCopyWith<$Res> {
  _$TemperatureModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TemperatureModelImplCopyWith<$Res>
    implements $TemperatureModelCopyWith<$Res> {
  factory _$$TemperatureModelImplCopyWith(_$TemperatureModelImpl value,
          $Res Function(_$TemperatureModelImpl) then) =
      __$$TemperatureModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@HiveField(0) DateTime date, @HiveField(1) double value});
}

/// @nodoc
class __$$TemperatureModelImplCopyWithImpl<$Res>
    extends _$TemperatureModelCopyWithImpl<$Res, _$TemperatureModelImpl>
    implements _$$TemperatureModelImplCopyWith<$Res> {
  __$$TemperatureModelImplCopyWithImpl(_$TemperatureModelImpl _value,
      $Res Function(_$TemperatureModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? value = null,
  }) {
    return _then(_$TemperatureModelImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 1, adapterName: 'TemperatureModelAdapter')
class _$TemperatureModelImpl implements _TemperatureModel {
  const _$TemperatureModelImpl(
      {@HiveField(0) required this.date, @HiveField(1) required this.value});

  factory _$TemperatureModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TemperatureModelImplFromJson(json);

  @override
  @HiveField(0)
  final DateTime date;
  @override
  @HiveField(1)
  final double value;

  @override
  String toString() {
    return 'TemperatureModel(date: $date, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TemperatureModelImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, date, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TemperatureModelImplCopyWith<_$TemperatureModelImpl> get copyWith =>
      __$$TemperatureModelImplCopyWithImpl<_$TemperatureModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TemperatureModelImplToJson(
      this,
    );
  }
}

abstract class _TemperatureModel implements TemperatureModel {
  const factory _TemperatureModel(
      {@HiveField(0) required final DateTime date,
      @HiveField(1) required final double value}) = _$TemperatureModelImpl;

  factory _TemperatureModel.fromJson(Map<String, dynamic> json) =
      _$TemperatureModelImpl.fromJson;

  @override
  @HiveField(0)
  DateTime get date;
  @override
  @HiveField(1)
  double get value;
  @override
  @JsonKey(ignore: true)
  _$$TemperatureModelImplCopyWith<_$TemperatureModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
