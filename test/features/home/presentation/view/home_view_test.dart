import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:learnara/app/app.dart';
import 'package:learnara/features/courses/presentation/view/course_screen.dart';
import 'package:learnara/features/home/presentation/view/bottom_view/dashboard_view.dart';
import 'package:learnara/features/home/presentation/view/home_view.dart';
import 'package:learnara/features/profile/presentation/view/profile.dart';
import 'package:learnara/main.dart'; // Assuming your app is defined here
import 'package:learnara/screen/progress_screen.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('HomeView Test', () {
    setUpAll(() async {
      SharedPreferences.setMockInitialValues({
        'username': 'testuser',
        'someKey': ['item1', 'item2'],
      });

      final mockSharedPreferences = MockSharedPreferences();

      when(() => mockSharedPreferences.getString('username'))
          .thenReturn('testuser');
      when(() => mockSharedPreferences.getStringList('someKey'))
          .thenReturn(['item1', 'item2']);

    });

    testWidgets('should navigate between bottom navigation tabs',
        (WidgetTester tester) async {

      await tester.pumpWidget(const MyApp());


      await tester.pumpAndSettle();


      expect(find.byType(DashboardView), findsOneWidget);

      // Tap on Learn tab
      await tester.tap(find.text('Learn'));
      await tester.pumpAndSettle();
      expect(find.byType(CourseScreen), findsOneWidget);

      // Tap on Progress tab
      await tester.tap(find.text('Progress'));
      await tester.pumpAndSettle();
      expect(find.byType(ProgressScreen), findsOneWidget);

      // Tap on Profile tab
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();
      expect(find.byType(Profile), findsOneWidget);

      // Return to Home tab
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(find.byType(DashboardView), findsOneWidget);

      // Test icons as well
      await tester.tap(find.byIcon(Icons.menu_book_outlined));
      await tester.pumpAndSettle();
      expect(find.byType(CourseScreen), findsOneWidget);

      await tester.tap(find.byIcon(Icons.bar_chart));
      await tester.pumpAndSettle();
      expect(find.byType(ProgressScreen), findsOneWidget);

      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();
      expect(find.byType(Profile), findsOneWidget);

      await tester.tap(find.byIcon(Icons.home_filled));
      await tester.pumpAndSettle();
      expect(find.byType(DashboardView), findsOneWidget);
    });


  });
}