// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthHiveModelAdapter extends TypeAdapter<AuthHiveModel> {
  @override
  final int typeId = 0;

  @override
  AuthHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthHiveModel(
      userId: fields[0] as String?,
      fullname: fields[1] as String,
      email: fields[2] as String,
      username: fields[3] as String,
      password: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AuthHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.fullname)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.username)
      ..writeByte(4)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
