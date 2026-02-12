// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  int get age => throw _privateConstructorUsedError;
  @HiveField(3)
  int get cycleLength => throw _privateConstructorUsedError;
  @HiveField(4)
  int get periodLength => throw _privateConstructorUsedError;
  @HiveField(5)
  bool get onboardingCompleted => throw _privateConstructorUsedError;
  @HiveField(6)
  bool get medicalDisclaimerAccepted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call({
    @HiveField(0) String id,
    @HiveField(1) String name,
    @HiveField(2) int age,
    @HiveField(3) int cycleLength,
    @HiveField(4) int periodLength,
    @HiveField(5) bool onboardingCompleted,
    @HiveField(6) bool medicalDisclaimerAccepted,
  });
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? age = null,
    Object? cycleLength = null,
    Object? periodLength = null,
    Object? onboardingCompleted = null,
    Object? medicalDisclaimerAccepted = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            age: null == age
                ? _value.age
                : age // ignore: cast_nullable_to_non_nullable
                      as int,
            cycleLength: null == cycleLength
                ? _value.cycleLength
                : cycleLength // ignore: cast_nullable_to_non_nullable
                      as int,
            periodLength: null == periodLength
                ? _value.periodLength
                : periodLength // ignore: cast_nullable_to_non_nullable
                      as int,
            onboardingCompleted: null == onboardingCompleted
                ? _value.onboardingCompleted
                : onboardingCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            medicalDisclaimerAccepted: null == medicalDisclaimerAccepted
                ? _value.medicalDisclaimerAccepted
                : medicalDisclaimerAccepted // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
    _$UserModelImpl value,
    $Res Function(_$UserModelImpl) then,
  ) = __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @HiveField(0) String id,
    @HiveField(1) String name,
    @HiveField(2) int age,
    @HiveField(3) int cycleLength,
    @HiveField(4) int periodLength,
    @HiveField(5) bool onboardingCompleted,
    @HiveField(6) bool medicalDisclaimerAccepted,
  });
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
    _$UserModelImpl _value,
    $Res Function(_$UserModelImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? age = null,
    Object? cycleLength = null,
    Object? periodLength = null,
    Object? onboardingCompleted = null,
    Object? medicalDisclaimerAccepted = null,
  }) {
    return _then(
      _$UserModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        age: null == age
            ? _value.age
            : age // ignore: cast_nullable_to_non_nullable
                  as int,
        cycleLength: null == cycleLength
            ? _value.cycleLength
            : cycleLength // ignore: cast_nullable_to_non_nullable
                  as int,
        periodLength: null == periodLength
            ? _value.periodLength
            : periodLength // ignore: cast_nullable_to_non_nullable
                  as int,
        onboardingCompleted: null == onboardingCompleted
            ? _value.onboardingCompleted
            : onboardingCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        medicalDisclaimerAccepted: null == medicalDisclaimerAccepted
            ? _value.medicalDisclaimerAccepted
            : medicalDisclaimerAccepted // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl({
    @HiveField(0) required this.id,
    @HiveField(1) required this.name,
    @HiveField(2) required this.age,
    @HiveField(3) required this.cycleLength,
    @HiveField(4) required this.periodLength,
    @HiveField(5) this.onboardingCompleted = false,
    @HiveField(6) this.medicalDisclaimerAccepted = false,
  });

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final int age;
  @override
  @HiveField(3)
  final int cycleLength;
  @override
  @HiveField(4)
  final int periodLength;
  @override
  @JsonKey()
  @HiveField(5)
  final bool onboardingCompleted;
  @override
  @JsonKey()
  @HiveField(6)
  final bool medicalDisclaimerAccepted;

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, age: $age, cycleLength: $cycleLength, periodLength: $periodLength, onboardingCompleted: $onboardingCompleted, medicalDisclaimerAccepted: $medicalDisclaimerAccepted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.cycleLength, cycleLength) ||
                other.cycleLength == cycleLength) &&
            (identical(other.periodLength, periodLength) ||
                other.periodLength == periodLength) &&
            (identical(other.onboardingCompleted, onboardingCompleted) ||
                other.onboardingCompleted == onboardingCompleted) &&
            (identical(
                  other.medicalDisclaimerAccepted,
                  medicalDisclaimerAccepted,
                ) ||
                other.medicalDisclaimerAccepted == medicalDisclaimerAccepted));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    age,
    cycleLength,
    periodLength,
    onboardingCompleted,
    medicalDisclaimerAccepted,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(this);
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel({
    @HiveField(0) required final String id,
    @HiveField(1) required final String name,
    @HiveField(2) required final int age,
    @HiveField(3) required final int cycleLength,
    @HiveField(4) required final int periodLength,
    @HiveField(5) final bool onboardingCompleted,
    @HiveField(6) final bool medicalDisclaimerAccepted,
  }) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  int get age;
  @override
  @HiveField(3)
  int get cycleLength;
  @override
  @HiveField(4)
  int get periodLength;
  @override
  @HiveField(5)
  bool get onboardingCompleted;
  @override
  @HiveField(6)
  bool get medicalDisclaimerAccepted;
  @override
  @JsonKey(ignore: true)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
