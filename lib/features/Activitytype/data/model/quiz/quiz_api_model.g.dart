// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizApiModel _$QuizApiModelFromJson(Map<String, dynamic> json) => QuizApiModel(
      id: json['_id'] as String?,
      language:
          LanguageApiModel.fromJson(json['language'] as Map<String, dynamic>),
      title: json['title'] as String,
      description: json['description'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => QuizQuestionApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      duration: (json['duration'] as num).toInt(),
      difficulty: json['difficulty'] as String? ?? 'beginner',
      order: (json['order'] as num).toInt(),
      completionCriteria: QuizCompletionCriteriaApiModel.fromJson(
          json['completionCriteria'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuizApiModelToJson(QuizApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'language': instance.language,
      'title': instance.title,
      'description': instance.description,
      'questions': instance.questions,
      'duration': instance.duration,
      'difficulty': instance.difficulty,
      'order': instance.order,
      'completionCriteria': instance.completionCriteria,
    };

QuizQuestionApiModel _$QuizQuestionApiModelFromJson(
        Map<String, dynamic> json) =>
    QuizQuestionApiModel(
      question: json['question'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      correctAnswer: json['correctAnswer'] as String,
      explanation: json['explanation'] as String?,
    );

Map<String, dynamic> _$QuizQuestionApiModelToJson(
        QuizQuestionApiModel instance) =>
    <String, dynamic>{
      'question': instance.question,
      'options': instance.options,
      'correctAnswer': instance.correctAnswer,
      'explanation': instance.explanation,
    };

QuizCompletionCriteriaApiModel _$QuizCompletionCriteriaApiModelFromJson(
        Map<String, dynamic> json) =>
    QuizCompletionCriteriaApiModel(
      passingScore: (json['passingScore'] as num?)?.toInt() ?? 70,
      attemptsAllowed: (json['attemptsAllowed'] as num?)?.toInt() ?? 3,
    );

Map<String, dynamic> _$QuizCompletionCriteriaApiModelToJson(
        QuizCompletionCriteriaApiModel instance) =>
    <String, dynamic>{
      'passingScore': instance.passingScore,
      'attemptsAllowed': instance.attemptsAllowed,
    };
