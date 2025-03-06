// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseApiModel _$CourseApiModelFromJson(Map<String, dynamic> json) =>
    CourseApiModel(
      id: json['_id'] as String?,
      title: json['title'] as String,
      language:
          LanguageApiModel.fromJson(json['language'] as Map<String, dynamic>),
      level: (json['level'] as List<dynamic>).map((e) => e as String).toList(),
      description: json['description'] as String,
      thumbnail: json['thumbnail'] as String?,
      chapters: (json['chapters'] as List<dynamic>)
          .map((e) => ChapterApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      premium: json['premium'] as bool? ?? false,
      price: PriceApiModel.fromJson(json['price'] as Map<String, dynamic>),
      category: json['category'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      status: json['status'] as String? ?? 'draft',
      metadata:
          MetadataApiModel.fromJson(json['metadata'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CourseApiModelToJson(CourseApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'language': instance.language,
      'level': instance.level,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
      'chapters': instance.chapters,
      'premium': instance.premium,
      'price': instance.price,
      'category': instance.category,
      'tags': instance.tags,
      'status': instance.status,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

PriceApiModel _$PriceApiModelFromJson(Map<String, dynamic> json) =>
    PriceApiModel(
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'USD',
    );

Map<String, dynamic> _$PriceApiModelToJson(PriceApiModel instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'currency': instance.currency,
    };

MetadataApiModel _$MetadataApiModelFromJson(Map<String, dynamic> json) =>
    MetadataApiModel(
      totalDuration: (json['totalDuration'] as num).toInt(),
      totalChapters: (json['totalChapters'] as num).toInt(),
      totalSubLessons: (json['totalSubLessons'] as num).toInt(),
      totalActivities: (json['totalActivities'] as num).toInt(),
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$MetadataApiModelToJson(MetadataApiModel instance) =>
    <String, dynamic>{
      'totalDuration': instance.totalDuration,
      'totalChapters': instance.totalChapters,
      'totalSubLessons': instance.totalSubLessons,
      'totalActivities': instance.totalActivities,
      'averageRating': instance.averageRating,
    };
