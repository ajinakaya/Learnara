import 'package:dartz/dartz.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/features/Activitytype/data/data_source/activity_data_source.dart';
import 'package:learnara/features/Activitytype/domain/entity/audio/audio_entity.dart';
import 'package:learnara/features/Activitytype/domain/entity/flashcard/flashcard_entity.dart';
import 'package:learnara/features/Activitytype/domain/entity/quiz/quiz_entity.dart';
import 'package:learnara/features/Activitytype/domain/repository/activity_repository.dart';

class ActivityLocalRepository implements IActivityRepository {
  final IActivityDataSource _activityLocalDataSource;

  ActivityLocalRepository(this._activityLocalDataSource);

  @override
  Future<Either<Failure, List<FlashcardEntity>>> getAllFlashcards(String? language) async {
    try {
      final flashcards = await _activityLocalDataSource.getAllFlashcards(language);
      return Right(flashcards);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<QuizEntity>>> getAllQuizzes(String? language) async {
    try {
      final quizzes = await _activityLocalDataSource.getAllQuizzes(language);
      return Right(quizzes);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AudioEntity>>> getAllAudioActivities(String? language) async {
    try {
      final audioActivities = await _activityLocalDataSource.getAllAudioActivities(language);
      return Right(audioActivities);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}