import 'package:dio/dio.dart';

abstract interface class ApiService {
  Future<Response<T>> getRequest<T>(String path, {Map<String, dynamic>? queryParams});
  Future<Response<T>> postRequest<T>(String path, {dynamic data});
  Future<Response<T>> putRequest<T>(String path, {dynamic data});
  Future<Response<T>> deleteRequest<T>(String path, {dynamic data});
}
