// First file - GetAllChaptersUseCase
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:learnara/app/usecase/usecase.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/features/courses/domain/entity/chapter_entity.dart';
import 'package:learnara/features/courses/domain/repository/course_repository.dart';

class GetAllChaptersParams extends Equatable {
  const GetAllChaptersParams();

  @override
  List get props => [];
}

class GetAllChaptersUseCase implements UsecaseWithParams<List<ChapterEntity>, GetAllChaptersParams> {
  final ICourseRepository repository;

  GetAllChaptersUseCase(this.repository);

  @override
  Future<Either<Failure, List<ChapterEntity>>> call(GetAllChaptersParams params) async {
    return await repository.getAllChapters();
  }
}