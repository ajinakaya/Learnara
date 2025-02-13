import 'package:json_annotation/json_annotation.dart';
import 'package:learnara/features/langauge/data/model/user_language_api_model.dart';

part 'user_language_dto.g.dart';

@JsonSerializable()
class UserLanguageDto {
  final bool success;
  final int count;
  final List<UserLanguageApiModel> data;

  UserLanguageDto({
    required this.success,
    required this.count,
    required this.data,
  });

  factory UserLanguageDto.fromJson(Map<String, dynamic> json) =>
      _$UserLanguageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserLanguageDtoToJson(this);
}
