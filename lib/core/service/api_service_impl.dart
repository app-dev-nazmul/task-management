import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'api_service.dart';

@LazySingleton(as: ApiService)
class ApiServiceImpl implements ApiService {
  final Dio _dio;

  ApiServiceImpl(this._dio);

  @override
  Future<Response<T>> getRequest<T>(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get<T>(path, queryParameters: queryParams);
      return response;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  @override
  Future<Response<T>> postRequest<T>(String path, {dynamic data}) async {
    try {
      final response = await _dio.post<T>(path, data: data);
      return response;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  @override
  Future<Response<T>> putRequest<T>(String path, {dynamic data}) async {
    try {
      final response = await _dio.put<T>(path, data: data);
      return response;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  @override
  Future<Response<T>> deleteRequest<T>(String path, {dynamic data}) async {
    try {
      final response = await _dio.delete<T>(path, data: data);
      return response;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  void _handleDioError(DioException e) {
    // Customize error handling logic
    if (e.type == DioExceptionType.connectionTimeout) {
      if (kDebugMode) {
        print('Connection timeout');
      }
    } else if (e.type == DioExceptionType.badResponse) {
      if (kDebugMode) {
        print('Bad response: ${e.response?.statusCode}');
      }
    } else if (e.type == DioExceptionType.unknown) {
      if (kDebugMode) {
        print('Unknown error: ${e.message}');
      }
    } else {
      if (kDebugMode) {
        print('Dio Error: ${e.message}');
      }
    }
  }
}
