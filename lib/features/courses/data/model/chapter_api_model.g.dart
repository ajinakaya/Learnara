// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterApiModel _$ChapterApiModelFromJson(Map<String, dynamic> json) =>
    ChapterApiModel(
      id: json['_id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      order: (json['order'] as num).toInt(),
      language:
          LanguageApiModel.fromJson(json['language'] as Map<String, dynamic>),
      learningObjectives: (json['learningObjectives'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      estimatedDuration: (json['estimatedDuration'] as num?)?.toInt(),
      status: json['status'] as String? ?? 'draft',
      subLessons: (json['subLessons'] as List<dynamic>)
          .map((e) => SubLessonApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      prerequisites: (json['prerequisites'] as List<dynamic>)
          .map((e) => ChapterApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChapterApiModelToJson(ChapterApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'order': instance.order,
      'language': instance.language,
      'learningObjectives': instance.learningObjectives,
      'estimatedDuration': instance.estimatedDuration,
      'status': instance.status,
      'subLessons': instance.subLessons,
      'prerequisites': instance.prerequisites,
    };
