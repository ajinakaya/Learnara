import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:learnara/app/usecase/usecase.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/features/courses/domain/entity/course_entity.dart';
import 'package:learnara/features/courses/domain/repository/course_repository.dart';

// Remove language parameter from GetAllCoursesParams
class GetAllCoursesParams extends Equatable {
  const GetAllCoursesParams();

  @override
  List<Object?> get props => [];
}

class GetAllCoursesUseCase implements UsecaseWithParams<List<CourseEntity>, GetAllCoursesParams> {
  final ICourseRepository repository;

  GetAllCoursesUseCase(this.repository);

  @override
  Future<Either<Failure, List<CourseEntity>>> call(GetAllCoursesParams params) async {
    // Pass null to fetch all courses
    return await repository.getAllCourses(null);
  }
}