import 'package:learnara/core/network/hive_service.dart';
import 'package:learnara/features/langauge/data/data_source/language_data_source.dart';
import 'package:learnara/features/langauge/data/data_source/local_data_source/language_local_datasource.dart';
import 'package:learnara/features/langauge/data/model/user_language_hive_model.dart';
import 'package:learnara/features/langauge/domain/entity/language_entity.dart';
import 'package:learnara/features/langauge/domain/entity/user_language_entity.dart';

class LanguageLocalDataSource implements ILanguageDataSource {
  final HiveService _hiveService;

  LanguageLocalDataSource(this._hiveService);

  @override
  Future<List<PreferredLanguageEntity>> getAllLanguages() async {
    try {
      final languages = await _hiveService.getAllLanguages();
      return languages.map((model) => model.toEntity()).toList();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> setUserPreferredLanguage(UserLanguagePreferenceEntity entity) async {
    try {
      // Convert entity to hive model
      final userLanguageHiveModel = UserLanguageHiveModel.fromEntity(entity);

      await _hiveService.setUserPreferredLanguage(userLanguageHiveModel);
      return Future.value();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<UserLanguagePreferenceEntity> getUserPreferredLanguage(String userId) async {
    try {
      final userLanguage = await _hiveService.getUserPreferredLanguage(userId);
      return userLanguage.toEntity();
    } catch (e) {
      return Future.error(e);
    }
  }
}