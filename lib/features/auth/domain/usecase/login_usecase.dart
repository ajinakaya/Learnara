import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:learnara/app/usecase/usecase.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/features/auth/domain/repository/auth_repository.dart';


class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });

  // Initial Constructor
  const LoginParams.initial()
      : email = '',
        password = '';

  @override
  List<Object> get props => [email, password];
}

class LoginUseCase implements UsecaseWithParams<String, LoginParams> {
  final IAuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(LoginParams params) {

    return repository.loginUser(params.email, params.password);
  }
}
