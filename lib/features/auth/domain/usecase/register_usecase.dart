import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:learnara/app/usecase/usecase.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/features/auth/domain/repository/auth_repository.dart';

import '../entity/auth_entity.dart';


class RegisterUserParams extends Equatable {
  final String fullname;
  final String email;
  final String username;
  final String password;

  const RegisterUserParams({
    required this.fullname,
    required this.email,
    required this.username,
    required this.password,
  });

  //intial constructor
  const RegisterUserParams.initial({
    required this.fullname,
    required this.email,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props =>
      [fullname, email, username, password];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      fullname: params.fullname,
      email: params.email,
      username: params.username,
      password: params.password,
    );
    return repository.registerUser(authEntity);
  }
}
