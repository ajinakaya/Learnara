import 'package:dartz/dartz.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/features/langauge/domain/entity/language_entity.dart';
import 'package:learnara/features/langauge/domain/entity/user_language_entity.dart';


abstract interface class ILanguageRepository {
  Future<Either<Failure, List<PreferredLanguageEntity>>> getAllLanguages();

  Future<Either<Failure, void>> setUserPreferredLanguage(UserLanguagePreferenceEntity entity);

  Future<Either<Failure, UserLanguagePreferenceEntity>> getUserPreferredLanguage(String userId);
}
