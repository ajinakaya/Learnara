import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learnara/app/constants/api_endpoint.dart';
import 'package:learnara/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:learnara/features/auth/domain/entity/auth_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late AuthRemoteDatasource authRemoteDataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    authRemoteDataSource = AuthRemoteDatasource(mockDio);
  });

  group('AuthRemoteDataSource Tests', () {
    test('registerUser should call API and return nothing on success', () async {
      final user = AuthEntity(
        fullname: 'John Doe',
        email: 'test@example.com',
        image: 'image.png',
        role: 'user',
        username: 'johndoe',
        password: 'password123',
      );

      final responseMock = Response(
        requestOptions: RequestOptions(path: ApiEndpoints.register),
        statusCode: 200,
      );

      when(() => mockDio.post(ApiEndpoints.register, data: any(named: 'data')))
          .thenAnswer((_) async => responseMock);

      await authRemoteDataSource.registerUser(user);

      verify(() => mockDio.post(ApiEndpoints.register, data: any(named: 'data')))
          .called(1);
    });

    test('registerUser should throw an error when the response status is not 200', () async {
      final user = AuthEntity(
        fullname: 'John Doe',
        email: 'test@example.com',
        image: 'image.png',
        role: 'user',
        username: 'johndoe',
        password: 'password123',
      );

      final responseMock = Response(
        requestOptions: RequestOptions(path: ApiEndpoints.register),
        statusCode: 400,
        statusMessage: 'Bad Request',
      );

      when(() => mockDio.post(ApiEndpoints.register, data: any(named: 'data')))
          .thenAnswer((_) async => responseMock);

      expect(
        () async => await authRemoteDataSource.registerUser(user),
        throwsA(isA<Exception>()),
      );
    });

    test('loginUser should return token on successful login', () async {
      final email = 'test@example.com';
      final password = 'password123';

      when(() => mockDio.post(ApiEndpoints.login, data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                statusCode: 200,
                data: {'token': 'mockToken'},
                requestOptions: RequestOptions(path: ApiEndpoints.login),
              ));

      final result = await authRemoteDataSource.loginUser(email, password);

      expect(result, 'mockToken');
      verify(() => mockDio.post(ApiEndpoints.login, data: any(named: 'data')))
          .called(1);
    });

    test('loginUser should throw Exception on failed login', () async {
      final email = 'test@example.com';
      final password = 'wrongPassword';

      when(() => mockDio.post(ApiEndpoints.login, data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                statusCode: 400,
                requestOptions: RequestOptions(path: ApiEndpoints.login),
              ));

      expect(
        () => authRemoteDataSource.loginUser(email, password),
        throwsA(isA<Exception>()),
      );
    });
//  test('uploadProfilePicture should throw Exception on failure', () async {
//       final file = File('path/to/file');
 
//       when(() => mockDio.post(any(), data: any(named: 'data')))
//           .thenAnswer((_) async => Response(
//                 statusCode: 400,
//                 requestOptions: RequestOptions(path: ''),
//               ));
 
//       expect(
//         () => authRemoteDataSource.uploadProfilePicture(file),
//         throwsA(isA<Exception>()),
//       );
//     });
  });
}
