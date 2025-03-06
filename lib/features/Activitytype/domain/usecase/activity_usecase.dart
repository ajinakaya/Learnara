import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:learnara/app/usecase/usecase.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/features/Activitytype/domain/repository/activity_repository.dart';
import 'package:learnara/features/Activitytype/domain/entity/flashcard/flashcard_entity.dart';
import 'package:learnara/features/Activitytype/domain/entity/quiz/quiz_entity.dart';
import 'package:learnara/features/Activitytype/domain/entity/audio/audio_entity.dart';

// Params for filtering activities
class ActivityFilterParams extends Equatable {
  final String? language;

  const ActivityFilterParams({this.language});

  // Initial Constructor
  const ActivityFilterParams.initial() : language = null;

  @override
  List<Object?> get props => [language];
}

// Use Case for Fetching Flashcards
class GetAllFlashcardsUseCase implements UsecaseWithParams<List<FlashcardEntity>, ActivityFilterParams> {
  final IActivityRepository repository;

  GetAllFlashcardsUseCase(this.repository);

  @override
  Future<Either<Failure, List<FlashcardEntity>>> call(ActivityFilterParams params) {
    return repository.getAllFlashcards(params.language);
  }
}

// Use Case for Fetching Quizzes
class GetAllQuizzesUseCase implements UsecaseWithParams<List<QuizEntity>, ActivityFilterParams> {
  final IActivityRepository repository;

  GetAllQuizzesUseCase(this.repository);

  @override
  Future<Either<Failure, List<QuizEntity>>> call(ActivityFilterParams params) {
    return repository.getAllQuizzes(params.language);
  }
}

// Use Case for Fetching Audio Activities
class GetAllAudioActivitiesUseCase implements UsecaseWithParams<List<AudioEntity>, ActivityFilterParams> {
  final IActivityRepository repository;

  GetAllAudioActivitiesUseCase(this.repository);

  @override
  Future<Either<Failure, List<AudioEntity>>> call(ActivityFilterParams params) {
    return repository.getAllAudioActivities(params.language);
  }
}