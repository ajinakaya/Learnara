// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioApiModel _$AudioApiModelFromJson(Map<String, dynamic> json) =>
    AudioApiModel(
      id: json['_id'] as String?,
      language:
          LanguageApiModel.fromJson(json['language'] as Map<String, dynamic>),
      title: json['title'] as String,
      description: json['description'] as String,
      audio: json['audio'] as String,
      duration: (json['duration'] as num).toInt(),
      transcript: json['transcript'] as String?,
      difficulty: json['difficulty'] as String? ?? 'beginner',
      order: (json['order'] as num).toInt(),
      completionCriteria: AudioCompletionCriteriaApiModel.fromJson(
          json['completionCriteria'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AudioApiModelToJson(AudioApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'language': instance.language,
      'title': instance.title,
      'description': instance.description,
      'audio': instance.audio,
      'duration': instance.duration,
      'transcript': instance.transcript,
      'difficulty': instance.difficulty,
      'order': instance.order,
      'completionCriteria': instance.completionCriteria,
    };

AudioCompletionCriteriaApiModel _$AudioCompletionCriteriaApiModelFromJson(
        Map<String, dynamic> json) =>
    AudioCompletionCriteriaApiModel(
      listenPercentage: (json['listenPercentage'] as num?)?.toInt() ?? 90,
    );

Map<String, dynamic> _$AudioCompletionCriteriaApiModelToJson(
        AudioCompletionCriteriaApiModel instance) =>
    <String, dynamic>{
      'listenPercentage': instance.listenPercentage,
    };
