import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:learnara/app/usecase/usecase.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/features/langauge/domain/entity/user_language_entity.dart';
import 'package:learnara/features/langauge/domain/repository/language_repository.dart';

class GetUserPreferredLanguageParams extends Equatable {
  final String userId;

  const GetUserPreferredLanguageParams({
    required this.userId,
  });

  // Initial Constructor
  const GetUserPreferredLanguageParams.initial() : userId = '';

  @override
  List<Object> get props => [userId];
}

class GetUserPreferredLanguageUseCase
    implements UsecaseWithParams<UserLanguagePreferenceEntity, GetUserPreferredLanguageParams> {
  final ILanguageRepository repository;

  GetUserPreferredLanguageUseCase(this.repository);

  @override
  Future<Either<Failure, UserLanguagePreferenceEntity>> call(
      GetUserPreferredLanguageParams params) {
    return repository.getUserPreferredLanguage(params.userId);
  }
}