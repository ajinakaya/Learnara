import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:learnara/features/langauge/domain/entity/language_entity.dart';

part 'language_api_model.g.dart';

@JsonSerializable()
class LanguageApiModel extends Equatable {
  @JsonKey(name: "_id")
  final String? languageId;
  final String languageName;
  final String languageImage;

  const LanguageApiModel({
    this.languageId,
    required this.languageName,
    required this.languageImage,
  });

  // JSON serialization methods
  factory LanguageApiModel.fromJson(Map<String, dynamic> json) {
    return LanguageApiModel(
      // Ensure languageId is always a String
      languageId: json['_id']?.toString(),
      languageName: json['languageName'] ?? '',
      languageImage: json['languageImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'languageName': languageName,
      'languageImage': languageImage,
    };

    if (languageId != null) {
      data['_id'] = languageId;
    }

    return data;
  }

  // Convert to Entity
  PreferredLanguageEntity toEntity() {
    return PreferredLanguageEntity(
      languageId: languageId ?? '',
      languageName: languageName,
      languageImage: languageImage,
    );
  }

  // Convert from Entity
  factory LanguageApiModel.fromEntity(PreferredLanguageEntity entity) {
    return LanguageApiModel(
      languageId: entity.languageId,
      languageName: entity.languageName,
      languageImage: entity.languageImage,
    );
  }

  @override
  List<Object?> get props => [languageId, languageName, languageImage];
}