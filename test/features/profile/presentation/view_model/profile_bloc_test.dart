import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/features/auth/domain/entity/auth_entity.dart';
import 'package:learnara/features/profile/domain/use_case/get_current_user_usecase.dart';
import 'package:learnara/features/profile/presentation/view_model/profile_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCurrentUserUseCase extends Mock implements GetCurrentUserUseCase {}

void main() {
  late ProfileBloc profileBloc;
  late MockGetCurrentUserUseCase mockGetCurrentUserUseCase;

  setUp(() {
    mockGetCurrentUserUseCase = MockGetCurrentUserUseCase();
    profileBloc = ProfileBloc(
      getCurrentUserUseCase: mockGetCurrentUserUseCase,
    );
  });

  tearDown(() {
    profileBloc.close();
  });

  group('ProfileBloc Tests', () {
    test('initial state should be ProfileState.initial()', () {
      expect(profileBloc.state, equals(ProfileState.initial()));
    });

    group('GetCurrentUser event', () {
      final testUser = AuthEntity(
        id: '1',
        username: 'testuser',
        email: 'test@example.com',
        fullname: 'Test User',
        image: 'profile.jpg', password: '',
      );

      blocTest<ProfileBloc, ProfileState>(
        'emits [loading, user data] when getting current user is successful',
        build: () {
          when(() => mockGetCurrentUserUseCase())
              .thenAnswer((_) async => Right(testUser));
          return profileBloc;
        },
        act: (bloc) => bloc.add(const GetCurrentUser()),
        expect: () => [
          ProfileState.initial().copyWith(isLoading: true),
          ProfileState.initial().copyWith(
            isLoading: false,
            user: testUser,
            errorMessage: null,
          ),
        ],
        verify: (_) {
          verify(() => mockGetCurrentUserUseCase()).called(1);
        },
      );

      blocTest<ProfileBloc, ProfileState>(
        'emits [loading, error] when getting current user fails',
        build: () {
          when(() => mockGetCurrentUserUseCase())
              .thenAnswer((_) async => const Left(ApiFailure(message: 'Failed to get user')));
          return profileBloc;
        },
        act: (bloc) => bloc.add(const GetCurrentUser()),
        expect: () => [
          ProfileState.initial().copyWith(isLoading: true),
          ProfileState.initial().copyWith(
            isLoading: false,
            errorMessage: 'Failed to get user',
          ),
        ],
        verify: (_) {
          verify(() => mockGetCurrentUserUseCase()).called(1);
        },
      );
    });
  });
}