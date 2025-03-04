import 'package:equatable/equatable.dart';
import 'package:learnara/features/courses/domain/entity/sublesson_entity.dart';
import 'package:learnara/features/langauge/domain/entity/language_entity.dart';


class ChapterEntity extends Equatable {
  final String? id;
  final String title;
  final String? description;
  final int order;
  final PreferredLanguageEntity language;
  final List<String> learningObjectives;
  final int? estimatedDuration;
  final String status;
  final List<SubLessonEntity> subLessons;
  final List<ChapterEntity> prerequisites;

  const ChapterEntity({
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
