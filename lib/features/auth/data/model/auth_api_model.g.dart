// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      id: json['_id'] as String?,
      fullname: json['fullname'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      image: json['image'] as String?,
      role: json['role'] as String? ?? "user",
      password: json['password'] as String,
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fullname': instance.fullname,
      'email': instance.email,
      'username': instance.username,
      'image': instance.image,
      'role': instance.role,
      'password': instance.password,
    };
