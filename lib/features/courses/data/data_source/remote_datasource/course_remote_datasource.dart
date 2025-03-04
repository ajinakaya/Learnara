import 'package:dio/dio.dart';
import 'package:learnara/app/constants/api_endpoint.dart';
import 'package:learnara/app/share_pref/token_share_pref.dart';
import 'package:learnara/features/courses/data/data_source/course_data_source.dart';
import 'package:learnara/features/courses/data/model/course_api_model.dart';
import 'package:learnara/features/courses/data/model/chapter_api_model.dart';
import 'package:learnara/features/courses/data/model/sublesson_api_model.dart';
import 'package:learnara/features/courses/domain/entity/course_entity.dart';
import 'package:learnara/features/courses/domain/entity/chapter_entity.dart';
import 'package:learnara/features/courses/domain/entity/sublesson_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourseRemoteDataSource implements ICourseDataSource {
  final Dio _dio;

  CourseRemoteDataSource(this._dio);

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
  Future<List<CourseEntity>> getAllCourses(String? language) async {
    try {
      final token = await _getToken();

      Response response = await _dio.get(
        ApiEndpoints.getAllCourses,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Assuming response.data is a list of course API models
        List<CourseApiModel> apiModels = (response.data as List)
            .map((json) => CourseApiModel.fromJson(json))
            .toList();

        return apiModels.map((model) => model.toEntity()).toList();
      } else {
        throw Exception("Failed to get courses: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }


  @override
  Future<CourseEntity> getCourseById(String courseId) async {
    try {
      final token = await _getToken();

      Response response = await _dio.get(
        '${ApiEndpoints.getCoursebyid}/$courseId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {

        CourseApiModel apiModel = CourseApiModel.fromJson(response.data);
        return apiModel.toEntity();
      } else {
        throw Exception("Failed to get course: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }

  @override
  Future<List<ChapterEntity>> getAllChapters() async {
    try {
      final token = await _getToken();

      Response response = await _dio.get(
        ApiEndpoints.getAllChapters,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<ChapterApiModel> apiModels = (response.data as List)
            .map((json) => ChapterApiModel.fromJson(json))
            .toList();

        return apiModels.map((model) => model.toEntity()).toList();
      } else {
        throw Exception("Failed to get chapters: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }


  @override
  Future<ChapterEntity> getChapterById(String chapterId) async {
    try {
      final token = await _getToken();

      Response response = await _dio.get(
        '${ApiEndpoints.Chapterbyid}/$chapterId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Convert the single chapter API model to an entity
        ChapterApiModel apiModel = ChapterApiModel.fromJson(response.data);
        return apiModel.toEntity();
      } else {
        throw Exception("Failed to get chapter: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }

  @override
  Future<List<SubLessonEntity>> getAllSubLessons(String? language) async {
    try {
      final token = await _getToken();

      // Prepare query parameters
      final queryParams = <String, dynamic>{};
      if (language != null) {
        queryParams['language'] = language;
      }

      Response response = await _dio.get(
        ApiEndpoints.getAllSubLessons,
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Assuming response.data is a list of sublesson API models
        List<SubLessonApiModel> apiModels = (response.data as List)
            .map((json) => SubLessonApiModel.fromJson(json))
            .toList();

        return apiModels.map((model) => model.toEntity()).toList();
      } else {
        throw Exception("Failed to get sublessons: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }

  @override
  Future<SubLessonEntity> getSubLessonById(String subLessonId) async {
    try {
      final token = await _getToken();

      Response response = await _dio.get(
        '${ApiEndpoints.sublessonbyid}/$subLessonId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Convert the single sublesson API model to an entity
        SubLessonApiModel apiModel = SubLessonApiModel.fromJson(response.data);
        return apiModel.toEntity();
      } else {
        throw Exception("Failed to get sublesson: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }
}