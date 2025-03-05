import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:learnara/app/usecase/usecase.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/features/courses/domain/entity/sublesson_entity.dart';
import 'package:learnara/features/courses/domain/repository/course_repository.dart';

class GetAllSubLessonsParams extends Equatable {
  final String? language;

  const GetAllSubLessonsParams({this.language});

  @override
  List<Object?> get props => [language];
}

class GetAllSubLessonsUseCase implements UsecaseWithParams<List<SubLessonEntity>, GetAllSubLessonsParams> {
  final ICourseRepository repository;

  GetAllSubLessonsUseCase(this.repository);

  @override
  Future<Either<Failure, List<SubLessonEntity>>> call(GetAllSubLessonsParams params) async {
    return await repository.getAllSubLessons(params.language);
  }
}