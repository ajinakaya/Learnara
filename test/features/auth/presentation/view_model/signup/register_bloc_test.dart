import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/features/auth/domain/usecase/register_usecase.dart';
import 'package:learnara/features/auth/domain/usecase/upload_image_usecase.dart';
import 'package:learnara/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockRegisterUseCase extends Mock implements RegisterUseCase {}
class MockUploadImageUsecase extends Mock implements UploadImageUsecase {}
class MockBuildContext extends Mock implements BuildContext {}
class MockFile extends Mock implements File {}

void main() {
  late RegisterBloc registerBloc;
  late MockRegisterUseCase mockRegisterUseCase;
  late MockUploadImageUsecase mockUploadImageUsecase;
  late MockBuildContext mockContext;
  late MockFile mockFile;

  setUp(() {
    mockRegisterUseCase = MockRegisterUseCase();
    mockUploadImageUsecase = MockUploadImageUsecase();
    mockContext = MockBuildContext();
    mockFile = MockFile();

    registerBloc = RegisterBloc(
      registerUseCase: mockRegisterUseCase,
      uploadImageUsecase: mockUploadImageUsecase,
    );

    // Register fallback values for any() matchers
    registerFallbackValue(RegisterUserParams(
      fullname: 'Test User',
      email: 'test@example.com',
      image: 'test.jpg',
      username: 'testuser',
      password: 'password123',
    ));
    
    registerFallbackValue(UploadImageParams(file: mockFile));
  });

  tearDown(() {
    registerBloc.close();
  });

  group('RegisterBloc Tests', () {
    test('initial state should be RegisterState.initial()', () {
      expect(registerBloc.state, equals(RegisterState.initial()));
    });

    group('RegisterUser event', () {
      blocTest<RegisterBloc, RegisterState>(
        'emits [loading, success] when registration is successful',
        build: () {
          when(() => mockRegisterUseCase.call(any()))
              .thenAnswer((_) async => const Right(null));
          return registerBloc;
        },
        act: (bloc) => bloc.add(RegisterUser(
          context: mockContext,
          fullname: 'Test User',
          email: 'test@example.com',
          image: 'test.jpg',
          username: 'testuser',
          password: 'password123',
        )),
        expect: () => [
          RegisterState.initial().copyWith(isLoading: true),
          RegisterState.initial().copyWith(isLoading: false, isSuccess: true),
        ],
      );

      blocTest<RegisterBloc, RegisterState>(
        'emits [loading, failure] when registration fails',
        build: () {
          when(() => mockRegisterUseCase.call(any()))
              .thenAnswer((_) async => const Left(ApiFailure(message: 'Registration failed')));
          return registerBloc;
        },
        act: (bloc) => bloc.add(RegisterUser(
          context: mockContext,
          fullname: 'Test User',
          email: 'test@example.com',
          image: 'test.jpg',
          username: 'testuser',
          password: 'password123',
        )),
        expect: () => [
          RegisterState.initial().copyWith(isLoading: true),
          RegisterState.initial().copyWith(isLoading: false, isSuccess: false),
        ],
      );
    });

    group('UploadImage event', () {
      blocTest<RegisterBloc, RegisterState>(
        'emits [loading, success with imageName] when image upload is successful',
        build: () {
          when(() => mockUploadImageUsecase.call(any()))
              .thenAnswer((_) async => const Right('uploaded_image.jpg'));
          return registerBloc;
        },
        act: (bloc) => bloc.add(UploadImage(file: mockFile)),
        expect: () => [
          RegisterState.initial().copyWith(isLoading: true),
          RegisterState.initial().copyWith(
            isLoading: false, 
            isSuccess: true, 
            imageName: 'uploaded_image.jpg'
          ),
        ],
      );

      blocTest<RegisterBloc, RegisterState>(
        'emits [loading, failure] when image upload fails',
        build: () {
          when(() => mockUploadImageUsecase.call(any()))
              .thenAnswer((_) async => const Left(ApiFailure(message: 'Upload failed')));
          return registerBloc;
        },
        act: (bloc) => bloc.add(UploadImage(file: mockFile)),
        expect: () => [
          RegisterState.initial().copyWith(isLoading: true),
          RegisterState.initial().copyWith(isLoading: false, isSuccess: false),
        ],
      );
    });
  });
}