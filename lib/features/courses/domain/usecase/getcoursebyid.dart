import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:learnara/app/usecase/usecase.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/features/courses/domain/entity/course_entity.dart';
import 'package:learnara/features/courses/domain/repository/course_repository.dart';

class GetCourseByIdParams extends Equatable {
  final String courseId;

  const GetCourseByIdParams({required this.courseId});

  @override
  List<Object> get props => [courseId];
}

class GetCourseByIdUseCase implements UsecaseWithParams<CourseEntity, GetCourseByIdParams> {
  final ICourseRepository repository;

  GetCourseByIdUseCase(this.repository);

  @override
  Future<Either<Failure, CourseEntity>> call(GetCourseByIdParams params) async {
    return await repository.getCourseById(params.courseId);
  }
}