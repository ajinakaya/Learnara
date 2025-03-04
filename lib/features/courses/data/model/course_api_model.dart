import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:learnara/features/courses/domain/entity/course_entity.dart';
import 'package:learnara/features/courses/data/model/chapter_api_model.dart';
import 'package:learnara/features/langauge/data/model/language_api_model.dart';

part 'course_api_model.g.dart';

@JsonSerializable()
class CourseApiModel extends Equatable {
  @JsonKey(name: "_id")
  final String? id;
  final String title;
  final LanguageApiModel language;
  final List<String> level;
  final String description;
  final String? thumbnail;
  final List<ChapterApiModel> chapters;
  final bool premium;
  final PriceApiModel price;
  final String category;
  final List<String> tags;
  final String status;
  final MetadataApiModel metadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CourseApiModel({
    this.id,
    required this.title,
    required this.language,
    required this.level,
    required this.description,
    this.thumbnail,
    required this.chapters,
    this.premium = false,
    required this.price,
    required this.category,
    required this.tags,
    this.status = 'draft',
    required this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CourseApiModel.fromJson(Map<String, dynamic> json) =>
      _$CourseApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseApiModelToJson(this);

  CourseEntity toEntity() {
    return CourseEntity(
      id: id,
      title: title,
      language: language.toEntity(),
      level: level,
      description: description,
      thumbnail: thumbnail,
      chapters: chapters.map((chapter) => chapter.toEntity()).toList(),
      premium: premium,
      price: price.toEntity(),
      category: category,
      tags: tags,
      status: status,
      metadata: metadata.toEntity(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory CourseApiModel.fromEntity(CourseEntity entity) {
    return CourseApiModel(
      id: entity.id,
      title: entity.title,
      language: LanguageApiModel.fromEntity(entity.language),
      level: entity.level,
      description: entity.description,
      thumbnail: entity.thumbnail,
      chapters:
      entity.chapters.map((chapter) => ChapterApiModel.fromEntity(chapter)).toList(),
      premium: entity.premium,
      price: PriceApiModel.fromEntity(entity.price),
      category: entity.category,
      tags: entity.tags,
      status: entity.status,
      metadata: MetadataApiModel.fromEntity(entity.metadata),
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    language,
    level,
    description,
    thumbnail,
    chapters,
    premium,
    price,
    category,
    tags,
    status,
    metadata,
    createdAt,
    updatedAt,
  ];
}

@JsonSerializable()
class PriceApiModel extends Equatable {
  final double amount;
  final String currency;

  const PriceApiModel({
    required this.amount,
    this.currency = 'USD',
  });

  factory PriceApiModel.fromJson(Map<String, dynamic> json) => _$PriceApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$PriceApiModelToJson(this);

  PriceEntity toEntity() {
    return PriceEntity(
      amount: amount,
      currency: currency,
    );
  }

  factory PriceApiModel.fromEntity(PriceEntity entity) {
    return PriceApiModel(
      amount: entity.amount,
      currency: entity.currency,
    );
  }

  @override
  List<Object?> get props => [amount, currency];
}

@JsonSerializable()
class MetadataApiModel extends Equatable {
  final int totalDuration;
  final int totalChapters;
  final int totalSubLessons;
  final int totalActivities;
  final double averageRating;

  const MetadataApiModel({
    required this.totalDuration,
    required this.totalChapters,
    required this.totalSubLessons,
    required this.totalActivities,
    this.averageRating = 0.0,
  });

  factory MetadataApiModel.fromJson(Map<String, dynamic> json) => _$MetadataApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataApiModelToJson(this);

  MetadataEntity toEntity() {
    return MetadataEntity(
      totalDuration: totalDuration,
      totalChapters: totalChapters,
      totalSubLessons: totalSubLessons,
      totalActivities: totalActivities,
      averageRating: averageRating,
    );
  }

  factory MetadataApiModel.fromEntity(MetadataEntity entity) {
    return MetadataApiModel(
      totalDuration: entity.totalDuration,
      totalChapters: entity.totalChapters,
      totalSubLessons: entity.totalSubLessons,
      totalActivities: entity.totalActivities,
      averageRating: entity.averageRating,
    );
  }

  @override
  List<Object?> get props => [
    totalDuration,
    totalChapters,
    totalSubLessons,
    totalActivities,
    averageRating,
  ];
}