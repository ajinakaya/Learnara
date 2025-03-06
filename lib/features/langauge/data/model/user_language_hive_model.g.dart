// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_language_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserLanguageHiveModelAdapter extends TypeAdapter<UserLanguageHiveModel> {
  @override
  final int typeId = 2;

  @override
  UserLanguageHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserLanguageHiveModel(
      languageId: fields[0] as String?,
      userId: fields[1] as String,
      languageName: fields[2] as String,
      languageImage: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserLanguageHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.languageId)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.languageName)
      ..writeByte(3)
      ..write(obj.languageImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserLanguageHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
