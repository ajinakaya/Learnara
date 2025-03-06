import 'package:flutter_test/flutter_test.dart';
import 'package:learnara/features/langauge/domain/entity/language_entity.dart';

void main() {
  group('PreferredLanguageEntity Tests', () {
    const languageId1 = 'en-US';
    const languageName1 = 'English';
    const languageImage1 = 'assets/images/en_flag.png';
    
    const languageId2 = 'es-ES';
    const languageName2 = 'Spanish';
    const languageImage2 = 'assets/images/es_flag.png';
    
    test('should create entity with correct properties', () {
      const language = PreferredLanguageEntity(
        languageId: languageId1, 
        languageName: languageName1, 
        languageImage: languageImage1
      );
      
      expect(language.languageId, languageId1);
      expect(language.languageName, languageName1);
      expect(language.languageImage, languageImage1);
    });
    
    test('props should contain all properties for equality comparison', () {
      const language = PreferredLanguageEntity(
        languageId: languageId1, 
        languageName: languageName1, 
        languageImage: languageImage1
      );
      
      expect(language.props.length, 3);
      expect(language.props.contains(languageId1), true);
      expect(language.props.contains(languageName1), true);
      expect(language.props.contains(languageImage1), true);
    });
    
    test('entities with same values should be equal', () {
      const language1 = PreferredLanguageEntity(
        languageId: languageId1, 
        languageName: languageName1, 
        languageImage: languageImage1
      );
      
      const language2 = PreferredLanguageEntity(
        languageId: languageId1, 
        languageName: languageName1, 
        languageImage: languageImage1
      );
      
      expect(language1, language2);
    });
    
    test('entities with different values should not be equal', () {
      const language1 = PreferredLanguageEntity(
        languageId: languageId1, 
        languageName: languageName1, 
        languageImage: languageImage1
      );
      
      const language2 = PreferredLanguageEntity(
        languageId: languageId2, 
        languageName: languageName2, 
        languageImage: languageImage2
      );
      
      expect(language1, isNot(language2));
    });
    
    test('entities with one different property should not be equal', () {
      const language1 = PreferredLanguageEntity(
        languageId: languageId1, 
        languageName: languageName1, 
        languageImage: languageImage1
      );
      
      // Only languageId is different
      const language2 = PreferredLanguageEntity(
        languageId: languageId2, 
        languageName: languageName1, 
        languageImage: languageImage1
      );
      
      // Only languageName is different
      const language3 = PreferredLanguageEntity(
        languageId: languageId1, 
        languageName: languageName2, 
        languageImage: languageImage1
      );
      
      // Only languageImage is different
      const language4 = PreferredLanguageEntity(
        languageId: languageId1, 
        languageName: languageName1, 
        languageImage: languageImage2
      );
      
      expect(language1, isNot(language2));
      expect(language1, isNot(language3));
      expect(language1, isNot(language4));
    });
  });
}