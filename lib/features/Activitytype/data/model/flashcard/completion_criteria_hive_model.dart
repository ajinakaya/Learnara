import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:learnara/app/constants/hive_table_constant.dart';
import 'package:learnara/features/Activitytype/domain/entity/flashcard/completion_criteria_entity.dart';

part 'completion_criteria_hive_model.g.dart';


@HiveType(typeId: HIveTableConstant.completionCriteriaTableId)
class CompletionCriteriaHiveModel extends Equatable {
  @HiveField(0)
  final int cardsReviewed;

  @HiveField(1)
  final int minimumCorrect;

  const CompletionCriteriaHiveModel({
    required this.cardsReviewed,
    this.minimumCorrect = 80,
  });

  // Initial Constructor
  const CompletionCriteriaHiveModel.initial()
      : cardsReviewed = 0,
        minimumCorrect = 80;

  // From Entity
  factory CompletionCriteriaHiveModel.fromEntity(CompletionCriteria entity) {
    return CompletionCriteriaHiveModel(
      cardsReviewed: entity.cardsReviewed,
      minimumCorrect: entity.minimumCorrect,
    );
  }

  // To Entity
  CompletionCriteria toEntity() {
    return CompletionCriteria(
      cardsReviewed: cardsReviewed,
      minimumCorrect: minimumCorrect,
    );
  }

  @override
  List<Object?> get props => [cardsReviewed, minimumCorrect];
}