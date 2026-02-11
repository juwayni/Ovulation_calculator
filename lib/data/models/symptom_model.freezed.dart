// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'symptom_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SymptomModel _$SymptomModelFromJson(Map<String, dynamic> json) {
  return _SymptomModel.fromJson(json);
}

/// @nodoc
mixin _$SymptomModel {
  @HiveField(0)
  DateTime get date => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  int get severity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SymptomModelCopyWith<SymptomModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SymptomModelCopyWith<$Res> {
  factory $SymptomModelCopyWith(
          SymptomModel value, $Res Function(SymptomModel) then) =
      _$SymptomModelCopyWithImpl<$Res, SymptomModel>;
  @useResult
  $Res call(
      {@HiveField(0) DateTime date,
      @HiveField(1) String name,
      @HiveField(2) int severity});
}

/// @nodoc
class _$SymptomModelCopyWithImpl<$Res, $Val extends SymptomModel>
    implements $SymptomModelCopyWith<$Res> {
  _$SymptomModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? name = null,
    Object? severity = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SymptomModelImplCopyWith<$Res>
    implements $SymptomModelCopyWith<$Res> {
  factory _$$SymptomModelImplCopyWith(
          _$SymptomModelImpl value, $Res Function(_$SymptomModelImpl) then) =
      __$$SymptomModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) DateTime date,
      @HiveField(1) String name,
      @HiveField(2) int severity});
}

/// @nodoc
class __$$SymptomModelImplCopyWithImpl<$Res>
    extends _$SymptomModelCopyWithImpl<$Res, _$SymptomModelImpl>
    implements _$$SymptomModelImplCopyWith<$Res> {
  __$$SymptomModelImplCopyWithImpl(
      _$SymptomModelImpl _value, $Res Function(_$SymptomModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? name = null,
    Object? severity = null,
  }) {
    return _then(_$SymptomModelImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 2, adapterName: 'SymptomModelAdapter')
class _$SymptomModelImpl implements _SymptomModel {
  const _$SymptomModelImpl(
      {@HiveField(0) required this.date,
      @HiveField(1) required this.name,
      @HiveField(2) this.severity = 1});

  factory _$SymptomModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SymptomModelImplFromJson(json);

  @override
  @HiveField(0)
  final DateTime date;
  @override
  @HiveField(1)
  final String name;
  @override
  @JsonKey()
  @HiveField(2)
  final int severity;

  @override
  String toString() {
    return 'SymptomModel(date: $date, name: $name, severity: $severity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SymptomModelImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.severity, severity) ||
                other.severity == severity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, date, name, severity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SymptomModelImplCopyWith<_$SymptomModelImpl> get copyWith =>
      __$$SymptomModelImplCopyWithImpl<_$SymptomModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SymptomModelImplToJson(
      this,
    );
  }
}

abstract class _SymptomModel implements SymptomModel {
  const factory _SymptomModel(
      {@HiveField(0) required final DateTime date,
      @HiveField(1) required final String name,
      @HiveField(2) final int severity}) = _$SymptomModelImpl;

  factory _SymptomModel.fromJson(Map<String, dynamic> json) =
      _$SymptomModelImpl.fromJson;

  @override
  @HiveField(0)
  DateTime get date;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  int get severity;
  @override
  @JsonKey(ignore: true)
  _$$SymptomModelImplCopyWith<_$SymptomModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
