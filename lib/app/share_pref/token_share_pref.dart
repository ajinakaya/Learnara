import 'package:dartz/dartz.dart';
import 'package:learnara/core/error/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learnara/features/langauge/domain/entity/user_language_entity.dart';

class TokenSharedPrefs {
  final SharedPreferences _sharedPreferences;

  TokenSharedPrefs(this._sharedPreferences);

  // Save Token
  Future<Either<Failure, void>> saveToken(String token) async {
    try {
      await _sharedPreferences.setString('token', token);
      return Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Get Token
  Future<Either<Failure, String>> getToken() async {
    try {
      final token = _sharedPreferences.getString('token');
      return Right(token ?? '');
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Save User Language
  Future<Either<Failure, void>> saveUserLanguage(String language) async {
    try {
      await _sharedPreferences.setString('user_language', language);
      return Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }


  Future<Either<Failure, void>> deleteToken() async {
    try {
      await _sharedPreferences.remove('token');
      return Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }


  // Get User Language
  Future<Either<Failure, String>> getUserLanguage() async {
    try {
      final language = _sharedPreferences.getString('user_language');
      return Right(language ?? '');
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Save Complete Language Preference
  Future<Either<Failure, void>> saveCompleteLanguagePreference(UserLanguagePreferenceEntity language) async {
    try {
      await _sharedPreferences.setString('selectedLanguageId', language.id);
      await _sharedPreferences.setString('userId', language.userId);
      await _sharedPreferences.setString('selectedLanguageName', language.languageName);
      await _sharedPreferences.setString('selectedLanguageImage', language.languageImage);
      return Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Get Complete Language Preference
  Future<Either<Failure, UserLanguagePreferenceEntity>> getCompleteLanguagePreference() async {
    try {
      final languageId = _sharedPreferences.getString('selectedLanguageId');
      final userId = _sharedPreferences.getString('userId');
      final languageName = _sharedPreferences.getString('selectedLanguageName');
      final languageImage = _sharedPreferences.getString('selectedLanguageImage');

      if (languageId != null && userId != null && languageName != null && languageImage != null) {
        return Right(UserLanguagePreferenceEntity(
          id: languageId,
          userId: userId,
          languageName: languageName,
          languageImage: languageImage,
        ));
      } else {
        return Left(SharedPrefsFailure(message: 'Language preference not found'));
      }
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }
}
