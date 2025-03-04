// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseHiveModelAdapter extends TypeAdapter<CourseHiveModel> {
  @override
  final int typeId = 13;

  @override
  CourseHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourseHiveModel(
      id: fields[0] as String?,
      title: fields[1] as String,
      language: fields[2] as LanguageHiveModel,
      level: (fields[3] as List).cast<String>(),
      description: fields[4] as String,
      thumbnail: fields[5] as String?,
      chapters: (fields[6] as List).cast<ChapterHiveModel>(),
      premium: fields[7] as bool,
      price: fields[8] as PriceHiveModel,
      category: fields[9] as String,
      tags: (fields[10] as List).cast<String>(),
      status: fields[11] as String,
      metadata: fields[12] as MetadataHiveModel,
      createdAt: fields[13] as DateTime,
      updatedAt: fields[14] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CourseHiveModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.language)
      ..writeByte(3)
      ..write(obj.level)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.thumbnail)
      ..writeByte(6)
      ..write(obj.chapters)
      ..writeByte(7)
      ..write(obj.premium)
      ..writeByte(8)
      ..write(obj.price)
      ..writeByte(9)
      ..write(obj.category)
      ..writeByte(10)
      ..write(obj.tags)
      ..writeByte(11)
      ..write(obj.status)
      ..writeByte(12)
      ..write(obj.metadata)
      ..writeByte(13)
      ..write(obj.createdAt)
      ..writeByte(14)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PriceHiveModelAdapter extends TypeAdapter<PriceHiveModel> {
  @override
  final int typeId = 14;

  @override
  PriceHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PriceHiveModel(
      amount: fields[0] as double,
      currency: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PriceHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.currency);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriceHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MetadataHiveModelAdapter extends TypeAdapter<MetadataHiveModel> {
  @override
  final int typeId = 15;

  @override
  MetadataHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MetadataHiveModel(
      totalDuration: fields[0] as int,
      totalChapters: fields[1] as int,
      totalSubLessons: fields[2] as int,
      totalActivities: fields[3] as int,
      averageRating: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, MetadataHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.totalDuration)
      ..writeByte(1)
      ..write(obj.totalChapters)
      ..writeByte(2)
      ..write(obj.totalSubLessons)
      ..writeByte(3)
      ..write(obj.totalActivities)
      ..writeByte(4)
      ..write(obj.averageRating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MetadataHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
