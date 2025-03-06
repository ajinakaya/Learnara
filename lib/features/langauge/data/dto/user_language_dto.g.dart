// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_language_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLanguageDto _$UserLanguageDtoFromJson(Map<String, dynamic> json) =>
    UserLanguageDto(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => UserLanguageApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserLanguageDtoToJson(UserLanguageDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
