import 'dart:io';
 
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:learnara/features/auth/data/repository/remote_repository/auth_remote_repository.dart';
import 'package:learnara/features/auth/domain/entity/auth_entity.dart';
import 'package:mocktail/mocktail.dart';

 
class MockAuthRemoteDataSource extends Mock implements AuthRemoteDatasource {}
 
void main() {
  late AuthRemoteRepository repository;
  late MockAuthRemoteDataSource mockDataSource;
 
  setUp(() {
    mockDataSource = MockAuthRemoteDataSource();
    repository = AuthRemoteRepository(mockDataSource);
  });
 
  group('loginUser', () {
    const email = 'test@example.com';
    const password = 'password123';
 
    test('should return success message when login is successful', () async {
      when(() => mockDataSource.loginUser(email, password))
          .thenAnswer((_) async => 'Login Successful');
 
      final result = await repository.loginUser(email, password);
 
      expect(result, const Right("Login Successful"));
      verify(() => mockDataSource.loginUser(email, password)).called(1);
    });
 
    test('should return failure when login fails', () async {
      when(() => mockDataSource.loginUser(email, password))
          .thenThrow(Exception('Login failed'));
 
      final result = await repository.loginUser(email, password);
 
      expect(result, Left(ApiFailure(message: 'Exception: Login failed')));
      verify(() => mockDataSource.loginUser(email, password)).called(1);
    });
  });
 
  group('registerUser', () {
    final user = AuthEntity(
      email: 'test@example.com',
      username: 'testUser',
      password: 'password123',
      role: 'user',
      image: 'profile.png',
      fullname: 'tester',
    );
 
    test('should return Right(null) when registration is successful', () async {
      when(() => mockDataSource.registerUser(user)).thenAnswer((_) async {});
 
      final result = await repository.registerUser(user);
 
      expect(result, const Right(null));
      verify(() => mockDataSource.registerUser(user)).called(1);
    });
 
    test('should return failure when registration fails', () async {
      when(() => mockDataSource.registerUser(user))
          .thenThrow(Exception('Registration failed'));
 
      final result = await repository.registerUser(user);
 
      expect(result, Left(ApiFailure(message: 'Exception: Registration failed')));
      verify(() => mockDataSource.registerUser(user)).called(1);
    });
  });
 
  group('uploadProfilePicture', () {
    final file = File('path/to/file.png');
 
    test('should return image name when upload is successful', () async {
      when(() => mockDataSource.uploadProfilePicture(file))
          .thenAnswer((_) async => 'uploaded_image.png');
 
      final result = await repository.uploadProfilePicture(file);
 
      expect(result, const Right('uploaded_image.png'));
      verify(() => mockDataSource.uploadProfilePicture(file)).called(1);
    });
 
    test('should return failure when upload fails', () async {
      when(() => mockDataSource.uploadProfilePicture(file))
          .thenThrow(Exception('Upload failed'));
 
      final result = await repository.uploadProfilePicture(file);
 
      expect(result, Left(ApiFailure(message: 'Exception: Upload failed')));
      verify(() => mockDataSource.uploadProfilePicture(file)).called(1);
    });
  });
}