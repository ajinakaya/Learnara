import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learnara/features/profile/presentation/view/profile.dart';

void main() {
  testWidgets('Profile screen UI test', (WidgetTester tester) async {
    // Build the Profile widget
    await tester.pumpWidget(
      MaterialApp(
        home: Profile(),
      ),
    );

    // Verify the app bar title
    expect(find.text('Profile'), findsOneWidget);
    expect(find.byIcon(Icons.logout_outlined), findsOneWidget);

    // Verify profile header
    expect(find.byType(Icon), findsWidgets); 
    expect(find.byType(Text), findsWidgets); 

    // Verify stat section
    expect(find.text('Current Streak'), findsOneWidget);
    expect(find.text('1 days'), findsOneWidget);
    expect(find.text('Level'), findsOneWidget);
    expect(find.text('A1'), findsOneWidget);

    // Verify language progress section
    expect(find.text('Language Progress'), findsOneWidget);
    expect(find.text('Japanese'), findsOneWidget);

    // Verify goals section
    expect(find.text('Learning Goals'), findsOneWidget);
    expect(find.text('Daily study goal'), findsOneWidget);
    expect(find.text('30 minutes'), findsOneWidget);
    expect(find.text('Weekly lessons'), findsOneWidget);
    expect(find.text('15 lessons'), findsOneWidget);
  });
}
