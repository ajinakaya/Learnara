import 'package:flutter_test/flutter_test.dart';
import 'package:learnara/features/courses/domain/usecase/getchapterbyid.dart';
import 'package:learnara/features/courses/domain/usecase/getcoursebyid.dart';
import 'package:learnara/features/courses/domain/usecase/getsublessonbyid.dart';
import 'package:mocktail/mocktail.dart';
import 'package:learnara/features/courses/domain/entity/course_entity.dart';
import 'package:learnara/features/courses/domain/entity/chapter_entity.dart';
import 'package:learnara/features/courses/domain/entity/sublesson_entity.dart';
import 'package:learnara/features/courses/domain/usecase/getallcourse.dart';
import 'package:learnara/features/courses/domain/usecase/getallchapter.dart';
import 'package:learnara/features/courses/domain/usecase/getallsublesson.dart';
import 'package:learnara/features/courses/presentation/view_model/course_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:learnara/core/error/failure.dart';

// Mocks
class MockGetAllCoursesUseCase extends Mock implements GetAllCoursesUseCase {}
class MockGetCourseByIdUseCase extends Mock implements GetCourseByIdUseCase {}
class MockGetAllChaptersUseCase extends Mock implements GetAllChaptersUseCase {}
class MockGetChapterByIdUseCase extends Mock implements GetChapterByIdUseCase {}
class MockGetAllSubLessonsUseCase extends Mock implements GetAllSubLessonsUseCase {}
class MockGetSubLessonByIdUseCase extends Mock implements GetSubLessonByIdUseCase {}

void main() {
  late MockGetAllCoursesUseCase mockGetAllCoursesUseCase;
  late MockGetCourseByIdUseCase mockGetCourseByIdUseCase;
  late MockGetAllChaptersUseCase mockGetAllChaptersUseCase;
  late MockGetChapterByIdUseCase mockGetChapterByIdUseCase;
  late MockGetAllSubLessonsUseCase mockGetAllSubLessonsUseCase;
  late MockGetSubLessonByIdUseCase mockGetSubLessonByIdUseCase;
  late CourseBloc courseBloc;

  setUp(() {
    mockGetAllCoursesUseCase = MockGetAllCoursesUseCase();
    mockGetCourseByIdUseCase = MockGetCourseByIdUseCase();
    mockGetAllChaptersUseCase = MockGetAllChaptersUseCase();
    mockGetChapterByIdUseCase = MockGetChapterByIdUseCase();
    mockGetAllSubLessonsUseCase = MockGetAllSubLessonsUseCase();
    mockGetSubLessonByIdUseCase = MockGetSubLessonByIdUseCase();

    courseBloc = CourseBloc(
      getAllCoursesUseCase: mockGetAllCoursesUseCase,
      getCourseByIdUseCase: mockGetCourseByIdUseCase,
      getAllChaptersUseCase: mockGetAllChaptersUseCase,
      getChapterByIdUseCase: mockGetChapterByIdUseCase,
      getAllSubLessonsUseCase: mockGetAllSubLessonsUseCase,
      getSubLessonByIdUseCase: mockGetSubLessonByIdUseCase,
    );
  });

  group('CourseBloc', () {
    // Mocked data
    final CourseEntity mockCourse = CourseEntity(id: 1, id: 'Course 1');
    final ChapterEntity mockChapter = ChapterEntity(id: 1, title: 'Chapter 1');
    final SubLessonEntity mockSubLesson = SubLessonEntity(id: 1, title: 'SubLesson 1');

    test('should emit success when fetching all courses is successful', () async {
      when(() => mockGetAllCoursesUseCase(any())).thenAnswer(
            (_) async => Right([mockCourse]),
      );

      courseBloc.add(FetchCoursesEvent());

      await expectLater(
        courseBloc.stream,
        emitsInOrder([
          CourseState(coursesStatus: CourseStatus.loading, courses: [], chapters: [], subLessons: []),
          CourseState(coursesStatus: CourseStatus.loaded, courses: [mockCourse], chapters: [], subLessons: []),
        ]),
      );
    });

    test('should emit error when fetching all courses fails', () async {
      when(() => mockGetAllCoursesUseCase(any())).thenAnswer(
            (_) async => Left(ApiFailure(message: 'Failed to fetch courses')),
      );

      courseBloc.add(FetchCoursesEvent());

      await expectLater(
        courseBloc.stream,
        emitsInOrder([
          CourseState(coursesStatus: CourseStatus.loading),
          CourseState(
            coursesStatus: CourseStatus.error,
            errorMessage: 'Failed to fetch courses',
            courses: [],
            chapters: [],
            subLessons: [],
          ),
        ]),
      );
    });

    test('should emit success when fetching chapters is successful', () async {
      when(() => mockGetAllChaptersUseCase(any())).thenAnswer(
            (_) async => Right([mockChapter]),
      );

      courseBloc.add(FetchChaptersEvent());

          CourseState(chaptersStatus: CourseStatus.loading, courses: [], chapters: [], subLessons: []),
          CourseState(chaptersStatus: CourseStatus.loaded, courses: [], chapters: [mockChapter], subLessons: []),
        emitsInOrder([
          CourseState(chaptersStatus: CourseStatus.loading),
          CourseState(chaptersStatus: CourseStatus.loaded, chapters: [mockChapter]),
        ]),
      );
    });

    test('should emit error when fetching chapters fails', () async {
      when(() => mockGetAllChaptersUseCase(any())).thenAnswer(
            (_) async => Left(ApiFailure(message: 'Failed to fetch chapters')),
      );

      courseBloc.add(FetchChaptersEvent());

      await expectLater(
          CourseState(
            chaptersStatus: CourseStatus.error,
            errorMessage: 'Failed to fetch chapters',
            courses: [],
            chapters: [],
            subLessons: [],
          ),
            chaptersStatus: CourseStatus.error,
            errorMessage: 'Failed to fetch chapters',
          ),
        ]),
      );
    });

    test('should emit success when fetching sub-lessons is successful', () async {
      when(() => mockGetAllSubLessonsUseCase(any())).thenAnswer(
            (_) async => Right([mockSubLesson]),
      );
          CourseState(subLessonsStatus: CourseStatus.loading, courses: [], chapters: [], subLessons: []),
          CourseState(subLessonsStatus: CourseStatus.loaded, courses: [], chapters: [], subLessons: [mockSubLesson]),

      await expectLater(
        courseBloc.stream,
        emitsInOrder([
          CourseState(subLessonsStatus: CourseStatus.loading),
          CourseState(subLessonsStatus: CourseStatus.loaded, subLessons: [mockSubLesson]),
        ]),
      );
    });

    test('should emit error when fetching sub-lessons fails', () async {
      when(() => mockGetAllSubLessonsUseCase(any())).thenAnswer(
            (_) async => Left(ApiFailure(message: 'Failed to fetch sub-lessons')),
      );

          CourseState(
            subLessonsStatus: CourseStatus.error,
            errorMessage: 'Failed to fetch sub-lessons',
            courses: [],
            chapters: [],
            subLessons: [],
          ),
        emitsInOrder([
          CourseState(subLessonsStatus: CourseStatus.loading, courses: [], chapters: [], subLessons: []),
          CourseState(
            subLessonsStatus: CourseStatus.error,
            errorMessage: 'Failed to fetch sub-lessons',
          ),
        ]),
      );
    });

    test('should emit success when fetching course by ID is successful', () async {
      when(() => mockGetCourseByIdUseCase(any())).thenAnswer(
            (_) async => Right(mockCourse),
      );

      courseBloc.add(FetchCourseByIdEvent(courseId: 1));

      await expectLater(
        courseBloc.stream,
        emitsInOrder([
          CourseState(coursesStatus: CourseStatus.loading),
          CourseState(coursesStatus: CourseStatus.loaded, courses: [mockCourse]),
        ]),
      );
    });

    test('should emit error when fetching course by ID fails', () async {
      when(() => mockGetCourseByIdUseCase(any())).thenAnswer(
          CourseState(
            coursesStatus: CourseStatus.error,
            errorMessage: 'Failed to fetch course by ID',
            courses: [],
            chapters: [],
            subLessons: [],
          ),

      await expectLater(
        courseBloc.stream,
        emitsInOrder([
          CourseState(coursesStatus: CourseStatus.loading),
          CourseState(
            coursesStatus: CourseStatus.error,
            errorMessage: 'Failed to fetch course by ID',
          ),
        ]),
      );
    });
  });
}
