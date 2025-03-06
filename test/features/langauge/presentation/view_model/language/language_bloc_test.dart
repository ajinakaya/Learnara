import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/core/network/api_service.dart';
import 'package:learnara/features/langauge/domain/entity/language.dart';
import 'package:learnara/features/langauge/domain/usecase/get_all_languages_usecase.dart';
import 'package:learnara/features/langauge/domain/usecase/get_user_preferred_language_usecase.dart';
import 'package:learnara/features/langauge/domain/usecase/set_user_preferred_language_usecase.dart';
import 'package:learnara/features/langauge/presentation/view_model/language/language_bloc.dart';

import 'package:mocktail/mocktail.dart';

class MockGetAllLanguagesUseCase extends Mock implements GetAllLanguagesUseCase {}
class MockSetUserPreferredLanguageUseCase extends Mock implements SetUserPreferredLanguageUseCase {}
class MockGetUserPreferredLanguageUseCase extends Mock implements GetUserPreferredLanguageUseCase {}
class MockApiService extends Mock implements ApiService {}

void main() {
  late LanguageBloc languageBloc;
  late MockGetAllLanguagesUseCase mockGetAllLanguagesUseCase;
  late MockSetUserPreferredLanguageUseCase mockSetUserPreferredLanguageUseCase;
  late MockGetUserPreferredLanguageUseCase mockGetUserPreferredLanguageUseCase;
  late MockApiService mockApiService;

  setUp(() {
    mockGetAllLanguagesUseCase = MockGetAllLanguagesUseCase();
    mockSetUserPreferredLanguageUseCase = MockSetUserPreferredLanguageUseCase();
    mockGetUserPreferredLanguageUseCase = MockGetUserPreferredLanguageUseCase();
    mockApiService = MockApiService();

    languageBloc = LanguageBloc(
      getAllLanguagesUseCase: mockGetAllLanguagesUseCase,
      setUserPreferredLanguageUseCase: mockSetUserPreferredLanguageUseCase,
      getUserPreferredLanguageUseCase: mockGetUserPreferredLanguageUseCase,
      apiService: mockApiService,
    );

    // Register fallback values for params
    registerFallbackValue(const SetUserPreferredLanguageParams(
      userLanguage: UserLanguageEntity(id: '1', userId: '1', languageId: '1'),
    ));
    
    registerFallbackValue(const GetUserPreferredLanguageParams(userId: '1'));
  });

  tearDown(() {
    languageBloc.close();
  });

  group('LanguageBloc Tests', () {
    test('initial state should be LanguageState.initial()', () {
      expect(languageBloc.state, equals(LanguageState.initial()));
    });

    group('LoadLanguages event', () {
      final testLanguages = [
        const LanguageEntity(id: '1', name: 'English', code: 'en'),
        const LanguageEntity(id: '2', name: 'Spanish', code: 'es'),
      ];

      blocTest<LanguageBloc, LanguageState>(
        'emits [loading, languages loaded] when loading languages is successful',
        build: () {
          when(() => mockGetAllLanguagesUseCase.call())
              .thenAnswer((_) async => Right(testLanguages));
          return languageBloc;
        },
        act: (bloc) => bloc.add( LoadLanguages()),
        expect: () => [
          LanguageState.initial().copyWith(isLoading: true),
          LanguageState.initial().copyWith(
            isLoading: false,
            languages: testLanguages,
            error: null,
          ),
        ],
        verify: (_) {
          verify(() => mockGetAllLanguagesUseCase.call()).called(1);
        },
      );

      blocTest<LanguageBloc, LanguageState>(
        'emits [loading, error] when loading languages fails',
        build: () {
          when(() => mockGetAllLanguagesUseCase.call())
              .thenAnswer((_) async => const Left(ApiFailure(message: 'Failed to load languages')));
          return languageBloc;
        },
        act: (bloc) => bloc.add( LoadLanguages()),
        expect: () => [
          LanguageState.initial().copyWith(isLoading: true),
          LanguageState.initial().copyWith(
            isLoading: false,
            error: 'Failed to load languages',
          ),
        ],
        verify: (_) {
          verify(() => mockGetAllLanguagesUseCase.call()).called(1);
        },
      );
    });

    group('SetUserLanguage event', () {
      final testUserLanguage = const UserLanguage(
        id: '1',
        userId: 'user1',
        languageId: 'lang1',
      );

      blocTest<LanguageBloc, LanguageState>(
        'emits [loading, language set] when setting user language preference is successful',
        build: () {
          when(() => mockSetUserPreferredLanguageUseCase.call(any()))
              .thenAnswer((_) async => const Right(null));
          return languageBloc;
        },
        act: (bloc) => bloc.add(SetUserLanguage(languagePreference: testUserLanguage)),
        expect: () => [
          LanguageState.initial().copyWith(isLoading: true),
          LanguageState.initial().copyWith(
            isLoading: false,
            userLanguagePreference: testUserLanguage,
            error: null,
          ),
        ],
        verify: (_) {
          verify(() => mockSetUserPreferredLanguageUseCase.call(
            SetUserPreferredLanguageParams(userLanguage: testUserLanguage),
          )).called(1);
        },
      );

      blocTest<LanguageBloc, LanguageState>(
        'emits [loading, error] when setting user language preference fails',
        build: () {
          when(() => mockSetUserPreferredLanguageUseCase.call(any()))
              .thenAnswer((_) async => const Left(ApiFailure(message: 'Failed to set language')));
          return languageBloc;
        },
        act: (bloc) => bloc.add(SetUserLanguage(languagePreference: testUserLanguage)),
        expect: () => [
          LanguageState.initial().copyWith(isLoading: true),
          LanguageState.initial().copyWith(
            isLoading: false,
            error: 'Failed to set language',
          ),
        ],
        verify: (_) {
          verify(() => mockSetUserPreferredLanguageUseCase.call(
            SetUserPreferredLanguageParams(userLanguage: testUserLanguage),
          )).called(1);
        },
      );
    });

    group('GetUserLanguage event', () {
      const userId = 'user1';
      final testUserLanguage = const UserLanguageEntity(
        id: '1',
        userId: 'user1',
        languageId: 'lang1',
      );

      blocTest<LanguageBloc, LanguageState>(
        'emits [loading, language loaded] when getting user language preference is successful',
        build: () {
          when(() => mockGetUserPreferredLanguageUseCase.call(any()))
              .thenAnswer((_) async => Right(testUserLanguage));
          return languageBloc;
        },
        act: (bloc) => bloc.add(const GetUserLanguage(userId)),
        expect: () => [
          LanguageState.initial().copyWith(isLoading: true),
          LanguageState.initial().copyWith(
            isLoading: false,
            userLanguagePreference: testUserLanguage,
            error: null,
          ),
        ],
        verify: (_) {
          verify(() => mockGetUserPreferredLanguageUseCase.call(
            const GetUserPreferredLanguageParams(userId: userId),
          )).called(1);
        },
      );

      blocTest<LanguageBloc, LanguageState>(
        'emits [loading, error] when getting user language preference fails',
        build: () {
          when(() => mockGetUserPreferredLanguageUseCase.call(any()))
              .thenAnswer((_) async => const Left(ApiFailure(message: 'Failed to get language')));
          return languageBloc;
        },
        act: (bloc) => bloc.add(GetUserLanguage(userId)),
        expect: () => [
          LanguageState.initial().copyWith(isLoading: true),
          LanguageState.initial().copyWith(
            isLoading: false,
            error: 'Failed to get language',
          ),
        ],
        verify: (_) {
          verify(() => mockGetUserPreferredLanguageUseCase.call(
            const GetUserPreferredLanguageParams(userId: userId),
          )).called(1);
        },
      );
    });

    group('SetLanguageToken event', () {
      const testToken = 'test_token';

      blocTest<LanguageBloc, LanguageState>(
        'calls apiService.setToken with correct token',
        build: () {
          when(() => mockApiService.setToken(any())).thenReturn(null);
          return languageBloc;
        },
        act: (bloc) => bloc.add(const SetLanguageToken(token: testToken)),
        expect: () => [], // No state changes expected
        verify: (_) {
          verify(() => mockApiService.setToken(testToken)).called(1);
        },
      );
    });
  });
}

class UserLanguageEntity {
  const UserLanguageEntity();
}

class UserLanguage {
  const UserLanguage();
}