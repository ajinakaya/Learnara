import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/features/auth/domain/entity/auth_entity.dart';
import 'package:learnara/features/auth/domain/usecase/register_usecase.dart';

import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

class FakeAuthEntity extends Fake implements AuthEntity {}

void main() {
  late AuthRepoMock repository;
  late RegisterUseCase usecase;

  setUp(() {
    registerFallbackValue(FakeAuthEntity());
  });

  setUp(() {
    repository = AuthRepoMock();
    usecase = RegisterUseCase(repository);
  });

  testWidgets(
      'Should call the [repository.registerUser] wuth correct parameters',
      (tester) async {
    when(() => repository.registerUser(any()))
        .thenAnswer((_) async => const Right<Failure, void>(null));

    const params = RegisterUserParams(
      email: 'test@example.com',
      username: 'testuser',
      password: 'password123',
      image: 'image', 
      fullname: 'tester',
    );

    final result = await usecase(params);

    verify(() => repository.registerUser(any())).called(1);
    expect(result, const Right<Failure, void>(null));
  });

  tearDown(() {
    reset(repository);
});
}