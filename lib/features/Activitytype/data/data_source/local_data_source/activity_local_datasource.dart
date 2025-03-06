import 'package:learnara/core/network/hive_service.dart';
import 'package:learnara/features/Activitytype/data/data_source/activity_data_source.dart';
import 'package:learnara/features/Activitytype/domain/entity/audio/audio_entity.dart';
import 'package:learnara/features/Activitytype/domain/entity/flashcard/flashcard_entity.dart';
import 'package:learnara/features/Activitytype/domain/entity/quiz/quiz_entity.dart';

class ActivityLocalDataSource implements IActivityDataSource {
  final HiveService _hiveService;

  ActivityLocalDataSource(this._hiveService);

  @override
  Future<List<FlashcardEntity>> getAllFlashcards(String? language) async {
    try {
      final flashcardModels = await _hiveService.getAllFlashcards(language);
      return flashcardModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<List<QuizEntity>> getAllQuizzes(String? language) async {
    try {
      final quizModels = await _hiveService.getAllQuizzes(language);
      return quizModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<List<AudioEntity>> getAllAudioActivities(String? language) async {
    try {
      final audioModels = await _hiveService.getAllAudioActivities(language);
      return audioModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      return Future.error(e);
    }
  }
}