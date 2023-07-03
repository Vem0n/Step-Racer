import 'package:dio/dio.dart';

class ApiFetcher {
  Dio _dio = Dio();

  ApiFetcher() {
     _dio = Dio();
  }

  Future<Response> get(String url, {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters, options: options);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<Response> post(String url, dynamic data, {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      final response = await _dio.post(url, data: data, queryParameters: queryParameters, options: options);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<Response> put(String url, dynamic data, {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      final response = await _dio.put(url, data: data, queryParameters: queryParameters, options: options);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<Response> delete(String url, {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      final response = await _dio.delete(url, queryParameters: queryParameters, options: options);
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
