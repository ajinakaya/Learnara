import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:learnara/app/constants/api_endpoint.dart';
import 'package:learnara/app/share_pref/token_share_pref.dart';
import 'package:learnara/features/auth/data/data_source/auth_data_source.dart';
import 'package:learnara/features/auth/data/model/auth_api_model.dart';
import 'package:learnara/features/auth/domain/entity/auth_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthRemoteDatasource implements IAuthDataSource {
  final Dio _dio;

  AuthRemoteDatasource(this._dio);


  @override
  Future<String> loginUser(String email, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        return response.data['token'];
      } else {
        throw Exception("Login failed: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      throw Exception("An error occurred: ${e.toString()}");
    }
  }

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.register,
        data: {
          "fullname": user.fullname,
          "email": user.email,
          "image": user.image,
          "role": user.role,
          "username": user.username,
          "password": user.password,
          "confirmpassword": user.password,


        },
      );
      if (response.statusCode == 200) {
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

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path
          .split('/')
          .last;


      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          file.path,
          filename: fileName,

          contentType: MediaType('image',
              fileName.endsWith('.jpg') || fileName.endsWith('.jpeg') ? 'jpeg' :
              fileName.endsWith('.png') ? 'png' :
              fileName.endsWith('.gif') ? 'gif' : 'jpeg'
          ),
        ),
      });


      Response response = await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          headers: {
            'Accept': '*/*',
          },
          followRedirects: true,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          return response.data['data'];
        }
        throw Exception("Invalid response format");
      } else {
        throw Exception("Upload failed: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print("Response error: ${e.response?.data}");
        throw Exception("Server error: ${e.response?.statusMessage}");
      }
      print("Error details: ${e.error}");
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      print("Unexpected error: $e");
      throw Exception("Upload failed: ${e.toString()}");
    }
  }

  @override
  Future<AuthEntity> getCurrentUser() async {
    try {

      final sharedPreferences = await SharedPreferences.getInstance();
      final tokenPrefs = TokenSharedPrefs(sharedPreferences);
      final tokenResult = await tokenPrefs.getToken();
      final token = tokenResult.fold(
            (failure) =>
        throw Exception("Failed to get token: ${failure.message}"),
            (token) => token,
      );

      Response response = await _dio.get(
        ApiEndpoints.profile,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        AuthApiModel apiModel = AuthApiModel.fromJson(response.data);
        return apiModel.toEntity();
      } else {
        throw Exception(
            "Failed to get current user: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }
}