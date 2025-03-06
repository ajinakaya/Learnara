import 'package:dio/dio.dart';
import 'package:learnara/app/constants/api_endpoint.dart';
import 'package:learnara/app/share_pref/token_share_pref.dart';
import 'package:learnara/features/Activitytype/data/data_source/activity_data_source.dart';
import 'package:learnara/features/Activitytype/data/model/audio/audio_api_model.dart';
import 'package:learnara/features/Activitytype/data/model/flashcard/flashcard_api_model.dart';
import 'package:learnara/features/Activitytype/data/model/quiz/quiz_api_model.dart';
import 'package:learnara/features/Activitytype/domain/entity/audio/audio_entity.dart';
import 'package:learnara/features/Activitytype/domain/entity/flashcard/flashcard_entity.dart';
import 'package:learnara/features/Activitytype/domain/entity/quiz/quiz_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityRemoteDataSource implements IActivityDataSource {
  final Dio _dio;

  ActivityRemoteDataSource(this._dio);

  // Helper method to get authentication token
  Future<String> _getToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final tokenPrefs = TokenSharedPrefs(sharedPreferences);
    final tokenResult = await tokenPrefs.getToken();
    return tokenResult.fold(
          (failure) => throw Exception("Failed to get token: ${failure.message}"),
          (token) => token,
    );
  }

  @override
  Future<List<FlashcardEntity>> getAllFlashcards(String? language) async {
    try {
      final token = await _getToken();

      // Prepare query parameters
      final queryParams = <String, dynamic>{};
      if (language != null) {
        queryParams['language'] = language;
      }

      Response response = await _dio.get(
        ApiEndpoints.getAllFlashcards,
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Assuming response.data is a list of flashcard API models
        List<FlashcardApiModel> apiModels = (response.data as List)
            .map((json) => FlashcardApiModel.fromJson(json))
            .toList();

        return apiModels.map((model) => model.toEntity()).toList();
      } else {
        throw Exception("Failed to get flashcards: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }

  @override
  Future<List<QuizEntity>> getAllQuizzes(String? language) async {
    try {
      final token = await _getToken();

      // Prepare query parameters
      final queryParams = <String, dynamic>{};
      if (language != null) {
        queryParams['language'] = language;
      }

      Response response = await _dio.get(
        ApiEndpoints.getAllQuizzes,
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Assuming response.data is a list of quiz API models
        List<QuizApiModel> apiModels = (response.data as List)
            .map((json) => QuizApiModel.fromJson(json))
            .toList();

        return apiModels.map((model) => model.toEntity()).toList();
      } else {
        throw Exception("Failed to get quizzes: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }

  @override
  Future<List<AudioEntity>> getAllAudioActivities(String? language) async {
    try {
      final token = await _getToken();

      // Prepare query parameters
      final queryParams = <String, dynamic>{};
      if (language != null) {
        queryParams['language'] = language;
      }

      Response response = await _dio.get(
        ApiEndpoints.getAllAudioActivities,
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Assuming response.data is a list of audio API models
        List<AudioApiModel> apiModels = (response.data as List)
            .map((json) => AudioApiModel.fromJson(json))
            .toList();

        return apiModels.map((model) => model.toEntity()).toList();
      } else {
        throw Exception("Failed to get audio activities: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }
}