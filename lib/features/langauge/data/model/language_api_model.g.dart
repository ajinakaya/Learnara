// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguageApiModel _$LanguageApiModelFromJson(Map<String, dynamic> json) =>
    LanguageApiModel(
      languageId: json['_id'] as String?,
      languageName: json['languageName'] as String,
      languageImage: json['languageImage'] as String,
    );

Map<String, dynamic> _$LanguageApiModelToJson(LanguageApiModel instance) =>
    <String, dynamic>{
      '_id': instance.languageId,
      'languageName': instance.languageName,
      'languageImage': instance.languageImage,
    };
