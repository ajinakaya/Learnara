import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learnara/app/constants/theme_constant.dart';
import 'package:learnara/core/theme/app_theme/app_theme.dart';


void main() {
  testWidgets('AppTheme applies correct theme to widgets', (WidgetTester tester) async {
    // Build the app with the custom theme
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.getApplicationTheme(),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('AppBar Title'),
          ),
          body: Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Elevated Button'),
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Enter Text',
                  hintText: 'Hint',
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Check if AppBar theme is applied
    final appBar = tester.widget<AppBar>(find.byType(AppBar));
    expect(appBar.backgroundColor, ThemeConstant.appBarColor);
    expect(appBar.titleTextStyle?.color, Colors.black);

    // Check if ElevatedButton theme is applied
    final elevatedButton = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    final buttonStyle = elevatedButton.style!;
    expect(buttonStyle.backgroundColor?.resolve({}), ThemeConstant.primaryColor);
    expect(buttonStyle.foregroundColor?.resolve({}), Colors.white);

    // Check if TextField theme is applied
    final textField = tester.widget<TextField>(find.byType(TextField));
    final decoration = textField.decoration!;
    expect(decoration.border, const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(14))));
    expect(decoration.labelStyle?.color, Colors.black);
    expect(decoration.hintStyle?.color, Colors.grey);
  });
}
