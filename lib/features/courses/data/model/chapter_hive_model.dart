import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:learnara/app/constants/hive_table_constant.dart';
import 'package:learnara/features/langauge/data/model/language_hive_model.dart';
import 'package:learnara/features/courses/domain/entity/chapter_entity.dart';
import 'package:learnara/features/courses/data/model/sublesson_hive_model.dart';

part 'chapter_hive_model.g.dart';

@HiveType(typeId: HIveTableConstant.chapterTableId)
class ChapterHiveModel extends Equatable {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final int order;

  @HiveField(4)
  final LanguageHiveModel language;

  @HiveField(5)
  final List<String> learningObjectives;

  @HiveField(6)
  final int? estimatedDuration;

  @HiveField(7)
  final String status;

  @HiveField(8)
  final List<SubLessonHiveModel> subLessons;

  @HiveField(9)
  final List<ChapterHiveModel> prerequisites;

  ChapterHiveModel({
    this.id,
    required this.title,
    this.description,
    required this.order,
    required this.language,
    required this.learningObjectives,
    this.estimatedDuration,
    this.status = 'draft',
    required this.subLessons,
    required this.prerequisites,
  });

  // Initial Constructor
  const ChapterHiveModel.initial()
      : id = '',
        title = '',
        description = '',
        order = 0,
        language = const LanguageHiveModel.initial(),
        learningObjectives = const [],
        estimatedDuration = 0,
        status = 'draft',
        subLessons = const [],
        prerequisites = const [];

  // From Entity
  factory ChapterHiveModel.fromEntity(ChapterEntity entity) {
    return ChapterHiveModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      order: entity.order,
      language: LanguageHiveModel.fromEntity(entity.language),
      learningObjectives: entity.learningObjectives,
      estimatedDuration: entity.estimatedDuration,
      status: entity.status,
      subLessons: entity.subLessons.map((subLesson) => SubLessonHiveModel.fromEntity(subLesson)).toList(),
      prerequisites: entity.prerequisites.map((prereq) => ChapterHiveModel.fromEntity(prereq)).toList(),
    );
  }

  // To Entity
  ChapterEntity toEntity() {
    return ChapterEntity(
      id: id,
      title: title,
      description: description,
      order: order,
      language: language.toEntity(),
      learningObjectives: learningObjectives,
      estimatedDuration: estimatedDuration,
      status: status,
      subLessons: subLessons.map((subLesson) => subLesson.toEntity()).toList(),
      prerequisites: prerequisites.map((prereq) => prereq.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    order,
    language,
    learningObjectives,
    estimatedDuration,
    status,
    subLessons,
    prerequisites,
  ];
}
