import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:learnara/app/constants/hive_table_constant.dart';
import 'package:learnara/features/Activitytype/domain/entity/quiz/quiz_completion_criteria_entity.dart';
import 'package:learnara/features/Activitytype/domain/entity/quiz/quiz_entity.dart';
import 'package:learnara/features/Activitytype/domain/entity/quiz/quiz_question_entity.dart';
import 'package:learnara/features/langauge/data/model/language_hive_model.dart';
import 'package:uuid/uuid.dart';

part 'quiz_hive_model.g.dart';

@HiveType(typeId: HIveTableConstant.quizActivityTableId )
class QuizHiveModel extends Equatable {
  @HiveField(0)
  final String? quizId;

  @HiveField(1)
  final LanguageHiveModel language;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final List<QuizQuestionHiveModel> questions;

  @HiveField(5)
  final int duration;

  @HiveField(6)
  final String difficulty;

  @HiveField(7)
  final int order;

  @HiveField(8)
  final QuizCompletionCriteriaHiveModel completionCriteria;

  QuizHiveModel({
    String? quizId,
    required this.language,
    required this.title,
    required this.description,
    required this.questions,
    required this.duration,
    this.difficulty = 'beginner',
    required this.order,
    required this.completionCriteria,
  }) : quizId = quizId ?? const Uuid().v4();

  // Initial Constructor
  const QuizHiveModel.initial()
      : quizId = '',
        language = const LanguageHiveModel.initial(),
        title = '',
        description = '',
        questions = const [],
        duration = 0,
        difficulty = 'beginner',
        order = 0,
        completionCriteria = const QuizCompletionCriteriaHiveModel.initial();

  // From Entity
  factory QuizHiveModel.fromEntity(QuizEntity entity) {
    return QuizHiveModel(
      quizId: entity.id,
      language: LanguageHiveModel.fromEntity(entity.language),
      title: entity.title,
      description: entity.description,
      questions: entity.questions.map((q) => QuizQuestionHiveModel.fromEntity(q)).toList(),
      duration: entity.duration,
      difficulty: entity.difficulty,
      order: entity.order,
      completionCriteria: QuizCompletionCriteriaHiveModel.fromEntity(entity.completionCriteria),
    );
  }

  // To Entity
  QuizEntity toEntity() {
    return QuizEntity(
      id: quizId,
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

  @override
  List<Object?> get props => [
    quizId,
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

@HiveType(typeId: HIveTableConstant.quizQuestionTableId)
class QuizQuestionHiveModel extends Equatable {
  @HiveField(0)
  final String question;

  @HiveField(1)
  final List<String> options;

  @HiveField(2)
  final String correctAnswer;

  @HiveField(3)
  final String? explanation;

  const QuizQuestionHiveModel({
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.explanation,
  });

  // From Entity
  factory QuizQuestionHiveModel.fromEntity(QuizQuestion entity) {
    return QuizQuestionHiveModel(
      question: entity.question,
      options: entity.options,
      correctAnswer: entity.correctAnswer,
      explanation: entity.explanation,
    );
  }

  // To Entity
  QuizQuestion toEntity() {
    return QuizQuestion(
      question: question,
      options: options,
      correctAnswer: correctAnswer,
      explanation: explanation,
    );
  }

  @override
  List<Object?> get props => [question, options, correctAnswer, explanation];
}

@HiveType(typeId: HIveTableConstant.quizCompletionCriteriaTableId)
class QuizCompletionCriteriaHiveModel extends Equatable {
  @HiveField(0)
  final int passingScore;

  @HiveField(1)
  final int attemptsAllowed;

  const QuizCompletionCriteriaHiveModel({
    this.passingScore = 70,
    this.attemptsAllowed = 3,
  });

  // Initial Constructor
  const QuizCompletionCriteriaHiveModel.initial()
      : passingScore = 70,
        attemptsAllowed = 3;

  // From Entity
  factory QuizCompletionCriteriaHiveModel.fromEntity(QuizCompletionCriteria entity) {
    return QuizCompletionCriteriaHiveModel(
      passingScore: entity.passingScore,
      attemptsAllowed: entity.attemptsAllowed,
    );
  }

  // To Entity
  QuizCompletionCriteria toEntity() {
    return QuizCompletionCriteria(
      passingScore: passingScore,
      attemptsAllowed: attemptsAllowed,
    );
  }

  @override
  List<Object?> get props => [passingScore, attemptsAllowed];
}