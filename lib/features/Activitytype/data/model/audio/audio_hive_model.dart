import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:learnara/app/constants/hive_table_constant.dart';
import 'package:learnara/features/Activitytype/domain/entity/audio/audio_completion_criteria_entity.dart';
import 'package:learnara/features/Activitytype/domain/entity/audio/audio_entity.dart';
import 'package:learnara/features/langauge/data/model/language_hive_model.dart';
import 'package:uuid/uuid.dart';

part 'audio_hive_model.g.dart';

@HiveType(typeId: HIveTableConstant.audioActivityTableId)
class AudioHiveModel extends Equatable {
  @HiveField(0)
  final String? audioId;

  @HiveField(1)
  final LanguageHiveModel language;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String audio;

  @HiveField(5)
  final int duration;

  @HiveField(6)
  final String? transcript;

  @HiveField(7)
  final String difficulty;

  @HiveField(8)
  final int order;

  @HiveField(9)
  final AudioCompletionCriteriaHiveModel completionCriteria;

  AudioHiveModel({
    String? audioId,
    required this.language,
    required this.title,
    required this.description,
    required this.audio,
    required this.duration,
    this.transcript,
    this.difficulty = 'beginner',
    required this.order,
    required this.completionCriteria,
  }) : audioId = audioId ?? const Uuid().v4();

  // Initial Constructor
  const AudioHiveModel.initial()
      : audioId = '',
        language = const LanguageHiveModel.initial(),
        title = '',
        description = '',
        audio = '',
        duration = 0,
        transcript = null,
        difficulty = 'beginner',
        order = 0,
        completionCriteria = const AudioCompletionCriteriaHiveModel.initial();

  // From Entity
  factory AudioHiveModel.fromEntity(AudioEntity entity) {
    return AudioHiveModel(
      audioId: entity.id,
      language: LanguageHiveModel.fromEntity(entity.language),
      title: entity.title,
      description: entity.description,
      audio: entity.audio,
      duration: entity.duration,
      transcript: entity.transcript,
      difficulty: entity.difficulty,
      order: entity.order,
      completionCriteria: AudioCompletionCriteriaHiveModel.fromEntity(entity.completionCriteria),
    );
  }

  // To Entity
  AudioEntity toEntity() {
    return AudioEntity(
      id: audioId,
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

  @override
  List<Object?> get props => [
    audioId,
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

@HiveType(typeId: HIveTableConstant.audioCompletionCriteriaTableId)
class AudioCompletionCriteriaHiveModel extends Equatable {
  @HiveField(0)
  final int listenPercentage;

  const AudioCompletionCriteriaHiveModel({
    this.listenPercentage = 90,
  });

  // Initial Constructor
  const AudioCompletionCriteriaHiveModel.initial()
      : listenPercentage = 90;

  // From Entity
  factory AudioCompletionCriteriaHiveModel.fromEntity(AudioCompletionCriteria entity) {
    return AudioCompletionCriteriaHiveModel(
      listenPercentage: entity.listenPercentage,
    );
  }

  // To Entity
  AudioCompletionCriteria toEntity() {
    return AudioCompletionCriteria(
      listenPercentage: listenPercentage,
    );
  }

  @override
  List<Object?> get props => [listenPercentage];
}