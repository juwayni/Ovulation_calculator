// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temperature_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TemperatureModelAdapter extends TypeAdapter<_$TemperatureModelImpl> {
  @override
  final int typeId = 1;

  @override
  _$TemperatureModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$TemperatureModelImpl(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      value: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, _$TemperatureModelImpl obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TemperatureModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TemperatureModelImpl _$$TemperatureModelImplFromJson(
  Map<String, dynamic> json,
) => _$TemperatureModelImpl(
  id: json['id'] as String,
  date: DateTime.parse(json['date'] as String),
  value: (json['value'] as num).toDouble(),
);

Map<String, dynamic> _$$TemperatureModelImplToJson(
  _$TemperatureModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'date': instance.date.toIso8601String(),
  'value': instance.value,
};
