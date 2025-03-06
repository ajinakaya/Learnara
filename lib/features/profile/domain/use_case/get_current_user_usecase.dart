import 'package:dartz/dartz.dart';
import 'package:learnara/app/usecase/usecase.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/features/auth/domain/entity/auth_entity.dart';
import 'package:learnara/features/auth/domain/repository/auth_repository.dart';

class GetCurrentUserUseCase implements UsecaseWithoutParams<AuthEntity> {
  final IAuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call() async {
    return await repository.getCurrentUser();
  }
}
