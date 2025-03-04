import 'package:learnara/core/network/hive_service.dart';
import 'package:learnara/features/courses/data/data_source/course_data_source.dart';
import 'package:learnara/features/courses/domain/entity/course_entity.dart';
import 'package:learnara/features/courses/domain/entity/chapter_entity.dart';
import 'package:learnara/features/courses/domain/entity/sublesson_entity.dart';

class CourseLocalDataSource implements ICourseDataSource {
  final HiveService _hiveService;

  CourseLocalDataSource(this._hiveService);

  @override
  Future<List<CourseEntity>> getAllCourses(String? language) async {
    try {
      final courseModels = await _hiveService.getAllCourses(language);
      return courseModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<CourseEntity> getCourseById(String courseId) async {
    try {
      final courseModel = await _hiveService.getCourseById(courseId);
      return courseModel.toEntity();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<List<ChapterEntity>> getAllChapters() async {
    try {
      final chapterModels = await _hiveService.getAllChapters();
      return chapterModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<ChapterEntity> getChapterById(String chapterId) async {
    try {
      final chapterModel = await _hiveService.getChapterById(chapterId);
      return chapterModel.toEntity();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<List<SubLessonEntity>> getAllSubLessons(String? language) async {
    try {
      final subLessonModels = await _hiveService.getAllSubLessons(language);
      return subLessonModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<SubLessonEntity> getSubLessonById(String subLessonId) async {
    try {
      final subLessonModel = await _hiveService.getSubLessonById(subLessonId);
      return subLessonModel.toEntity();
    } catch (e) {
      return Future.error(e);
    }
  }
}