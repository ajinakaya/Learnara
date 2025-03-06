import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:learnara/app/di/di.dart';
import 'package:learnara/features/auth/presentation/view/login_view.dart';
import 'package:learnara/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:learnara/features/home/presentation/view_model/home_cubit.dart';
import 'package:learnara/features/home/presentation/view_model/home_state.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}
class MockLoginBloc extends Mock implements LoginBloc {}
class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late HomeCubit homeCubit;
  late MockNavigatorObserver navigatorObserver;
  late MockLoginBloc mockLoginBloc;

  setUp(() {
    homeCubit = HomeCubit();
    navigatorObserver = MockNavigatorObserver();
    mockLoginBloc = MockLoginBloc();

    // Setup GetIt for dependency injection
    final getIt = GetIt.instance;
    if (!GetIt.I.isRegistered<LoginBloc>()) {
      getIt.registerSingleton<LoginBloc>(mockLoginBloc);
    }
  });

  tearDown(() {
    homeCubit.close();
    // Reset GetIt instance if needed
    if (GetIt.I.isRegistered<LoginBloc>()) {
      getIt.unregister<LoginBloc>();
    }
  });

  group('HomeCubit Tests', () {
    test('initial state should be HomeState.initial()', () {
      expect(homeCubit.state, equals(HomeState.initial()));
    });

    blocTest<HomeCubit, HomeState>(
      'emits [HomeState with selectedIndex: 1] when onTabTapped is called with 1',
      build: () => homeCubit,
      act: (cubit) => cubit.onTabTapped(1),
      expect: () => [
        HomeState.initial().copyWith(selectedIndex: 1),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [HomeState with selectedIndex: 2] when onTabTapped is called with 2',
      build: () => homeCubit,
      act: (cubit) => cubit.onTabTapped(2),
      expect: () => [
        HomeState.initial().copyWith(selectedIndex: 2),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [HomeState with selectedIndex: 3] when onTabTapped is called with 3',
      build: () => homeCubit,
      act: (cubit) => cubit.onTabTapped(3),
      expect: () => [
        HomeState.initial().copyWith(selectedIndex: 3),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [HomeState with selectedIndex: 0] when onTabTapped is called with 0',
      build: () => homeCubit,
      act: (cubit) => cubit.onTabTapped(0),
      expect: () => [
        HomeState.initial().copyWith(selectedIndex: 0),
      ],
    );

    // For testing logout, we need a widget test since it involves navigation
    testWidgets('logout should navigate to LoginView after 2 seconds delay', 
        (WidgetTester tester) async {
      // Create a MockBuildContext
      final mockContext = MockBuildContext();
      
      // Create a test app with navigator and our HomeCubit
      await tester.pumpWidget(
        MaterialApp(
          navigatorObservers: [navigatorObserver],
          home: BlocProvider.value(
            value: homeCubit,
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () => homeCubit.logout(context),
                    child: const Text('Logout'),
                  );
                },
              ),
            ),
          ),
        ),
      );

      // Find and tap the logout button
      await tester.tap(find.text('Logout'));
      await tester.pump(); // Start the Future.delayed

      // Verify no navigation yet (before the delay)
      verifyNever(() => navigatorObserver.didPush(any(), any()));

      // Fast forward 2 seconds
      await tester.pump(const Duration(seconds: 2));
      
      // Now verify navigation occurred
      // Note: This verification is tricky in widget tests since we're using
      // Navigator.pushReplacement directly in the cubit
      expect(find.byType(LoginView), findsOneWidget);
    });
  });
}