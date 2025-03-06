import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learnara/app/constants/hive_table_constant.dart';
import 'package:learnara/features/langauge/domain/entity/language_entity.dart';
import 'package:uuid/uuid.dart';

part 'language_hive_model.g.dart';

@HiveType(typeId: HIveTableConstant.languageTableId)
class LanguageHiveModel extends Equatable {
  @HiveField(0)
  final String languageId;
  @HiveField(1)
  final String languageName;
  @HiveField(2)
  final String languageImage;

  LanguageHiveModel({
    String? languageId,
    required this.languageName,
    required this.languageImage,
  }) : languageId = languageId ?? const Uuid().v4();

  // Initial Constructor
  const LanguageHiveModel.initial()
      : languageId = '',
        languageName = '',
        languageImage = '';

  // Convert from Entity to Hive Model
  factory LanguageHiveModel.fromEntity(PreferredLanguageEntity entity) {
    return LanguageHiveModel(
      languageId: entity.languageId,
      languageName: entity.languageName,
      languageImage: entity.languageImage,
    );
  }

  // Convert from Hive Model to Entity
  PreferredLanguageEntity toEntity() {
    return PreferredLanguageEntity(
      languageId: languageId,
      languageName: languageName,
      languageImage: languageImage,
    );
  }

  @override
  List<Object?> get props => [languageId, languageName, languageImage];
}
