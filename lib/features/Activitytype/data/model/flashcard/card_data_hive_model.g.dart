// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_data_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardDataHiveModelAdapter extends TypeAdapter<CardDataHiveModel> {
  @override
  final int typeId = 4;

  @override
  CardDataHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardDataHiveModel(
      front: fields[0] as String,
      back: fields[1] as String,
      hint: fields[2] as String?,
      example: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CardDataHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.front)
      ..writeByte(1)
      ..write(obj.back)
      ..writeByte(2)
      ..write(obj.hint)
      ..writeByte(3)
      ..write(obj.example);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardDataHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
