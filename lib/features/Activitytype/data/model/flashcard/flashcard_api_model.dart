import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:learnara/features/Activitytype/domain/entity/flashcard/flashcard_entity.dart';
import 'package:learnara/features/Activitytype/domain/entity/flashcard/card_data_entity.dart';
import 'package:learnara/features/Activitytype/domain/entity/flashcard/completion_criteria_entity.dart';
import 'package:learnara/features/langauge/data/model/language_api_model.dart';

part 'flashcard_api_model.g.dart';

@JsonSerializable()
class FlashcardApiModel extends Equatable {
  @JsonKey(name: "_id")
  final String? id;

  final LanguageApiModel language;
  final String title;
  final String description;

  @JsonKey(name: 'cards')
  final List<CardDataApiModel> cards;

  final String difficulty;
  final int order;

  final CompletionCriteriaApiModel completionCriteria;

  const FlashcardApiModel({
    this.id,
    required this.language,
    required this.title,
    required this.description,
    required this.cards,
    this.difficulty = 'beginner',
    required this.order,
    required this.completionCriteria,
  });

  // Auto generates the json values (From Json)
  factory FlashcardApiModel.fromJson(Map<String, dynamic> json) =>
      _$FlashcardApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$FlashcardApiModelToJson(this);

  // To Entity
  FlashcardEntity toEntity() {
    return FlashcardEntity(
      id: id,
      language: language.toEntity(),
      title: title,
      description: description,
      cards: cards.map((card) => card.toEntity()).toList(),
      difficulty: difficulty,
      order: order,
      completionCriteria: completionCriteria.toEntity(),
    );
  }

  // From Entity
  factory FlashcardApiModel.fromEntity(FlashcardEntity entity) {
    return FlashcardApiModel(
      id: entity.id,
      language: LanguageApiModel.fromEntity(entity.language),
      title: entity.title,
      description: entity.description,
      cards: entity.cards.map((card) => CardDataApiModel.fromEntity(card)).toList(),
      difficulty: entity.difficulty,
      order: entity.order,
      completionCriteria: CompletionCriteriaApiModel.fromEntity(entity.completionCriteria),
    );
  }

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

@JsonSerializable()
class CardDataApiModel extends Equatable {
  final String front;
  final String back;
  final String? hint;
  final String? example;

  const CardDataApiModel({
    required this.front,
    required this.back,
    this.hint,
    this.example,
  });

  // Auto generates the json values (From Json)
  factory CardDataApiModel.fromJson(Map<String, dynamic> json) =>
      _$CardDataApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CardDataApiModelToJson(this);

  // To Entity
  CardData toEntity() {
    return CardData(
      front: front,
      back: back,
      hint: hint,
      example: example,
    );
  }

  // From Entity
  factory CardDataApiModel.fromEntity(CardData entity) {
    return CardDataApiModel(
      front: entity.front,
      back: entity.back,
      hint: entity.hint,
      example: entity.example,
    );
  }

  @override
  List<Object?> get props => [front, back, hint, example];
}

@JsonSerializable()
class CompletionCriteriaApiModel extends Equatable {
  final int cardsReviewed;
  final int minimumCorrect;

  const CompletionCriteriaApiModel({
    required this.cardsReviewed,
    this.minimumCorrect = 80,
  });

  // Auto generates the json values (From Json)
  factory CompletionCriteriaApiModel.fromJson(Map<String, dynamic> json) =>
      _$CompletionCriteriaApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompletionCriteriaApiModelToJson(this);

  // To Entity
  CompletionCriteria toEntity() {
    return CompletionCriteria(
      cardsReviewed: cardsReviewed,
      minimumCorrect: minimumCorrect,
    );
  }

  // From Entity
  factory CompletionCriteriaApiModel.fromEntity(CompletionCriteria entity) {
    return CompletionCriteriaApiModel(
      cardsReviewed: entity.cardsReviewed,
      minimumCorrect: entity.minimumCorrect,
    );
  }

  @override
  List<Object?> get props => [cardsReviewed, minimumCorrect];
}