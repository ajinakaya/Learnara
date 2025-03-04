// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChapterHiveModelAdapter extends TypeAdapter<ChapterHiveModel> {
  @override
  final int typeId = 12;

  @override
  ChapterHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChapterHiveModel(
      id: fields[0] as String?,
      title: fields[1] as String,
      description: fields[2] as String?,
      order: fields[3] as int,
      language: fields[4] as LanguageHiveModel,
      learningObjectives: (fields[5] as List).cast<String>(),
      estimatedDuration: fields[6] as int?,
      status: fields[7] as String,
      subLessons: (fields[8] as List).cast<SubLessonHiveModel>(),
      prerequisites: (fields[9] as List).cast<ChapterHiveModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ChapterHiveModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.order)
      ..writeByte(4)
      ..write(obj.language)
      ..writeByte(5)
      ..write(obj.learningObjectives)
      ..writeByte(6)
      ..write(obj.estimatedDuration)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.subLessons)
      ..writeByte(9)
      ..write(obj.prerequisites);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChapterHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
