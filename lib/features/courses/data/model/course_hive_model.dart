import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:learnara/app/constants/hive_table_constant.dart';
import 'package:learnara/features/langauge/data/model/language_hive_model.dart';
import 'package:learnara/features/courses/domain/entity/course_entity.dart';
import 'package:learnara/features/courses/data/model/chapter_hive_model.dart';


part 'course_hive_model.g.dart';

@HiveType(typeId: HIveTableConstant.courseTableId)
class CourseHiveModel extends Equatable {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final LanguageHiveModel language;

  @HiveField(3)
  final List<String> level;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final String? thumbnail;

  @HiveField(6)
  final List<ChapterHiveModel> chapters;

  @HiveField(7)
  final bool premium;

  @HiveField(8)
  final PriceHiveModel price;

  @HiveField(9)
  final String category;

  @HiveField(10)
  final List<String> tags;

  @HiveField(11)
  final String status;

  @HiveField(12)
  final MetadataHiveModel metadata;

  @HiveField(13)
  final DateTime createdAt;

  @HiveField(14)
  final DateTime updatedAt;

  const CourseHiveModel({
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

  // Initial Constructor
   CourseHiveModel.initial()
      : id = '',
        title = '',
        language = const LanguageHiveModel.initial(),
        level = const [],
        description = '',
        thumbnail = null,
        chapters = const [],
        premium = false,
        price = const PriceHiveModel.initial(),
        category = '',
        tags = const [],
        status = 'draft',
        metadata = const MetadataHiveModel.initial(),
        createdAt = DateTime.now(),
        updatedAt = DateTime.now();

  // From Entity
  factory CourseHiveModel.fromEntity(CourseEntity entity) {
    return CourseHiveModel(
      id: entity.id,
      title: entity.title,
      language: LanguageHiveModel.fromEntity(entity.language),
      level: entity.level,
      description: entity.description,
      thumbnail: entity.thumbnail,
      chapters: entity.chapters.map((chapter) => ChapterHiveModel.fromEntity(chapter)).toList(),
      premium: entity.premium,
      price: PriceHiveModel.fromEntity(entity.price),
      category: entity.category,
      tags: entity.tags,
      status: entity.status,
      metadata: MetadataHiveModel.fromEntity(entity.metadata),
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  // To Entity
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

@HiveType(typeId: HIveTableConstant.priceTableId)
class PriceHiveModel extends Equatable {
  @HiveField(0)
  final double amount;

  @HiveField(1)
  final String currency;

  const PriceHiveModel({
    required this.amount,
    this.currency = 'USD',
  });

  // Initial Constructor
  const PriceHiveModel.initial()
      : amount = 0.0,
        currency = 'USD';

  // From Entity
  factory PriceHiveModel.fromEntity(PriceEntity entity) {
    return PriceHiveModel(
      amount: entity.amount,
      currency: entity.currency,
    );
  }

  // To Entity
  PriceEntity toEntity() {
    return PriceEntity(
      amount: amount,
      currency: currency,
    );
  }

  @override
  List<Object?> get props => [amount, currency];
}

@HiveType(typeId: HIveTableConstant.metadataTableId)
class MetadataHiveModel extends Equatable {
  @HiveField(0)
  final int totalDuration;

  @HiveField(1)
  final int totalChapters;

  @HiveField(2)
  final int totalSubLessons;

  @HiveField(3)
  final int totalActivities;

  @HiveField(4)
  final double averageRating;

  const MetadataHiveModel({
    required this.totalDuration,
    required this.totalChapters,
    required this.totalSubLessons,
    required this.totalActivities,
    this.averageRating = 0.0,
  });

  // Initial Constructor
  const MetadataHiveModel.initial()
      : totalDuration = 0,
        totalChapters = 0,
        totalSubLessons = 0,
        totalActivities = 0,
        averageRating = 0.0;

  // From Entity
  factory MetadataHiveModel.fromEntity(MetadataEntity entity) {
    return MetadataHiveModel(
      totalDuration: entity.totalDuration,
      totalChapters: entity.totalChapters,
      totalSubLessons: entity.totalSubLessons,
      totalActivities: entity.totalActivities,
      averageRating: entity.averageRating,
    );
  }

  // To Entity
  MetadataEntity toEntity() {
    return MetadataEntity(
      totalDuration: totalDuration,
      totalChapters: totalChapters,
      totalSubLessons: totalSubLessons,
      totalActivities: totalActivities,
      averageRating: averageRating,
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
