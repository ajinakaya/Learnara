import 'package:equatable/equatable.dart';
import 'package:learnara/features/Activitytype/domain/entity/flashcard/card_data_entity.dart';
import 'package:learnara/features/Activitytype/domain/entity/flashcard/completion_criteria_entity.dart';
import 'package:learnara/features/langauge/domain/entity/language_entity.dart';

class FlashcardEntity extends Equatable {
  final String? id;
  final PreferredLanguageEntity language;
  final String title;
  final String description;
  final List<CardData> cards;
  final String difficulty;
  final int order;
  final CompletionCriteria completionCriteria;

  const FlashcardEntity({
    this.id,
    required this.language,
    required this.title,
    required this.description,
    required this.cards,
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
    cards,
    difficulty,
    order,
    completionCriteria,
  ];
}

