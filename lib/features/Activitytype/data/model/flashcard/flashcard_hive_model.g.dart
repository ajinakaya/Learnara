// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcard_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FlashcardHiveModelAdapter extends TypeAdapter<FlashcardHiveModel> {
  @override
  final int typeId = 3;

  @override
  FlashcardHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FlashcardHiveModel(
      flashcardId: fields[0] as String?,
      language: fields[1] as PreferredLanguageEntity,
      title: fields[2] as String,
      description: fields[3] as String,
      cards: (fields[4] as List).cast<CardDataHiveModel>(),
      difficulty: fields[5] as String,
      order: fields[6] as int,
      completionCriteria: fields[7] as CompletionCriteriaHiveModel,
    );
  }

  @override
  void write(BinaryWriter writer, FlashcardHiveModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.flashcardId)
      ..writeByte(1)
      ..write(obj.language)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.cards)
      ..writeByte(5)
      ..write(obj.difficulty)
      ..writeByte(6)
      ..write(obj.order)
      ..writeByte(7)
      ..write(obj.completionCriteria);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlashcardHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
