import 'package:dartz/dartz.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/features/courses/data/data_source/course_data_source.dart';
import 'package:learnara/features/courses/domain/entity/course_entity.dart';
import 'package:learnara/features/courses/domain/entity/chapter_entity.dart';
import 'package:learnara/features/courses/domain/entity/sublesson_entity.dart';
import 'package:learnara/features/courses/domain/repository/course_repository.dart';

class CourseRemoteRepository implements ICourseRepository {
  final ICourseDataSource _courseRemoteDataSource;

  CourseRemoteRepository(this._courseRemoteDataSource);

  @override
  Future<Either<Failure, List<CourseEntity>>> getAllCourses(String? language) async {
    try {
      final courses = await _courseRemoteDataSource.getAllCourses(language);
      return Right(courses);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, CourseEntity>> getCourseById(String courseId) async {
    try {
      final course = await _courseRemoteDataSource.getCourseById(courseId);
      return Right(course);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<ChapterEntity>>> getAllChapters() async {
    try {
      final chapters = await _courseRemoteDataSource.getAllChapters();
      return Right(chapters);
    } catch (e) {
      return Left(
      ApiFailure(
        message: e.toString(),
      ),
    );
  }
  }
  @override
  Future<Either<Failure, ChapterEntity>> getChapterById(String chapterId) async {
    try {
      final chapter = await _courseRemoteDataSource.getChapterById(chapterId);
      return Right(chapter);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<SubLessonEntity>>> getAllSubLessons(String? language) async {
    try {
      final subLessons = await _courseRemoteDataSource.getAllSubLessons(language);
      return Right(subLessons);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, SubLessonEntity>> getSubLessonById(String subLessonId) async {
    try {
      final subLesson = await _courseRemoteDataSource.getSubLessonById(subLessonId);
      return Right(subLesson);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }
}