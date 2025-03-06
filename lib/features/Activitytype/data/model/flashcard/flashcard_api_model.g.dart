// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcard_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlashcardApiModel _$FlashcardApiModelFromJson(Map<String, dynamic> json) =>
    FlashcardApiModel(
      id: json['_id'] as String?,
      language:
          LanguageApiModel.fromJson(json['language'] as Map<String, dynamic>),
      title: json['title'] as String,
      description: json['description'] as String,
      cards: (json['cards'] as List<dynamic>)
          .map((e) => CardDataApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      difficulty: json['difficulty'] as String? ?? 'beginner',
      order: (json['order'] as num).toInt(),
      completionCriteria: CompletionCriteriaApiModel.fromJson(
          json['completionCriteria'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FlashcardApiModelToJson(FlashcardApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'language': instance.language,
      'title': instance.title,
      'description': instance.description,
      'cards': instance.cards,
      'difficulty': instance.difficulty,
      'order': instance.order,
      'completionCriteria': instance.completionCriteria,
    };

CardDataApiModel _$CardDataApiModelFromJson(Map<String, dynamic> json) =>
    CardDataApiModel(
      front: json['front'] as String,
      back: json['back'] as String,
      hint: json['hint'] as String?,
      example: json['example'] as String?,
    );

Map<String, dynamic> _$CardDataApiModelToJson(CardDataApiModel instance) =>
    <String, dynamic>{
      'front': instance.front,
      'back': instance.back,
      'hint': instance.hint,
      'example': instance.example,
    };

CompletionCriteriaApiModel _$CompletionCriteriaApiModelFromJson(
        Map<String, dynamic> json) =>
    CompletionCriteriaApiModel(
      cardsReviewed: (json['cardsReviewed'] as num).toInt(),
      minimumCorrect: (json['minimumCorrect'] as num?)?.toInt() ?? 80,
    );

Map<String, dynamic> _$CompletionCriteriaApiModelToJson(
        CompletionCriteriaApiModel instance) =>
    <String, dynamic>{
      'cardsReviewed': instance.cardsReviewed,
      'minimumCorrect': instance.minimumCorrect,
    };
