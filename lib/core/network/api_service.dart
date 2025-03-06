import 'package:dio/dio.dart';
import 'package:learnara/app/constants/api_endpoint.dart';
import 'package:learnara/core/network/dio_error_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  final Dio _dio;
  String? _token;

  Dio get dio => _dio;

  ApiService(this._dio) {
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      ..interceptors.add(DioErrorInterceptor())
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true))
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
  }

  // Add this method to set the token
  void setToken(String token) {
    _token = token;
    // Update the Authorization header with the token
    _dio.options.headers['Authorization'] = 'Bearer $_token';
  }

  // Optionally, add a method to clear the token
  void clearToken() {
    _token = null;
    // Remove the Authorization header
    _dio.options.headers.remove('Authorization');
  }
}