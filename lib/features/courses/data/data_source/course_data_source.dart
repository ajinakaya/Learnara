import 'package:learnara/features/courses/domain/entity/chapter_entity.dart';
import 'package:learnara/features/courses/domain/entity/course_entity.dart';
import 'package:learnara/features/courses/domain/entity/sublesson_entity.dart';

abstract interface class ICourseDataSource {
  Future<List<CourseEntity>> getAllCourses(String? language);
  Future<CourseEntity> getCourseById(String courseId);

  Future<List<ChapterEntity>> getAllChapters();
  Future<ChapterEntity> getChapterById(String chapterId);

  Future<List<SubLessonEntity>> getAllSubLessons(String? language);
  Future<SubLessonEntity> getSubLessonById(String subLessonId);
}