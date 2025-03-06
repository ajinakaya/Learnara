import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:learnara/features/goals/presentation/view/goal.dart';


void main() {
  testWidgets("GoalScreen UI and adding a goal", (WidgetTester tester) async {
    Get.testMode = true;

    await tester.pumpWidget(
      GetMaterialApp(
        home: GoalScreen(),
      ),
    );

    expect(find.text("No goals found. Add a goal."), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text("Create Goal"), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, "Learn Spanish");

    await tester.enterText(find.byType(TextField).last, "Beginner level");

    await tester.tap(find.text("Add Level"));
    await tester.pump();

    await tester.tap(find.text("Save"));
    await tester.pumpAndSettle();

    expect(find.text("Learn Spanish"), findsOneWidget);
    expect(find.text("Level Custom: Beginner level"), findsOneWidget);
  });
}
