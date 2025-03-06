import 'package:dartz/dartz.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/features/langauge/data/data_source/local_data_source/language_local_datasource.dart';
import 'package:learnara/features/langauge/domain/entity/language_entity.dart';
import 'package:learnara/features/langauge/domain/entity/user_language_entity.dart';
import 'package:learnara/features/langauge/domain/repository/language_repository.dart';


class LanguageLocalRepository implements ILanguageRepository {
  final LanguageLocalDataSource _languageLocalDataSource;

  LanguageLocalRepository(this._languageLocalDataSource);

  @override
  Future<Either<Failure, List<PreferredLanguageEntity>>> getAllLanguages() async {
    try {
      final languages = await _languageLocalDataSource.getAllLanguages();
      return Right(languages);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setUserPreferredLanguage(UserLanguagePreferenceEntity entity) async {
    try {
      await _languageLocalDataSource.setUserPreferredLanguage(entity);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserLanguagePreferenceEntity>> getUserPreferredLanguage(String userId) async {
    try {
      final preference = await _languageLocalDataSource.getUserPreferredLanguage(userId);
      return Right(preference);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}
