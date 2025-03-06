import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:learnara/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:learnara/features/auth/domain/usecase/login_usecase.dart';
import 'package:learnara/app/share_pref/token_share_pref.dart';
import 'package:learnara/features/home/presentation/view_model/home_cubit.dart';
import 'package:learnara/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:learnara/core/common/snack_bar/my_snackbar.dart';

class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}
class MockRegisterBloc extends Mock implements RegisterBloc {}
class MockHomeCubit extends Mock implements HomeCubit {}
class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  late LoginBloc loginBloc;
  late MockTokenSharedPrefs mockTokenSharedPrefs;
  late MockRegisterBloc mockRegisterBloc;
  late MockHomeCubit mockHomeCubit;
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    mockRegisterBloc = MockRegisterBloc();
    mockHomeCubit = MockHomeCubit();
    mockLoginUseCase = MockLoginUseCase();
    loginBloc = LoginBloc(
      tokenSharedPrefs: mockTokenSharedPrefs,
      registerBloc: mockRegisterBloc,
      homeCubit: mockHomeCubit,
      loginUseCase: mockLoginUseCase,
    );
  });

  group('LoginBloc', () {
    test('initial state is correct', () {
      expect(loginBloc.state, LoginState.initial());
    });

    blocTest<LoginBloc, LoginState>(
      'should emit [isLoading, isSuccess] when login is successful',
      build: () {
        when(() => mockLoginUseCase(any())).thenAnswer(
          (_) async => const Right('token'),
        );
        return loginBloc;
      },
      act: (bloc) => bloc.add(LoginUserEvent(
        context: MockBuildContext(),
        email: 'test@example.com',
        password: 'password',
      )),
      expect: () => [
        loginBloc.state.copyWith(isLoading: true),
        loginBloc.state.copyWith(isLoading: false, isSuccess: true),
      ],
      verify: (_) {
        verify(() => mockTokenSharedPrefs.saveToken('token')).called(1);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'should emit [isLoading, isSuccess] and show snack bar when login fails',
      build: () {
        when(() => mockLoginUseCase(any())).thenAnswer(
          (_) async => const Left(ApiFailure(message: 'Invalid credentials')),
        );
        return loginBloc;
      },
      act: (bloc) => bloc.add(LoginUserEvent(
        context: MockBuildContext(),
        email: 'wrong@example.com',
        password: 'wrongpassword',
      )),
      expect: () => [
        loginBloc.state.copyWith(isLoading: true),
        loginBloc.state.copyWith(isLoading: false, isSuccess: false),
      ],
      verify: (_) {
        // Check if showMySnackBar was called
        verify(() => showMySnackBar(
          context: any(named: 'context'),
          message: "Invalid Credentials",
          color: Colors.red,
        )).called(1);
      },
    );
  });
}

// A simple mock context for testing purposes
class MockBuildContext extends Mock implements BuildContext {}
