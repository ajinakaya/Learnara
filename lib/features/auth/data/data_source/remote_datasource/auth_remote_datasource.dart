import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:learnara/app/constants/api_endpoint.dart';
import 'package:learnara/features/auth/data/data_source/auth_data_source.dart';
import 'package:learnara/features/auth/domain/entity/auth_entity.dart';


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
          "role":user.role,
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
      String fileName = file.path.split('/').last;


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
  Future<AuthEntity> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }
}




