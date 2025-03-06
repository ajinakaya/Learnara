import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learnara/app/constants/hive_table_constant.dart';
import 'package:learnara/features/Activitytype/domain/entity/flashcard/card_data_entity.dart';

part 'card_data_hive_model.g.dart';


@HiveType(typeId: HIveTableConstant.cardDataTableId)
class CardDataHiveModel extends Equatable {
  @HiveField(0)
  final String front;

  @HiveField(1)
  final String back;

  @HiveField(2)
  final String? hint;

  @HiveField(3)
  final String? example;

  const CardDataHiveModel({
    required this.front,
    required this.back,
    this.hint,
    this.example,
  });

  // From Entity
  factory CardDataHiveModel.fromEntity(CardData entity) {
    return CardDataHiveModel(
      front: entity.front,
      back: entity.back,
      hint: entity.hint,
      example: entity.example,
    );
  }

  // To Entity
  CardData toEntity() {
    return CardData(
      front: front,
      back: back,
      hint: hint,
      example: example,
    );
  }

  @override
  List<Object?> get props => [front, back, hint, example];
}
