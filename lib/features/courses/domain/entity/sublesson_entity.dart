import 'package:equatable/equatable.dart';
import 'package:learnara/features/langauge/domain/entity/language_entity.dart';

class SubLessonEntity extends Equatable {
  final String? id;
  final String title;
  final String? description;
  final int order;
  final List<dynamic> activities;
  final String activityType;
  final PreferredLanguageEntity language;
  final int? duration;
  final List<String> objectives;
  final String status;
  final CompletionCriteriaEntity completionCriteria;

  const SubLessonEntity({
    this.id,
    required this.title,
    this.description,
    required this.order,
    required this.activities,
    required this.activityType,
    required this.language,
    this.duration,
    required this.objectives,
    this.status = 'draft', // Default value as 'draft'
    required this.completionCriteria,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    order,
    activities,
    activityType,
    language,
    duration,
    objectives,
    status,
    completionCriteria,
  ];
}

class CompletionCriteriaEntity extends Equatable {
  final int requiredActivities;
  final int minimumScore;

  const CompletionCriteriaEntity({
    this.requiredActivities = 0,
    this.minimumScore = 70,
  });

  @override
  List<Object?> get props => [requiredActivities, minimumScore];
}
