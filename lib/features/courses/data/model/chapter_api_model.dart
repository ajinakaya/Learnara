import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:learnara/features/langauge/data/model/language_api_model.dart';
import 'package:learnara/features/courses/domain/entity/chapter_entity.dart';
import 'package:learnara/features/courses/data/model/sublesson_api_model.dart';

part 'chapter_api_model.g.dart';

@JsonSerializable()
class ChapterApiModel extends Equatable {
  @JsonKey(name: "_id")
  final String? id;
  final String title;
  final String? description;
  final int order;
  final LanguageApiModel language;
  final List<String> learningObjectives;
  final int? estimatedDuration;
  final String status;
  final List<SubLessonApiModel> subLessons;
  final List<ChapterApiModel> prerequisites;

  const ChapterApiModel({
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

  // JSON serialization methods
  factory ChapterApiModel.fromJson(Map<String, dynamic> json) => _$ChapterApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChapterApiModelToJson(this);

  // Convert to Entity
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
      subLessons: subLessons.map((sub) => sub.toEntity()).toList(),
      prerequisites: prerequisites.map((prereq) => prereq.toEntity()).toList(),
    );
  }

  // Convert from Entity
  factory ChapterApiModel.fromEntity(ChapterEntity entity) {
    return ChapterApiModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      order: entity.order,
      language: LanguageApiModel.fromEntity(entity.language),
      learningObjectives: entity.learningObjectives,
      estimatedDuration: entity.estimatedDuration,
      status: entity.status,
      subLessons: entity.subLessons.map((sub) => SubLessonApiModel.fromEntity(sub)).toList(),
      prerequisites: entity.prerequisites.map((prereq) => ChapterApiModel.fromEntity(prereq)).toList(),
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
