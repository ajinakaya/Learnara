// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LanguageHiveModelAdapter extends TypeAdapter<LanguageHiveModel> {
  @override
  final int typeId = 1;

  @override
  LanguageHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LanguageHiveModel(
      languageId: fields[0] as String?,
      languageName: fields[1] as String,
      languageImage: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LanguageHiveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.languageId)
      ..writeByte(1)
      ..write(obj.languageName)
      ..writeByte(2)
      ..write(obj.languageImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
