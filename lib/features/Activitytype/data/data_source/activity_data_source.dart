import 'package:learnara/features/Activitytype/domain/entity/audio/audio_entity.dart';
import 'package:learnara/features/Activitytype/domain/entity/flashcard/flashcard_entity.dart';
import 'package:learnara/features/Activitytype/domain/entity/quiz/quiz_entity.dart';

abstract interface class IActivityDataSource {
  Future<List<FlashcardEntity>> getAllFlashcards(String? language);
  Future<List<QuizEntity>> getAllQuizzes(String? language);
  Future<List<AudioEntity>> getAllAudioActivities(String? language);
}
