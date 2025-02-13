import 'package:dartz/dartz.dart';
import 'package:learnara/app/usecase/usecase.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/features/langauge/domain/entity/language_entity.dart';
import 'package:learnara/features/langauge/domain/repository/language_repository.dart';

class GetAllLanguagesUseCase implements UsecaseWithoutParams<List<PreferredLanguageEntity>> {
  final ILanguageRepository repository;

  GetAllLanguagesUseCase(this.repository);

  @override
  Future<Either<Failure, List<PreferredLanguageEntity>>> call() {
    return repository.getAllLanguages();
  }
}