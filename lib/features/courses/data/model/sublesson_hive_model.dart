import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:learnara/app/constants/hive_table_constant.dart';
import 'package:learnara/features/langauge/data/model/language_hive_model.dart';
import 'package:learnara/features/courses/domain/entity/sublesson_entity.dart';
import 'package:uuid/uuid.dart';

part 'sublesson_hive_model.g.dart';

@HiveType(typeId: HIveTableConstant.subLessonTableId)
class SubLessonHiveModel extends Equatable {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final int order;

  @HiveField(4)
  final List<dynamic> activities;

  @HiveField(5)
  final String activityType;

  @HiveField(6)
  final LanguageHiveModel language;

  @HiveField(7)
  final int? duration;

  @HiveField(8)
  final List<String> objectives;

  @HiveField(9)
  final String status;

  @HiveField(10)
  final CompletionCriteriaHiveModel completionCriteria;

  SubLessonHiveModel({
    String? id,
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
  }) : id = id ?? const Uuid().v4();

  // Initial Constructor
  const SubLessonHiveModel.initial()
      : id = '',
        title = '',
        description = '',
        order = 0,
        activities = const [],
        activityType = '',
        language = const LanguageHiveModel.initial(),
        duration = 0,
        objectives = const [],
        status = 'draft',
        completionCriteria = const CompletionCriteriaHiveModel.initial();

  // From Entity
  factory SubLessonHiveModel.fromEntity(SubLessonEntity entity) {
    return SubLessonHiveModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      order: entity.order,
      activities: entity.activities,
      activityType: entity.activityType,
      language: LanguageHiveModel.fromEntity(entity.language),
      duration: entity.duration,
      objectives: entity.objectives,
      status: entity.status,
      completionCriteria: CompletionCriteriaHiveModel.fromEntity(entity.completionCriteria),
    );
  }

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

@HiveType(typeId: HIveTableConstant.completionCriteriaTableId)
class CompletionCriteriaHiveModel extends Equatable {
  @HiveField(0)
  final int requiredActivities;

  @HiveField(1)
  final int minimumScore;

  const CompletionCriteriaHiveModel({
    this.requiredActivities = 0,
    this.minimumScore = 70,
  });

  // Initial Constructor
  const CompletionCriteriaHiveModel.initial()
      : requiredActivities = 0,
        minimumScore = 70;

  // From Entity
  factory CompletionCriteriaHiveModel.fromEntity(CompletionCriteriaEntity entity) {
    return CompletionCriteriaHiveModel(
      requiredActivities: entity.requiredActivities,
      minimumScore: entity.minimumScore,
    );
  }

  // To Entity
  CompletionCriteriaEntity toEntity() {
    return CompletionCriteriaEntity(
      requiredActivities: requiredActivities,
      minimumScore: minimumScore,
    );
  }

  @override
  List<Object?> get props => [requiredActivities, minimumScore];
}