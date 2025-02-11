import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:learnara/features/Activitytype/domain/entity/quiz/quiz_completion_criteria_entity.dart';
import 'package:learnara/features/Activitytype/domain/entity/quiz/quiz_entity.dart';
import 'package:learnara/features/Activitytype/domain/entity/quiz/quiz_question_entity.dart';
import 'package:learnara/features/langauge/data/model/language_api_model.dart';

part 'quiz_api_model.g.dart';

@JsonSerializable()
class QuizApiModel extends Equatable {
  @JsonKey(name: "_id")
  final String? id;

  final LanguageApiModel language;
  final String title;
  final String description;

  @JsonKey(name: 'questions')
  final List<QuizQuestionApiModel> questions;

  final int duration;
  final String difficulty;
  final int order;

  final QuizCompletionCriteriaApiModel completionCriteria;

  const QuizApiModel({
    this.id,
    required this.language,
    required this.title,
    required this.description,
    required this.questions,
    required this.duration,
    this.difficulty = 'beginner',
    required this.order,
    required this.completionCriteria,
  });

  // Auto generates the json values (From Json)
  factory QuizApiModel.fromJson(Map<String, dynamic> json) =>
      _$QuizApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuizApiModelToJson(this);

  // To Entity
  QuizEntity toEntity() {
    return QuizEntity(
      id: id,
      language: language.toEntity(),
      title: title,
      description: description,
      questions: questions.map((q) => q.toEntity()).toList(),
      duration: duration,
      difficulty: difficulty,
      order: order,
      completionCriteria: completionCriteria.toEntity(),
    );
  }

  // From Entity
  factory QuizApiModel.fromEntity(QuizEntity entity) {
    return QuizApiModel(
      id: entity.id,
      language: LanguageApiModel.fromEntity(entity.language),
      title: entity.title,
      description: entity.description,
      questions: entity.questions.map((q) => QuizQuestionApiModel.fromEntity(q)).toList(),
      duration: entity.duration,
      difficulty: entity.difficulty,
      order: entity.order,
      completionCriteria: QuizCompletionCriteriaApiModel.fromEntity(entity.completionCriteria),
    );
  }

  @override
  List<Object?> get props => [
    id,
    language,
    title,
    description,
    questions,
    duration,
    difficulty,
    order,
    completionCriteria,
  ];
}

@JsonSerializable()
class QuizQuestionApiModel extends Equatable {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String? explanation;

  const QuizQuestionApiModel({
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.explanation,
  });

  // Auto generates the json values (From Json)
  factory QuizQuestionApiModel.fromJson(Map<String, dynamic> json) =>
      _$QuizQuestionApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuizQuestionApiModelToJson(this);

  // To Entity
  QuizQuestion toEntity() {
    return QuizQuestion(
      question: question,
      options: options,
      correctAnswer: correctAnswer,
      explanation: explanation,
    );
  }

  // From Entity
  factory QuizQuestionApiModel.fromEntity(QuizQuestion entity) {
    return QuizQuestionApiModel(
      question: entity.question,
      options: entity.options,
      correctAnswer: entity.correctAnswer,
      explanation: entity.explanation,
    );
  }

  @override
  List<Object?> get props => [question, options, correctAnswer, explanation];
}

@JsonSerializable()
class QuizCompletionCriteriaApiModel extends Equatable {
  final int passingScore;
  final int attemptsAllowed;

  const QuizCompletionCriteriaApiModel({
    this.passingScore = 70,
    this.attemptsAllowed = 3,
  });

  // Auto generates the json values (From Json)
  factory QuizCompletionCriteriaApiModel.fromJson(Map<String, dynamic> json) =>
      _$QuizCompletionCriteriaApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuizCompletionCriteriaApiModelToJson(this);

  // To Entity
  QuizCompletionCriteria toEntity() {
    return QuizCompletionCriteria(
      passingScore: passingScore,
      attemptsAllowed: attemptsAllowed,
    );
  }

  // From Entity
  factory QuizCompletionCriteriaApiModel.fromEntity(QuizCompletionCriteria entity) {
    return QuizCompletionCriteriaApiModel(
      passingScore: entity.passingScore,
      attemptsAllowed: entity.attemptsAllowed,
    );
  }

  @override
  List<Object?> get props => [passingScore, attemptsAllowed];
}