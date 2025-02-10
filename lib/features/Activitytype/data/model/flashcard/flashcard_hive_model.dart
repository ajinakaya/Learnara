import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:learnara/app/constants/hive_table_constant.dart';
import 'package:learnara/features/Activitytype/data/model/flashcard/card_data_hive_model.dart';
import 'package:learnara/features/Activitytype/data/model/flashcard/completion_criteria_hive_model.dart';
import 'package:learnara/features/Activitytype/domain/entity/flashcard/flashcard_entity.dart';
import 'package:learnara/features/langauge/domain/entity/language_entity.dart';
import 'package:uuid/uuid.dart';

part 'flashcard_hive_model.g.dart';


@HiveType(typeId: HIveTableConstant.flashcardActivityTableId)
class FlashcardHiveModel extends Equatable {
  @HiveField(0)
  final String? flashcardId;

  @HiveField(1)
  final PreferredLanguageEntity language;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final List<CardDataHiveModel> cards;

  @HiveField(5)
  final String difficulty;

  @HiveField(6)
  final int order;

  @HiveField(7)
  final CompletionCriteriaHiveModel completionCriteria;

  FlashcardHiveModel({
    String? flashcardId,
    required this.language,
    required this.title,
    required this.description,
    required this.cards,
    this.difficulty = 'beginner',
    required this.order,
    required this.completionCriteria,
  }) : flashcardId = flashcardId ?? const Uuid().v4();

  // Initial Constructor
  const FlashcardHiveModel.initial()
      : flashcardId = '',
        language = const PreferredLanguageEntity(languageId: '', languageName: '', languageImage: ''),
      title = '',
        description = '',
        cards = const [],
        difficulty = 'beginner',
        order = 0,
        completionCriteria = const CompletionCriteriaHiveModel.initial();

  // From Entity
  factory FlashcardHiveModel.fromEntity(FlashcardEntity entity) {
    return FlashcardHiveModel(
      flashcardId: entity.id,
      language: entity.language,
      title: entity.title,
      description: entity.description,
      cards: entity.cards.map((card) => CardDataHiveModel.fromEntity(card)).toList(),
      difficulty: entity.difficulty,
      order: entity.order,
      completionCriteria: CompletionCriteriaHiveModel.fromEntity(entity.completionCriteria),
    );
  }

  // To Entity
  FlashcardEntity toEntity() {
    return FlashcardEntity(
      id: flashcardId,
      language: language,
      title: title,
      description: description,
      cards: cards.map((card) => card.toEntity()).toList(),
      difficulty: difficulty,
      order: order,
      completionCriteria: completionCriteria.toEntity(),
    );
  }

  @override
  List<Object?> get props => [
    flashcardId,
    language,
    title,
    description,
    cards,
    difficulty,
    order,
    completionCriteria,
  ];
}


