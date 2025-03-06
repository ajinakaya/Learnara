import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:learnara/app/usecase/usecase.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/features/courses/domain/entity/sublesson_entity.dart';
import 'package:learnara/features/courses/domain/repository/course_repository.dart';

class GetSubLessonByIdParams extends Equatable {
  final String subLessonId;

  const GetSubLessonByIdParams({required this.subLessonId});

  @override
  List<Object> get props => [subLessonId];
}

class GetSubLessonByIdUseCase implements UsecaseWithParams<SubLessonEntity, GetSubLessonByIdParams> {
  final ICourseRepository repository;

  GetSubLessonByIdUseCase(this.repository);

  @override
  Future<Either<Failure, SubLessonEntity>> call(GetSubLessonByIdParams params) async {
    return await repository.getSubLessonById(params.subLessonId);
  }
}