import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learnara/features/Activitytype/presentation/view/quiz.dart';
import 'package:learnara/features/Activitytype/presentation/view/quiz_detail_page.dart';
import 'package:learnara/features/Activitytype/presentation/view_model/activity/activity_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:learnara/features/Activitytype/domain/entity/quiz/quiz_entity.dart';

class MockActivityBloc extends MockBloc<ActivityEvent, ActivityState> implements ActivityBloc {}

void main() {
  late MockActivityBloc mockActivityBloc;

  setUp(() {
    mockActivityBloc = MockActivityBloc();
  });

  group('QuizPage Integration Test', () {
    testWidgets('should show a loading indicator when loading', (WidgetTester tester) async {
      // Arrange
      when(() => mockActivityBloc.state).thenReturn(ActivityState(
        quizzes: [],
        quizzesStatus: ActivityStatus.loading,
        errorMessage: '',
      ));

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: mockActivityBloc,
            child: const QuizPage(),
          ),
        ),
      );

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show an error message when there is an error', (WidgetTester tester) async {
      // Arrange
      when(() => mockActivityBloc.state).thenReturn(ActivityState(
        quizzes: [],
        quizzesStatus: ActivityStatus.error,
        errorMessage: 'Error loading quizzes', flashcards: [], audioActivities: [], flashcardsStatus: null, audioActivitiesStatus: null,
      ));

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: mockActivityBloc,
            child: const QuizPage(),
          ),
        ),
      );

      // Assert
      expect(find.text('Error loading quizzes: Error loading quizzes'), findsOneWidget);
    });

    testWidgets('should show quizzes when the state contains quizzes', (WidgetTester tester) async {
      // Arrange
      final quizzes = [
        QuizEntity(title: 'Quiz 1', description: 'Description 1', language: 'language ', questions: [], duration: null, order: null, completionCriteria: null),
        QuizEntity(title: 'Quiz 2', description: 'Description 2'),
      ];
      when(() => mockActivityBloc.state).thenReturn(ActivityState(
        quizzes: quizzes,
        quizzesStatus: ActivityStatus.success,
        errorMessage: '',
      ));

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: mockActivityBloc,
            child: const QuizPage(),
          ),
        ),
      );

      // Assert
      expect(find.text('Quiz 1'), findsOneWidget);
      expect(find.text('Quiz 2'), findsOneWidget);
      expect(find.text('Description 1'), findsOneWidget);
      expect(find.text('Description 2'), findsOneWidget);
    });

    testWidgets('should navigate to QuizDetailPage when a quiz is tapped', (WidgetTester tester) async {
      // Arrange
      final quiz = QuizEntity(title: 'Quiz 1', description: 'Description 1');
      when(() => mockActivityBloc.state).thenReturn(ActivityState(
        quizzes: [quiz],
        quizzesStatus: ActivityStatus.success,
        errorMessage: '',
      ));

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: mockActivityBloc,
            child: const QuizPage(),
          ),
        ),
      );

      await tester.tap(find.byType(ListTile));

      // Assert
      expect(find.byType(QuizDetailPage), findsOneWidget);
    });
  });
}
