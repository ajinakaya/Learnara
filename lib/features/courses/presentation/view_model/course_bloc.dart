import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnara/features/courses/domain/entity/course_entity.dart';
import 'package:learnara/features/courses/domain/entity/chapter_entity.dart';
import 'package:learnara/features/courses/domain/entity/sublesson_entity.dart';
import 'package:learnara/features/courses/domain/usecase/getallchapter.dart';
import 'package:learnara/features/courses/domain/usecase/getallcourse.dart';
import 'package:learnara/features/courses/domain/usecase/getallsublesson.dart';
import 'package:learnara/features/courses/domain/usecase/getchapterbyid.dart';
import 'package:learnara/features/courses/domain/usecase/getcoursebyid.dart';
import 'package:learnara/features/courses/domain/usecase/getsublessonbyid.dart';
import 'package:learnara/features/langauge/domain/entity/language_entity.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final GetAllCoursesUseCase _getAllCoursesUseCase;
  final GetCourseByIdUseCase _getCourseByIdUseCase;
  final GetAllChaptersUseCase _getAllChaptersUseCase;
  final GetChapterByIdUseCase _getChapterByIdUseCase;
  final GetAllSubLessonsUseCase _getAllSubLessonsUseCase;
  final GetSubLessonByIdUseCase _getSubLessonByIdUseCase;

  CourseBloc({
    required GetAllCoursesUseCase getAllCoursesUseCase,
    required GetCourseByIdUseCase getCourseByIdUseCase,
    required GetAllChaptersUseCase getAllChaptersUseCase,
    required GetChapterByIdUseCase getChapterByIdUseCase,
    required GetAllSubLessonsUseCase getAllSubLessonsUseCase,
    required GetSubLessonByIdUseCase getSubLessonByIdUseCase,
  })  : _getAllCoursesUseCase = getAllCoursesUseCase,
        _getCourseByIdUseCase = getCourseByIdUseCase,
        _getAllChaptersUseCase = getAllChaptersUseCase,
        _getChapterByIdUseCase = getChapterByIdUseCase,
        _getAllSubLessonsUseCase = getAllSubLessonsUseCase,
        _getSubLessonByIdUseCase = getSubLessonByIdUseCase,
        super(CourseState.initial()) {

    // Fetch Courses
    on<FetchCoursesEvent>((event, emit) async {
      emit(state.copyWith(coursesStatus: CourseStatus.loading));

      final result = await _getAllCoursesUseCase(
          GetAllCoursesParams()  // Use the new constructor without language
      );

      result.fold(
              (failure) => emit(state.copyWith(
              coursesStatus: CourseStatus.error,
              errorMessage: failure.toString()
          )),
              (courses) => emit(state.copyWith(
              coursesStatus: CourseStatus.loaded,
              courses: courses
          ))
      );
    });
    // Fetch Course by ID
    on<FetchCourseByIdEvent>((event, emit) async {
      emit(state.copyWith(coursesStatus: CourseStatus.loading));

      final result = await _getCourseByIdUseCase(
          GetCourseByIdParams(courseId: event.courseId)
      );

      result.fold(
              (failure) => emit(state.copyWith(
              coursesStatus: CourseStatus.error,
              errorMessage: failure.toString()
          )),
              (course) => emit(state.copyWith(
              coursesStatus: CourseStatus.loaded,
              courses: [course]
          ))
      );
    });

    // Fetch Chapters
    on<FetchChaptersEvent>((event, emit) async {
      emit(state.copyWith(chaptersStatus: CourseStatus.loading));

      final result = await _getAllChaptersUseCase(const GetAllChaptersParams());

      result.fold(
              (failure) => emit(state.copyWith(
              chaptersStatus: CourseStatus.error,
              errorMessage: failure.toString()
          )),
              (chapters) => emit(state.copyWith(
              chaptersStatus: CourseStatus.loaded,
              chapters: chapters
          ))
      );
    });

    // Fetch SubLessons
    on<FetchSubLessonsEvent>((event, emit) async {
      emit(state.copyWith(subLessonsStatus: CourseStatus.loading));

      final result = await _getAllSubLessonsUseCase(
          GetAllSubLessonsParams(language: event.language?.languageName)
      );

      result.fold(
              (failure) => emit(state.copyWith(
              subLessonsStatus: CourseStatus.error,
              errorMessage: failure.toString()
          )),
              (subLessons) => emit(state.copyWith(
              subLessonsStatus: CourseStatus.loaded,
              subLessons: subLessons
          ))
      );
    });
    // Fetch Chapter by ID
    on<FetchChapterByIdEvent>((event, emit) async {
      emit(state.copyWith(chaptersStatus: CourseStatus.loading));

      final result = await _getChapterByIdUseCase(
          GetChapterByIdParams(chapterId: event.chapterId)
      );

      result.fold(
              (failure) => emit(state.copyWith(
              chaptersStatus: CourseStatus.error,
              errorMessage: failure.toString()
          )),
              (chapter) => emit(state.copyWith(
              chaptersStatus: CourseStatus.loaded,
              chapters: [chapter]
          ))
      );
    });

    // Fetch SubLesson by ID
    on<FetchSubLessonByIdEvent>((event, emit) async {
      emit(state.copyWith(subLessonsStatus: CourseStatus.loading));

      final result = await _getSubLessonByIdUseCase(
          GetSubLessonByIdParams(subLessonId: event.subLessonId)
      );

      result.fold(
              (failure) => emit(state.copyWith(
              subLessonsStatus: CourseStatus.error,
              errorMessage: failure.toString()
          )),
              (subLesson) => emit(state.copyWith(
              subLessonsStatus: CourseStatus.loaded,
              subLessons: [subLesson]
          ))
      );
    });
  }
}