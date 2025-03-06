import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:learnara/app/usecase/usecase.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/features/courses/domain/entity/chapter_entity.dart';
import 'package:learnara/features/courses/domain/repository/course_repository.dart';

class GetChapterByIdParams extends Equatable {
  final String chapterId;

  const GetChapterByIdParams({required this.chapterId});

  @override
  List<Object> get props => [chapterId];
}

class GetChapterByIdUseCase implements UsecaseWithParams<ChapterEntity, GetChapterByIdParams> {
  final ICourseRepository repository;

  GetChapterByIdUseCase(this.repository);

  @override
  Future<Either<Failure, ChapterEntity>> call(GetChapterByIdParams params) async {
    return await repository.getChapterById(params.chapterId);
  }
}