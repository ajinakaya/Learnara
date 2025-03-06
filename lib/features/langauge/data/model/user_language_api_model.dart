import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:learnara/features/langauge/domain/entity/user_language_entity.dart';

part 'user_language_api_model.g.dart';

@JsonSerializable()
class UserLanguageApiModel extends Equatable {

  @JsonKey(name: "languageId")
  final String? languageId;
  final String userId;
  final String languageName;
  final String languageImage;

  const UserLanguageApiModel({
    this.languageId,
    required this.userId,
    required this.languageName,
    required this.languageImage,
  });

  factory UserLanguageApiModel.fromJson(Map<String, dynamic> json) =>
      _$UserLanguageApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserLanguageApiModelToJson(this);

  // Convert to Entity
  UserLanguagePreferenceEntity toEntity() {
    return UserLanguagePreferenceEntity(
      id: languageId ?? '',
      userId: userId,
      languageName: languageName,
      languageImage: languageImage,
    );
  }

  // Convert from Entity
  factory UserLanguageApiModel.fromEntity(UserLanguagePreferenceEntity entity) {
    return UserLanguageApiModel(
      languageId: entity.id,
      userId: entity.userId,
      languageName: entity.languageName,
      languageImage: entity.languageImage,
    );
  }

  @override
  List<Object?> get props => [languageId, userId, languageName, languageImage];
}