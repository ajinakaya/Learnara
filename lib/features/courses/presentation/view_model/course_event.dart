part of 'course_bloc.dart';

sealed class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object?> get props => [];
}

class FetchCoursesEvent extends CourseEvent {
  // No parameters needed
  const FetchCoursesEvent();

}

class FetchChaptersEvent extends CourseEvent {
  const FetchChaptersEvent();
}

class FetchSubLessonsEvent extends CourseEvent {
  final PreferredLanguageEntity? language;

  const FetchSubLessonsEvent({this.language});

  @override
  List<Object?> get props => [language];
}

class FetchCourseByIdEvent extends CourseEvent {
  final String courseId;

  const FetchCourseByIdEvent({required this.courseId});

  @override
  List<Object?> get props => [courseId];
}

class FetchChapterByIdEvent extends CourseEvent {
  final String chapterId;

  const FetchChapterByIdEvent({required this.chapterId});

  @override
  List<Object?> get props => [chapterId];
}

class FetchSubLessonByIdEvent extends CourseEvent {
  final String subLessonId;

  const FetchSubLessonByIdEvent({required this.subLessonId});

  @override
  List<Object?> get props => [subLessonId];
}