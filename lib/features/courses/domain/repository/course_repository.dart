import 'package:dartz/dartz.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/features/courses/domain/entity/course_entity.dart';
import 'package:learnara/features/courses/domain/entity/chapter_entity.dart';
import 'package:learnara/features/courses/domain/entity/sublesson_entity.dart';

abstract interface class ICourseRepository {

  Future<Either<Failure, List<CourseEntity>>> getAllCourses(String? languageId);
  Future<Either<Failure, CourseEntity>> getCourseById(String courseId);
  Future<Either<Failure, List<ChapterEntity>>> getAllChapters();
  Future<Either<Failure, ChapterEntity>> getChapterById(String chapterId);
  Future<Either<Failure, List<SubLessonEntity>>> getAllSubLessons(String? languageId);
  Future<Either<Failure, SubLessonEntity>> getSubLessonById(String subLessonId);
}