import 'package:json_annotation/json_annotation.dart';
import 'package:learnara/features/langauge/data/model/language_api_model.dart';

part 'language_dto.g.dart';

@JsonSerializable()
class LanguageDto {
  final List<LanguageApiModel> data;

  LanguageDto({required this.data});

  factory LanguageDto.fromJson(List<dynamic> jsonList) {
    return LanguageDto(
      data: jsonList.map((item) => LanguageApiModel.fromJson(item)).toList(),
    );
  }

  List<Map<String, dynamic>> toJson() =>
      data.map((item) => item.toJson()).toList();
}
