// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symptom_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SymptomModelAdapter extends TypeAdapter<_$SymptomModelImpl> {
  @override
  final int typeId = 2;

  @override
  _$SymptomModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$SymptomModelImpl(
      date: fields[0] as DateTime,
      name: fields[1] as String,
      severity: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, _$SymptomModelImpl obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.severity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SymptomModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SymptomModelImpl _$$SymptomModelImplFromJson(Map<String, dynamic> json) =>
    _$SymptomModelImpl(
      date: DateTime.parse(json['date'] as String),
      name: json['name'] as String,
      severity: (json['severity'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$SymptomModelImplToJson(_$SymptomModelImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'name': instance.name,
      'severity': instance.severity,
    };
