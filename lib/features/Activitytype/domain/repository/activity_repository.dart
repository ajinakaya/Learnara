import 'package:dartz/dartz.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/features/Activitytype/domain/entity/audio/audio_entity.dart';
import 'package:learnara/features/Activitytype/domain/entity/flashcard/flashcard_entity.dart';
import 'package:learnara/features/Activitytype/domain/entity/quiz/quiz_entity.dart';


abstract interface class IActivityRepository {
  Future<Either<Failure, List<FlashcardEntity>>> getAllFlashcards(String? language);
  Future<Either<Failure, List<QuizEntity>>> getAllQuizzes(String? language);
  Future<Either<Failure, List<AudioEntity>>> getAllAudioActivities(String? language);
}