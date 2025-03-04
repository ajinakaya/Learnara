import 'package:equatable/equatable.dart';
import 'package:learnara/features/courses/domain/entity/chapter_entity.dart';
import 'package:learnara/features/langauge/domain/entity/language_entity.dart';


class CourseEntity extends Equatable {
  final String? id;
  final String title;
  final PreferredLanguageEntity language;
  final List<String> level;
  final String description;
  final String? thumbnail;
  final List<ChapterEntity> chapters;
  final bool premium;
  final PriceEntity price;
  final String category;
  final List<String> tags;
  final String status;
  final MetadataEntity metadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CourseEntity({
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

class PriceEntity extends Equatable {
  final double amount;
  final String currency;

  const PriceEntity({
    required this.amount,
    this.currency = 'USD',
  });

  @override
  List<Object?> get props => [amount, currency];
}

class MetadataEntity extends Equatable {
  final int totalDuration;
  final int totalChapters;
  final int totalSubLessons;
  final int totalActivities;
  final double averageRating;

  const MetadataEntity({
    required this.totalDuration,
    required this.totalChapters,
    required this.totalSubLessons,
    required this.totalActivities,
    this.averageRating = 0.0,
  });

  @override
  List<Object?> get props => [
    totalDuration,
    totalChapters,
    totalSubLessons,
    totalActivities,
    averageRating,
  ];
}
