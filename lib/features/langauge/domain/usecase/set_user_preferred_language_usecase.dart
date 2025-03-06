import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:learnara/app/usecase/usecase.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/features/langauge/domain/entity/user_language_entity.dart';
import 'package:learnara/features/langauge/domain/repository/language_repository.dart';

class SetUserPreferredLanguageParams extends Equatable {
  final UserLanguagePreferenceEntity userLanguage;

  const SetUserPreferredLanguageParams({
    required this.userLanguage,
  });


  static final initial = SetUserPreferredLanguageParams(
      userLanguage: const UserLanguagePreferenceEntity(
          id: '',
          userId: '',
          languageName: '',
          languageImage: '')
  );

  @override
  List<Object> get props => [userLanguage];
}

class SetUserPreferredLanguageUseCase
    implements UsecaseWithParams<void, SetUserPreferredLanguageParams> {
  final ILanguageRepository repository;

  SetUserPreferredLanguageUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(SetUserPreferredLanguageParams params) {
    return repository.setUserPreferredLanguage(params.userLanguage);
  }
}