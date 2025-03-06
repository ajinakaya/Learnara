import 'package:equatable/equatable.dart';
import 'package:learnara/features/langauge/domain/entity/language_entity.dart';
import 'package:learnara/features/Activitytype/domain/entity/audio/audio_completion_criteria_entity.dart';

class AudioEntity extends Equatable {
  final String? id;
  final PreferredLanguageEntity language;
  final String title;
  final String description;
  final String audio;
  final int duration;
  final String? transcript;
  final String difficulty;
  final int order;
  final AudioCompletionCriteria completionCriteria;

  const AudioEntity({
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