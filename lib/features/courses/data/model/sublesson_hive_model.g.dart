// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sublesson_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubLessonHiveModelAdapter extends TypeAdapter<SubLessonHiveModel> {
  @override
  final int typeId = 11;

  @override
  SubLessonHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubLessonHiveModel(
      id: fields[0] as String?,
      title: fields[1] as String,
      description: fields[2] as String?,
      order: fields[3] as int,
      activities: (fields[4] as List).cast<dynamic>(),
      activityType: fields[5] as String,
      language: fields[6] as LanguageHiveModel,
      duration: fields[7] as int?,
      objectives: (fields[8] as List).cast<String>(),
      status: fields[9] as String,
      completionCriteria: fields[10] as CompletionCriteriaHiveModel,
    );
  }

  @override
  void write(BinaryWriter writer, SubLessonHiveModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.order)
      ..writeByte(4)
      ..write(obj.activities)
      ..writeByte(5)
      ..write(obj.activityType)
      ..writeByte(6)
      ..write(obj.language)
      ..writeByte(7)
      ..write(obj.duration)
      ..writeByte(8)
      ..write(obj.objectives)
      ..writeByte(9)
      ..write(obj.status)
      ..writeByte(10)
      ..write(obj.completionCriteria);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubLessonHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
      requiredActivities: fields[0] as int,
      minimumScore: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CompletionCriteriaHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.requiredActivities)
      ..writeByte(1)
      ..write(obj.minimumScore);
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
