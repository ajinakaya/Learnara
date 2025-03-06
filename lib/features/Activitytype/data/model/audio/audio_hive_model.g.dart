// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AudioHiveModelAdapter extends TypeAdapter<AudioHiveModel> {
  @override
  final int typeId = 6;

  @override
  AudioHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AudioHiveModel(
      audioId: fields[0] as String?,
      language: fields[1] as LanguageHiveModel,
      title: fields[2] as String,
      description: fields[3] as String,
      audio: fields[4] as String,
      duration: fields[5] as int,
      transcript: fields[6] as String?,
      difficulty: fields[7] as String,
      order: fields[8] as int,
      completionCriteria: fields[9] as AudioCompletionCriteriaHiveModel,
    );
  }

  @override
  void write(BinaryWriter writer, AudioHiveModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.audioId)
      ..writeByte(1)
      ..write(obj.language)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.audio)
      ..writeByte(5)
      ..write(obj.duration)
      ..writeByte(6)
      ..write(obj.transcript)
      ..writeByte(7)
      ..write(obj.difficulty)
      ..writeByte(8)
      ..write(obj.order)
      ..writeByte(9)
      ..write(obj.completionCriteria);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AudioHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AudioCompletionCriteriaHiveModelAdapter
    extends TypeAdapter<AudioCompletionCriteriaHiveModel> {
  @override
  final int typeId = 10;

  @override
  AudioCompletionCriteriaHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AudioCompletionCriteriaHiveModel(
      listenPercentage: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AudioCompletionCriteriaHiveModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.listenPercentage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AudioCompletionCriteriaHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
