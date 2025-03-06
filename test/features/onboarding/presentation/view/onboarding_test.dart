import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learnara/features/langauge/presentation/view/language.dart';
import 'package:learnara/features/onboarding/presentation/view/onboarding.dart';


void main() {
  testWidgets('Onboarding widget renders correctly', (WidgetTester tester) async {
    // Set up a fixed screen size for consistent testing
    tester.binding.window.physicalSizeTestValue = const Size(400, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    // Build the Onboarding widget in the test environment
    await tester.pumpWidget(const MaterialApp(home: Onboarding()));

    // Test the initial state
    expect(find.text('Learn a new language'), findsOneWidget);
    expect(find.text('Discover the joy of learning with interactive lessons and practice.'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);

    // Verify page indicators
    final indicatorFinders = find.byType(AnimatedContainer);
    expect(indicatorFinders, findsNWidgets(3));

    // Test the next button functionality
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Verify we're on the second page
    expect(find.text('Track your progress'), findsOneWidget);
    expect(find.text('Keep an eye on your achievements and reach your goals faster.'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text('Select a language'), findsOneWidget);
    expect(find.text('Choose your preferred language and begin your journey.'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    bool navigatedToLanguageCard = false;

    final mockObserver = MockNavigatorObserver();

    await tester.pumpWidget(
      MaterialApp(
        home: const Onboarding(),
        navigatorObservers: [mockObserver],
      ),
    );

    // Navigate to the last page again
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

  });

  testWidgets('Onboarding page indicators update correctly', (WidgetTester tester) async {
    // Build the Onboarding widget
    await tester.pumpWidget(const MaterialApp(home: Onboarding()));

    // Find all page indicators
    final indicators = find.byType(AnimatedContainer);
    expect(indicators, findsNWidgets(3));

    // Verify the first indicator is active
    final firstIndicator = tester.widget<AnimatedContainer>(indicators.at(0));
    final BoxDecoration firstDecoration = firstIndicator.decoration as BoxDecoration;
    expect(firstDecoration.color, Colors.black);

    // Other indicators should be inactive
    final secondIndicator = tester.widget<AnimatedContainer>(indicators.at(1));
    final BoxDecoration secondDecoration = secondIndicator.decoration as BoxDecoration;
    expect(secondDecoration.color, Colors.grey);

    // Move to the second page
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Now the second indicator should be active
    final updatedIndicators = find.byType(AnimatedContainer);
    final updatedSecondIndicator = tester.widget<AnimatedContainer>(updatedIndicators.at(1));
    final BoxDecoration updatedSecondDecoration = updatedSecondIndicator.decoration as BoxDecoration;
    expect(updatedSecondDecoration.color, Colors.black);

    // And the first indicator should be inactive
    final updatedFirstIndicator = tester.widget<AnimatedContainer>(updatedIndicators.at(0));
    final BoxDecoration updatedFirstDecoration = updatedFirstIndicator.decoration as BoxDecoration;
    expect(updatedFirstDecoration.color, Colors.grey);
  });

  testWidgets('Onboarding widget has correct UI elements and layout', (WidgetTester tester) async {
    // Build the Onboarding widget
    await tester.pumpWidget(const MaterialApp(home: Onboarding()));

    // Verify scaffold and background color
    final scaffoldFinder = find.byType(Scaffold);
    expect(scaffoldFinder, findsOneWidget);
    final scaffold = tester.widget<Scaffold>(scaffoldFinder);
    expect(scaffold.backgroundColor, Colors.white);
    expect(find.byType(Column), findsWidgets);
    expect(find.byType(PageView), findsOneWidget);
    final buttonFinder = find.byType(ElevatedButton);
    final button = tester.widget<ElevatedButton>(buttonFinder);
    final buttonStyle = button.style as ButtonStyle;
    expect(buttonStyle.backgroundColor?.resolve({MaterialState.selected}), Colors.black87);
    final titleFinder = find.text('Learn a new language');
    final titleWidget = tester.widget<Text>(titleFinder);
    expect(titleWidget.style?.fontSize, 28);
    expect(titleWidget.style?.fontWeight, FontWeight.bold);
    expect(titleWidget.style?.color, Colors.black87);

    final subtitleFinder = find.text('Discover the joy of learning with interactive lessons and practice.');
    final subtitleWidget = tester.widget<Text>(subtitleFinder);
    expect(subtitleWidget.style?.fontSize, 16);
    expect(subtitleWidget.style?.color, Colors.grey);
  });
}

class MockNavigatorObserver extends NavigatorObserver {
  List<Route<dynamic>> pushedRoutes = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    pushedRoutes.add(route);
    super.didPush(route, previousRoute);
  }
}