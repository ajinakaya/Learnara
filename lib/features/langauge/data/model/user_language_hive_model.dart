import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learnara/app/constants/hive_table_constant.dart';
import 'package:learnara/features/langauge/domain/entity/user_language_entity.dart'; // Import the entity
import 'package:uuid/uuid.dart';

part 'user_language_hive_model.g.dart';

@HiveType(typeId: HIveTableConstant.userLanguageTableId)
class UserLanguageHiveModel extends Equatable {
  @HiveField(0)
  final String languageId;
  @HiveField(1)
  final String userId;
  @HiveField(2)
  final String languageName;
  @HiveField(3)
  final String languageImage;

  UserLanguageHiveModel({
    String? languageId,
    required this.userId,
    required this.languageName,
    required this.languageImage,
  }) : languageId = languageId ?? const Uuid().v4();

  // Initial Constructor
  const UserLanguageHiveModel.initial()
      : languageId = '',
        userId = '',
        languageName = '',
        languageImage = '';


  factory UserLanguageHiveModel.fromEntity(UserLanguagePreferenceEntity entity) {
    return UserLanguageHiveModel(
      languageId: entity.id,
      userId: entity.userId,
      languageName: entity.languageName,
      languageImage: entity.languageImage,
    );
  }


  UserLanguagePreferenceEntity toEntity() {
    return UserLanguagePreferenceEntity(
      id: languageId,
      userId: userId,
      languageName: languageName,
      languageImage: languageImage,
    );
  }

  @override
  List<Object?> get props => [languageId, userId, languageName, languageImage];
}
