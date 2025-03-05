part of 'course_bloc.dart';

enum CourseStatus { initial, loading, loaded, error }

class CourseState {
  final List<CourseEntity> courses;
  final List<ChapterEntity> chapters;
  final List<SubLessonEntity> subLessons;
  final CourseStatus coursesStatus;
  final CourseStatus chaptersStatus;
  final CourseStatus subLessonsStatus;
  final String? errorMessage;

  CourseState({
    required this.courses,
    required this.chapters,
    required this.subLessons,
    required this.coursesStatus,
    required this.chaptersStatus,
    required this.subLessonsStatus,
    this.errorMessage,
  });

  CourseState.initial()
      : courses = [],
        chapters = [],
        subLessons = [],
        coursesStatus = CourseStatus.initial,
        chaptersStatus = CourseStatus.initial,
        subLessonsStatus = CourseStatus.initial,
        errorMessage = null;

  CourseState copyWith({
    List<CourseEntity>? courses,
    List<ChapterEntity>? chapters,
    List<SubLessonEntity>? subLessons,
    CourseStatus? coursesStatus,
    CourseStatus? chaptersStatus,
    CourseStatus? subLessonsStatus,
    String? errorMessage,
  }) {
    return CourseState(
      courses: courses ?? this.courses,
      chapters: chapters ?? this.chapters,
      subLessons: subLessons ?? this.subLessons,
      coursesStatus: coursesStatus ?? this.coursesStatus,
      chaptersStatus: chaptersStatus ?? this.chaptersStatus,
      subLessonsStatus: subLessonsStatus ?? this.subLessonsStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}