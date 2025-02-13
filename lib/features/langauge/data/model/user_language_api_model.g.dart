// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_language_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLanguageApiModel _$UserLanguageApiModelFromJson(
        Map<String, dynamic> json) =>
    UserLanguageApiModel(
      languageId: json['languageId'] as String?,
      userId: json['userId'] as String,
      languageName: json['languageName'] as String,
      languageImage: json['languageImage'] as String,
    );

Map<String, dynamic> _$UserLanguageApiModelToJson(
        UserLanguageApiModel instance) =>
    <String, dynamic>{
      'languageId': instance.languageId,
      'userId': instance.userId,
      'languageName': instance.languageName,
      'languageImage': instance.languageImage,
    };
