// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 4;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as String,
      name: fields[1] as String,
      age: fields[2] as int,
      cycleLength: fields[3] as int,
      periodLength: fields[4] as int,
      onboardingCompleted: fields[5] as bool,
      medicalDisclaimerAccepted: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.cycleLength)
      ..writeByte(4)
      ..write(obj.periodLength)
      ..writeByte(5)
      ..write(obj.onboardingCompleted)
      ..writeByte(6)
      ..write(obj.medicalDisclaimerAccepted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
      cycleLength: (json['cycleLength'] as num).toInt(),
      periodLength: (json['periodLength'] as num).toInt(),
      onboardingCompleted: json['onboardingCompleted'] as bool? ?? false,
      medicalDisclaimerAccepted:
          json['medicalDisclaimerAccepted'] as bool? ?? false,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'age': instance.age,
      'cycleLength': instance.cycleLength,
      'periodLength': instance.periodLength,
      'onboardingCompleted': instance.onboardingCompleted,
      'medicalDisclaimerAccepted': instance.medicalDisclaimerAccepted,
    };
