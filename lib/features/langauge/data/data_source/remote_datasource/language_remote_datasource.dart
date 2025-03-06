import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:learnara/app/constants/api_endpoint.dart';
import 'package:learnara/features/langauge/data/data_source/language_data_source.dart';
import 'package:learnara/features/langauge/data/dto/language_dto.dart';
import 'package:learnara/features/langauge/data/dto/user_language_dto.dart';
import 'package:learnara/features/langauge/data/model/user_language_api_model.dart';
import 'package:learnara/features/langauge/domain/entity/language_entity.dart';
import 'package:learnara/features/langauge/domain/entity/user_language_entity.dart';

class LanguageRemoteDataSource implements ILanguageDataSource {
  final Dio _dio;

  LanguageRemoteDataSource({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<List<PreferredLanguageEntity>> getAllLanguages() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllLanguages);
      debugPrint("API Response: ${response.data}");

      if (response.statusCode == 200) {
        if (response.data is List) {
          // Directly parse the list
          List<dynamic> languageList = response.data;
          return languageList
              .map((item) => PreferredLanguageEntity(
            languageId: item['_id'] ?? '',
            languageName: item['languageName'] ?? '',
            languageImage: item['languageImage'] ?? '',
          ))
              .toList();
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserLanguagePreferenceEntity> getUserPreferredLanguage(String userId) async {
    try {
      var response = await _dio.get("${ApiEndpoints.getUserPreferredLanguage}/$userId");

      if (response.statusCode == 200) {
        UserLanguageDto userLanguageDto = UserLanguageDto.fromJson(response.data);
        if (userLanguageDto.data.isEmpty) {
          throw Exception("No language preference found for user");
        }
        return userLanguageDto.data.first.toEntity();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> setUserPreferredLanguage(UserLanguagePreferenceEntity entity) async {
    try {
      // Convert entity to API model
      var apiModel = UserLanguageApiModel.fromEntity(entity);

      var response = await _dio.post(
        ApiEndpoints.setUserPreferredLanguage,
        data: apiModel.toJson(),
      );

      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}