import 'package:learnara/features/langauge/domain/entity/language_entity.dart';
import 'package:learnara/features/langauge/domain/entity/user_language_entity.dart';

abstract interface class ILanguageDataSource {
  Future<List<PreferredLanguageEntity>> getAllLanguages();

  Future<void> setUserPreferredLanguage(UserLanguagePreferenceEntity entity);

  Future<UserLanguagePreferenceEntity> getUserPreferredLanguage(String userId);
}