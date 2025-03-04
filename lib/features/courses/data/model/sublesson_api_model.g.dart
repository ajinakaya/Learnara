// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sublesson_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubLessonApiModel _$SubLessonApiModelFromJson(Map<String, dynamic> json) =>
    SubLessonApiModel(
      id: json['_id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      order: (json['order'] as num).toInt(),
      activities: json['activities'] as List<dynamic>,
      activityType: json['activityType'] as String,
      language:
          LanguageApiModel.fromJson(json['language'] as Map<String, dynamic>),
      duration: (json['duration'] as num?)?.toInt(),
      objectives: (json['objectives'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      status: json['status'] as String? ?? 'draft',
      completionCriteria: CompletionCriteriaApiModel.fromJson(
          json['completionCriteria'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubLessonApiModelToJson(SubLessonApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'order': instance.order,
      'activities': instance.activities,
      'activityType': instance.activityType,
      'language': instance.language,
      'duration': instance.duration,
      'objectives': instance.objectives,
      'status': instance.status,
      'completionCriteria': instance.completionCriteria,
    };

CompletionCriteriaApiModel _$CompletionCriteriaApiModelFromJson(
        Map<String, dynamic> json) =>
    CompletionCriteriaApiModel(
      requiredActivities: (json['requiredActivities'] as num?)?.toInt() ?? 0,
      minimumScore: (json['minimumScore'] as num?)?.toInt() ?? 70,
    );

Map<String, dynamic> _$CompletionCriteriaApiModelToJson(
        CompletionCriteriaApiModel instance) =>
    <String, dynamic>{
      'requiredActivities': instance.requiredActivities,
      'minimumScore': instance.minimumScore,
    };
