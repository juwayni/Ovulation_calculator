// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'period_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PeriodModel _$PeriodModelFromJson(Map<String, dynamic> json) {
  return _PeriodModel.fromJson(json);
}

/// @nodoc
mixin _$PeriodModel {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  DateTime get startDate => throw _privateConstructorUsedError;
  @HiveField(2)
  DateTime? get endDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PeriodModelCopyWith<PeriodModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PeriodModelCopyWith<$Res> {
  factory $PeriodModelCopyWith(
    PeriodModel value,
    $Res Function(PeriodModel) then,
  ) = _$PeriodModelCopyWithImpl<$Res, PeriodModel>;
  @useResult
  $Res call({
    @HiveField(0) String id,
    @HiveField(1) DateTime startDate,
    @HiveField(2) DateTime? endDate,
  });
}

/// @nodoc
class _$PeriodModelCopyWithImpl<$Res, $Val extends PeriodModel>
    implements $PeriodModelCopyWith<$Res> {
  _$PeriodModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? startDate = null,
    Object? endDate = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PeriodModelImplCopyWith<$Res>
    implements $PeriodModelCopyWith<$Res> {
  factory _$$PeriodModelImplCopyWith(
    _$PeriodModelImpl value,
    $Res Function(_$PeriodModelImpl) then,
  ) = __$$PeriodModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @HiveField(0) String id,
    @HiveField(1) DateTime startDate,
    @HiveField(2) DateTime? endDate,
  });
}

/// @nodoc
class __$$PeriodModelImplCopyWithImpl<$Res>
    extends _$PeriodModelCopyWithImpl<$Res, _$PeriodModelImpl>
    implements _$$PeriodModelImplCopyWith<$Res> {
  __$$PeriodModelImplCopyWithImpl(
    _$PeriodModelImpl _value,
    $Res Function(_$PeriodModelImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? startDate = null,
    Object? endDate = freezed,
  }) {
    return _then(
      _$PeriodModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 0, adapterName: 'PeriodModelAdapter')
class _$PeriodModelImpl implements _PeriodModel {
  const _$PeriodModelImpl({
    @HiveField(0) required this.id,
    @HiveField(1) required this.startDate,
    @HiveField(2) this.endDate,
  });

  factory _$PeriodModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PeriodModelImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final DateTime startDate;
  @override
  @HiveField(2)
  final DateTime? endDate;

  @override
  String toString() {
    return 'PeriodModel(id: $id, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PeriodModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, startDate, endDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PeriodModelImplCopyWith<_$PeriodModelImpl> get copyWith =>
      __$$PeriodModelImplCopyWithImpl<_$PeriodModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PeriodModelImplToJson(this);
  }
}

abstract class _PeriodModel implements PeriodModel {
  const factory _PeriodModel({
    @HiveField(0) required final String id,
    @HiveField(1) required final DateTime startDate,
    @HiveField(2) final DateTime? endDate,
  }) = _$PeriodModelImpl;

  factory _PeriodModel.fromJson(Map<String, dynamic> json) =
      _$PeriodModelImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  DateTime get startDate;
  @override
  @HiveField(2)
  DateTime? get endDate;
  @override
  @JsonKey(ignore: true)
  _$$PeriodModelImplCopyWith<_$PeriodModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
