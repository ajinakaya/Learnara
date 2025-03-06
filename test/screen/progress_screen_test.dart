import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learnara/screen/progress_screen.dart';


void main() {
  testWidgets('ProgressScreen displays overall progress, weekly progress, and recent activity', (WidgetTester tester) async {

    await tester.pumpWidget(
      MaterialApp(
        home: ProgressScreen(),
      ),
    );

    // Test for the overall progress section
    expect(find.text('Overall Progress'), findsOneWidget);
    expect(find.text('Lessons\nCompleted'), findsOneWidget);
    expect(find.text('12'), findsOneWidget); 
    expect(find.text('Total Study\nTime'), findsOneWidget);
    expect(find.text('6.5h'), findsOneWidget);
    expect(find.text('Current\nLevel'), findsOneWidget);
    expect(find.text('A1'), findsOneWidget); 

    // Test for the weekly progress section
    expect(find.text('This Week'), findsOneWidget);
    expect(find.byIcon(Icons.check), findsNWidgets(5)); 
    expect(find.byIcon(Icons.circle), findsNWidgets(2)); 

    // Test for the recent activity section
    expect(find.text('Recent Activity'), findsOneWidget);
    expect(find.text('Completed Lesson'), findsOneWidget);
    expect(find.text('Basic Greetings'), findsOneWidget);
    expect(find.text('2 hours ago'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);

    expect(find.text('Vocabulary Quiz'), findsOneWidget);
    expect(find.text('Score: 8/10'), findsOneWidget);
    expect(find.text('Yesterday'), findsOneWidget);
    expect(find.byIcon(Icons.quiz_rounded), findsOneWidget);

    expect(find.text('Practice Session'), findsOneWidget);
    expect(find.text('Speaking Exercise'), findsOneWidget);
    expect(find.text('2 days ago'), findsOneWidget);
    expect(find.byIcon(Icons.mic_rounded), findsOneWidget);
  });

  testWidgets('ProgressScreen UI: Check if daily progress indicators show correct status', (WidgetTester tester) async {
    
    await tester.pumpWidget(
      MaterialApp(
        home: ProgressScreen(),
      ),
    );

   
    final completedIcons = find.byIcon(Icons.check);
    final incompleteIcons = find.byIcon(Icons.circle);

    expect(completedIcons, findsNWidgets(5));
    expect(incompleteIcons, findsNWidgets(2));
  });

  testWidgets('ProgressScreen UI: Check recent activity items', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: ProgressScreen(),
      ),
    );

   
    final activityTitleFinder = find.text('Completed Lesson');
    final activitySubtitleFinder = find.text('Basic Greetings');
    final activityTimeFinder = find.text('2 hours ago');

   
    expect(activityTitleFinder, findsOneWidget);
    expect(activitySubtitleFinder, findsOneWidget);
    expect(activityTimeFinder, findsOneWidget);
  });
}
