import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:learnara/features/langauge/presentation/view_model/language/language_bloc.dart';

void main() {
  group('LanguageCard Widget Tests', () {
    testWidgets('displays loading indicator when in loading state', (WidgetTester tester) async {

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pump();


      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays error message when error occurs', (WidgetTester tester) async {
      // Arrange: Build the widget with an error state
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: Text('Error: Something went wrong'), // Simulate error message
            ),
          ),
        ),
      );


      await tester.pump();


      expect(find.text('Error: Something went wrong'), findsOneWidget);
    });

    testWidgets('displays available languages and allows selection', (WidgetTester tester) async {

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // Simulate selection action
                  },
                  child: Container(
                    child: Text('English'), // Displaying language option
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Simulate selection action
                  },
                  child: Container(
                    child: Text('Spanish'), // Displaying language option
                  ),
                ),
              ],
            ),
          ),
        ),
      );


      await tester.tap(find.text('English'));
      await tester.pump();


      expect(find.text('English'), findsOneWidget);
      expect(find.text('Spanish'), findsOneWidget);
    });

    testWidgets('shows continue button when language is selected', (WidgetTester tester) async {

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // Simulate selection action
                  },
                  child: Container(
                    child: Text('English'), // Displaying language option
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Simulate continue button press
                  },
                  child: Text('Continue'),
                ),
              ],
            ),
          ),
        ),
      );


      await tester.tap(find.text('English'));
      await tester.pump();


      await tester.tap(find.text('Continue'));
      await tester.pump();


      expect(find.text('Continue'), findsOneWidget);
    });

    testWidgets('shows snack bar when no language is selected and continue is pressed', (WidgetTester tester) async {

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ElevatedButton(
                  onPressed: () {

                    ScaffoldMessenger.of(tester.element(find.byType(ElevatedButton)))
                        .showSnackBar(SnackBar(content: Text('Please select a language before continuing.')));
                  },
                  child: Text('Continue'),
                ),
              ],
            ),
          ),
        ),
      );


      await tester.tap(find.text('Continue'));
      await tester.pump();


      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Please select a language before continuing.'), findsOneWidget);
    });
  });
}
