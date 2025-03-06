import 'package:hive_flutter/adapters.dart';
import 'package:learnara/app/constants/hive_table_constant.dart';
import 'package:learnara/features/Activitytype/data/model/audio/audio_hive_model.dart';
import 'package:learnara/features/Activitytype/data/model/flashcard/flashcard_hive_model.dart';
import 'package:learnara/features/Activitytype/data/model/quiz/quiz_hive_model.dart';
import 'package:learnara/features/auth/data/model/auth_hive_model.dart';
import 'package:learnara/features/courses/data/model/chapter_hive_model.dart';
import 'package:learnara/features/courses/data/model/course_hive_model.dart';
import 'package:learnara/features/courses/data/model/sublesson_hive_model.dart';
import 'package:learnara/features/langauge/data/model/language_hive_model.dart';
import 'package:learnara/features/langauge/data/model/user_language_hive_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Future<void> init() async {
    //Initalizing the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}learnara.db';

    Hive.init(path);

    Hive.registerAdapter(AuthHiveModelAdapter());
    // Register language adapters
    Hive.registerAdapter(LanguageHiveModelAdapter());
    Hive.registerAdapter(UserLanguageHiveModelAdapter());
  }

  Future<void> register(AuthHiveModel auth) async {
    var box = await Hive.openBox<AuthHiveModel>(HIveTableConstant.userBox);
    await box.put(auth.userId, auth);
  }

  Future<void> deleteAuth(String id) async {
    var box = await Hive.openBox<AuthHiveModel>(HIveTableConstant.userBox);
    await box.delete(id);
  }


  // Login using email and password
  Future<AuthHiveModel?> login(String email, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HIveTableConstant.userBox);
    var auth = box.values.firstWhere(
            (element) =>
        element.email == email && element.password == password,
        orElse: () => const AuthHiveModel.initial());
    return auth;
  }

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HIveTableConstant.userBox);
  }

  // Clear User Box
  Future<void> clearUserBox() async {
    await Hive.deleteBoxFromDisk(HIveTableConstant.userBox);
  }

  Future<void> close() async {
    await Hive.close();
  }

  // For getting all languages
  Future<List<LanguageHiveModel>> getAllLanguages() async {
    var box = await Hive.openBox<LanguageHiveModel>(
        HIveTableConstant.languageBox);
    return box.values.toList();
  }

// For getting a specific user's preferred language
  Future<UserLanguageHiveModel> getUserPreferredLanguage(String userId) async {
    var box = await Hive.openBox<UserLanguageHiveModel>(
        HIveTableConstant.userLanguageBox);
    var preference = box.values.firstWhere(
            (element) => element.userId == userId,
        orElse: () =>
        throw Exception('No preferred language found for user: $userId')
    );
    return preference;
  }

// For setting a user's preferred language
  Future<void> setUserPreferredLanguage(UserLanguageHiveModel model) async {
    var box = await Hive.openBox<UserLanguageHiveModel>(
        HIveTableConstant.userLanguageBox);

    // Check if user already has a preference
    var existingPreferences = box.values.where((element) =>
    element.userId == model.userId).toList();

    if (existingPreferences.isNotEmpty) {
      // Get the key for the existing preference
      var key = box.keyAt(
          box.values.toList().indexOf(existingPreferences.first));
      // Update it
      await box.put(key, model);
    } else {
      // Add new preference
      await box.add(model);
    }
  }

  Future<List<FlashcardHiveModel>> getAllFlashcards(String? language) async {
    var box = await Hive.openBox<FlashcardHiveModel>(
        HIveTableConstant.flashcardActivityBox);

    // If language is provided, filter flashcards by language
    if (language != null) {
      return box.values.where((flashcard) => flashcard.language == language)
          .toList();
    }

    // If no language specified, return all flashcards
    return box.values.toList();
  }


  Future<List<QuizHiveModel>> getAllQuizzes(String? language) async {
    var box = await Hive.openBox<QuizHiveModel>(
        HIveTableConstant.quizActivityBox);

    if (language != null) {
      return box.values.where((quiz) => quiz.language == language).toList();
    }

    return box.values.toList();
  }


  Future<List<AudioHiveModel>> getAllAudioActivities(String? language) async {
    var box = await Hive.openBox<AudioHiveModel>(
        HIveTableConstant.audioActivityBox);

    if (language != null) {
      return box.values.where((audio) => audio.language == language).toList();
    }

    return box.values.toList();
  }

  Future<List<CourseHiveModel>> getAllCourses(String? language) async {
    var box = await Hive.openBox<CourseHiveModel>(
        HIveTableConstant.courseTableBox);

    if (language != null) {
      return box.values.where((course) => course.language == language).toList();
    }

    return box.values.toList();
  }

  Future<List<ChapterHiveModel>> getAllChapters() async {
    var box = await Hive.openBox<ChapterHiveModel>(
        HIveTableConstant.chapterTableBox);

    return box.values.toList();
  }

  Future<List<SubLessonHiveModel>> getAllSubLessons(String? language) async {
    var box = await Hive.openBox<SubLessonHiveModel>(
        HIveTableConstant.subLessonTableBox);

    if (language != null) {
      return box.values.where((subLesson) => subLesson.language == language)
          .toList();
    }

    return box.values.toList();
  }

  Future<CourseHiveModel> getCourseById(String courseId) async {
    var box = await Hive.openBox<CourseHiveModel>(
        HIveTableConstant.courseTableBox);

    // Find the course by matching its unique identifier
    var course = box.values.firstWhere(
          (course) => course.id == courseId,
      orElse: () => throw Exception('Course not found with ID: $courseId'),
    );

    return course;
  }

  Future<ChapterHiveModel> getChapterById(String chapterId) async {
    var box = await Hive.openBox<ChapterHiveModel>(
        HIveTableConstant.chapterTableBox);

    // Find the chapter by matching its unique identifier
    var chapter = box.values.firstWhere(
          (chapter) => chapter.id == chapterId,
      orElse: () => throw Exception('Chapter not found with ID: $chapterId'),
    );

    return chapter;
  }

  Future<SubLessonHiveModel> getSubLessonById(String subLessonId) async {
    var box = await Hive.openBox<SubLessonHiveModel>(
        HIveTableConstant.subLessonTableBox);

    // Find the sublesson by matching its unique identifier
    var subLesson = box.values.firstWhere(
          (subLesson) => subLesson.id == subLessonId,
      orElse: () => throw Exception('SubLesson not found with ID: $subLessonId'),
    );

    return subLesson;
  }
}