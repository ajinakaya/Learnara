import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:learnara/features/Activitytype/domain/entity/audio/audio_completion_criteria_entity.dart';
import 'package:learnara/features/Activitytype/domain/entity/audio/audio_entity.dart';
import 'package:learnara/features/langauge/data/model/language_api_model.dart';

part 'audio_api_model.g.dart';

@JsonSerializable()
class AudioApiModel extends Equatable {
  @JsonKey(name: "_id")
  final String? id;
  final LanguageApiModel language;
  final String title;
  final String description;
  final String audio;
  final int duration;
  final String? transcript;
  final String difficulty;
  final int order;

  final AudioCompletionCriteriaApiModel completionCriteria;

  const AudioApiModel({
    this.id,
    required this.language,
    required this.title,
    required this.description,
    required this.audio,
    required this.duration,
    this.transcript,
    this.difficulty = 'beginner',
    required this.order,
    required this.completionCriteria,
  });

  // Auto generates the json values (From Json)
  factory AudioApiModel.fromJson(Map<String, dynamic> json) =>
      _$AudioApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AudioApiModelToJson(this);

  // To Entity
  AudioEntity toEntity() {
    return AudioEntity(
      id: id,
      language: language.toEntity(),
      title: title,
      description: description,
      audio: audio,
      duration: duration,
      transcript: transcript,
      difficulty: difficulty,
      order: order,
      completionCriteria: completionCriteria.toEntity(),
    );
  }

  // From Entity
  factory AudioApiModel.fromEntity(AudioEntity entity) {
    return AudioApiModel(
      id: entity.id,
      language: LanguageApiModel.fromEntity(entity.language),
      title: entity.title,
      description: entity.description,
      audio: entity.audio,
      duration: entity.duration,
      transcript: entity.transcript,
      difficulty: entity.difficulty,
      order: entity.order,
      completionCriteria: AudioCompletionCriteriaApiModel.fromEntity(entity.completionCriteria),
    );
  }

  @override
  List<Object?> get props => [
    id,
    language,
    title,
    description,
    audio,
    duration,
    transcript,
    difficulty,
    order,
    completionCriteria,
  ];
}

@JsonSerializable()
class AudioCompletionCriteriaApiModel extends Equatable {
  final int listenPercentage;

  const AudioCompletionCriteriaApiModel({
    this.listenPercentage = 90,
  });

  // Auto generates the json values (From Json)
  factory AudioCompletionCriteriaApiModel.fromJson(Map<String, dynamic> json) =>
      _$AudioCompletionCriteriaApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AudioCompletionCriteriaApiModelToJson(this);

  // To Entity
  AudioCompletionCriteria toEntity() {
    return AudioCompletionCriteria(
      listenPercentage: listenPercentage,
    );
  }

  // From Entity
  factory AudioCompletionCriteriaApiModel.fromEntity(AudioCompletionCriteria entity) {
    return AudioCompletionCriteriaApiModel(
      listenPercentage: entity.listenPercentage,
    );
  }

  @override
  List<Object?> get props => [listenPercentage];
}