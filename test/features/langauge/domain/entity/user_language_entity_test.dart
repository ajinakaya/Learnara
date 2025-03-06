import 'package:flutter_test/flutter_test.dart';
import 'package:learnara/features/langauge/domain/entity/user_language_entity.dart';

void main() {
  group('UserLanguagePreferenceEntity Tests', () {
    const id1 = 'pref1';
    const userId1 = 'user1';
    const languageName1 = 'English';
    const languageImage1 = 'assets/images/en_flag.png';
    
    const id2 = 'pref2';
    const userId2 = 'user2';
    const languageName2 = 'Spanish';
    const languageImage2 = 'assets/images/es_flag.png';
    
    test('should create entity with correct properties', () {
      const preference = UserLanguagePreferenceEntity(
        id: id1, 
        userId: userId1,
        languageName: languageName1, 
        languageImage: languageImage1
      );
      
      expect(preference.id, id1);
      expect(preference.userId, userId1);
      expect(preference.languageName, languageName1);
      expect(preference.languageImage, languageImage1);
    });
    
    test('props should contain all properties for equality comparison', () {
      const preference = UserLanguagePreferenceEntity(
        id: id1, 
        userId: userId1,
        languageName: languageName1, 
        languageImage: languageImage1
      );
      
      expect(preference.props.length, 4);
      expect(preference.props.contains(id1), true);
      expect(preference.props.contains(userId1), true);
      expect(preference.props.contains(languageName1), true);
      expect(preference.props.contains(languageImage1), true);
    });
    
    test('entities with same values should be equal', () {
      const preference1 = UserLanguagePreferenceEntity(
        id: id1, 
        userId: userId1,
        languageName: languageName1, 
        languageImage: languageImage1
      );
      
      const preference2 = UserLanguagePreferenceEntity(
        id: id1, 
        userId: userId1,
        languageName: languageName1, 
        languageImage: languageImage1
      );
      
      expect(preference1, preference2);
    });
    
    test('entities with different values should not be equal', () {
      const preference1 = UserLanguagePreferenceEntity(
        id: id1, 
        userId: userId1,
        languageName: languageName1, 
        languageImage: languageImage1
      );
      
      const preference2 = UserLanguagePreferenceEntity(
        id: id2, 
        userId: userId2,
        languageName: languageName2, 
        languageImage: languageImage2
      );
      
      expect(preference1, isNot(preference2));
    });
    
    test('entities with one different property should not be equal', () {
      const preference1 = UserLanguagePreferenceEntity(
        id: id1, 
        userId: userId1,
        languageName: languageName1, 
        languageImage: languageImage1
      );
      
      // Only id is different
      const preference2 = UserLanguagePreferenceEntity(
        id: id2, 
        userId: userId1,
        languageName: languageName1, 
        languageImage: languageImage1
      );
      
      // Only userId is different
      const preference3 = UserLanguagePreferenceEntity(
        id: id1, 
        userId: userId2,
        languageName: languageName1, 
        languageImage: languageImage1
      );
      
      // Only languageName is different
      const preference4 = UserLanguagePreferenceEntity(
        id: id1, 
        userId: userId1,
        languageName: languageName2, 
        languageImage: languageImage1
      );
      
      // Only languageImage is different
      const preference5 = UserLanguagePreferenceEntity(
        id: id1, 
        userId: userId1,
        languageName: languageName1, 
        languageImage: languageImage2
      );
      
      expect(preference1, isNot(preference2));
      expect(preference1, isNot(preference3));
      expect(preference1, isNot(preference4));
      expect(preference1, isNot(preference5));
    });
  });
}