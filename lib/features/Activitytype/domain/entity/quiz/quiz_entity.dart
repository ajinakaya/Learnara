import 'package:equatable/equatable.dart';
import 'package:learnara/features/langauge/domain/entity/language_entity.dart';
import 'package:learnara/features/Activitytype/domain/entity/quiz/quiz_question_entity.dart';
import 'package:learnara/features/Activitytype/domain/entity/quiz/quiz_completion_criteria_entity.dart';

class QuizEntity extends Equatable {
  final String? id;
  final PreferredLanguageEntity language;
  final String title;
  final String description;
  final List<QuizQuestion> questions;
  final int duration; // in minutes
  final String difficulty;
  final int order;
  final QuizCompletionCriteria completionCriteria;

  const QuizEntity({
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