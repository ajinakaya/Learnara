import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learnara/app/constants/theme_constant.dart';
import 'package:learnara/core/theme/app_theme/app_theme.dart';

void main() {
  group('AppTheme', () {
   
    test('should have correct input decoration theme', () {
      final themeDataLight = AppTheme.getApplicationTheme();
      final themeDataDark = AppTheme.getApplicationTheme();
 
      final inputThemeLight = themeDataLight.inputDecorationTheme;
      final inputThemeDark = themeDataDark.inputDecorationTheme;
 
      // Light theme input decorations
      expect(inputThemeLight.contentPadding, const EdgeInsets.all(15));
      expect(inputThemeLight.border, isA<OutlineInputBorder>());
      expect(inputThemeLight.errorBorder?.borderSide.color, Colors.red);
 
      // Dark theme input decorations (optional, if different)
      expect(inputThemeDark.contentPadding, const EdgeInsets.all(15));
      expect(inputThemeDark.border, isA<OutlineInputBorder>());
      expect(inputThemeDark.errorBorder?.borderSide.color, Colors.red);
    });
  });
}