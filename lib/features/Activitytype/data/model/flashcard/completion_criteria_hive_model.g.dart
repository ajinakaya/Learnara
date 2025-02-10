// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completion_criteria_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompletionCriteriaHiveModelAdapter
    extends TypeAdapter<CompletionCriteriaHiveModel> {
  @override
  final int typeId = 5;

  @override
  CompletionCriteriaHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompletionCriteriaHiveModel(
      cardsReviewed: fields[0] as int,
      minimumCorrect: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CompletionCriteriaHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.cardsReviewed)
      ..writeByte(1)
      ..write(obj.minimumCorrect);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompletionCriteriaHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
