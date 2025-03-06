import 'package:dartz/dartz.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/features/langauge/data/data_source/remote_datasource/language_remote_datasource.dart';
import 'package:learnara/features/langauge/domain/entity/language_entity.dart';
import 'package:learnara/features/langauge/domain/entity/user_language_entity.dart';
import 'package:learnara/features/langauge/domain/repository/language_repository.dart';

class LanguageRemoteRepository implements ILanguageRepository {
  final LanguageRemoteDataSource _languageRemoteDataSource;

  LanguageRemoteRepository(this._languageRemoteDataSource);

  @override
  Future<Either<Failure, List<PreferredLanguageEntity>>> getAllLanguages() async {
    try {
      final languages = await _languageRemoteDataSource.getAllLanguages();
      return Right(languages);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserLanguagePreferenceEntity>> getUserPreferredLanguage(String userId) async {
    try {
      final preference = await _languageRemoteDataSource.getUserPreferredLanguage(userId);
      return Right(preference);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> setUserPreferredLanguage(UserLanguagePreferenceEntity entity) async {
    try {
      await _languageRemoteDataSource.setUserPreferredLanguage(entity);
      return const Right(null);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }
}