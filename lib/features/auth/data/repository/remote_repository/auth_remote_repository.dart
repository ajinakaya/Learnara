import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:learnara/features/auth/domain/entity/auth_entity.dart';
import 'package:learnara/features/auth/domain/repository/auth_repository.dart';

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDatasource _authRemoteDatasource;

  AuthRemoteRepository(this._authRemoteDatasource);


  @override
  Future<Either<Failure, String>> loginUser(String email,
      String password) async {
    try {
      final token =
      await _authRemoteDatasource.loginUser(email, password);
      return Right(token);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user) async {
    try {
      _authRemoteDatasource.registerUser(user);
      return Right(null);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final imageName = await _authRemoteDatasource.uploadProfilePicture(file);
      return Right(imageName);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      final user = await _authRemoteDatasource.getCurrentUser();
      return Right(user);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }
}