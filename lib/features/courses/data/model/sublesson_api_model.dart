import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:learnara/features/courses/domain/entity/sublesson_entity.dart';
import 'package:learnara/features/langauge/data/model/language_api_model.dart';

part 'sublesson_api_model.g.dart';

@JsonSerializable()
class SubLessonApiModel extends Equatable {
  @JsonKey(name: "_id")
  final String? id;
  final String title;
  final String? description;
  final int order;
  final List<dynamic> activities;
  final String activityType;
  final LanguageApiModel language;
  final int? duration;
  final List<String> objectives;
  final String status;
  final CompletionCriteriaApiModel completionCriteria;

  const SubLessonApiModel({
    this.id,
    required this.title,
    this.description,
    required this.order,
    required this.activities,
    required this.activityType,
    required this.language,
    this.duration,
    required this.objectives,
    this.status = 'draft',
    required this.completionCriteria,
  });

  // Auto-generate JSON serialization methods
  factory SubLessonApiModel.fromJson(Map<String, dynamic> json) =>
      _$SubLessonApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubLessonApiModelToJson(this);

  // To Entity
  SubLessonEntity toEntity() {
    return SubLessonEntity(
      id: id,
      title: title,
      description: description,
      order: order,
      activities: activities,
      activityType: activityType,
      language: language.toEntity(),
      duration: duration,
      objectives: objectives,
      status: status,
      completionCriteria: completionCriteria.toEntity(),
    );
  }

  // From Entity
  factory SubLessonApiModel.fromEntity(SubLessonEntity entity) {
    return SubLessonApiModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      order: entity.order,
      activities: entity.activities,
      activityType: entity.activityType,
      language: LanguageApiModel.fromEntity(entity.language),
      duration: entity.duration,
      objectives: entity.objectives,
      status: entity.status,
      completionCriteria:
      CompletionCriteriaApiModel.fromEntity(entity.completionCriteria),
    );
  }

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

@JsonSerializable()
class CompletionCriteriaApiModel extends Equatable {
  final int requiredActivities;
  final int minimumScore;

  const CompletionCriteriaApiModel({
    this.requiredActivities = 0,
    this.minimumScore = 70,
  });

  factory CompletionCriteriaApiModel.fromJson(Map<String, dynamic> json) =>
      _$CompletionCriteriaApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompletionCriteriaApiModelToJson(this);

  CompletionCriteriaEntity toEntity() {
    return CompletionCriteriaEntity(
      requiredActivities: requiredActivities,
      minimumScore: minimumScore,
    );
  }

  factory CompletionCriteriaApiModel.fromEntity(CompletionCriteriaEntity entity) {
    return CompletionCriteriaApiModel(
      requiredActivities: entity.requiredActivities,
      minimumScore: entity.minimumScore,
    );
  }

  @override
  List<Object?> get props => [requiredActivities, minimumScore];
}