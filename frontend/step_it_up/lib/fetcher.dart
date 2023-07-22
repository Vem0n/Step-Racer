import 'package:dio/dio.dart';

class ApiFetcher {
  Dio _dio = Dio();

  ApiFetcher() {
    _dio = Dio(
      BaseOptions(
        validateStatus: (status) {
          return true;
        },
      ),
    );
  }

  Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      final response = await _dio.get(url,
          queryParameters: queryParameters, options: options);
      return response;
    } on DioException catch (error) {
      _handleError(error);
      rethrow;
    }
  }

  Future<Response> post(String url, dynamic data,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      final response = await _dio.post(url,
          data: data, queryParameters: queryParameters, options: options);
      return response;
    } on DioException catch (error) {
      _handleError(error);
      rethrow;
    }
  }

  Future<Response> put(String url, dynamic data,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      final response = await _dio.put(url,
          data: data, queryParameters: queryParameters, options: options);
      return response;
    } on DioException catch (error) {
      _handleError(error);
      rethrow;
    }
  }

  Future<Response> delete(String url,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      final response = await _dio.delete(url,
          queryParameters: queryParameters, options: options);
      return response;
    } on DioException catch (error) {
      _handleError(error);
      rethrow;
    }
  }

  void _handleError(DioException error) {
    if (error.response != null) {
      final int statusCode = error.response!.statusCode ?? -1;
      final String errorMessage =
          error.response!.statusMessage ?? 'Unknown error';
      print('HTTP Error: $statusCode - $errorMessage');
    } else {
      print('Connection Error: ${error.message}');
    }
  }
}
