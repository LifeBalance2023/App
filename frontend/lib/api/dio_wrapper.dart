import 'package:dio/dio.dart';
import '../domain/result.dart';

class DioWrapper {
  final Dio _dio;

  DioWrapper(this._dio);

  Future<Result<T>> get<T>(String path, {Map<String, dynamic>? queryParameters}) =>
      _safeApiCall(() => _dio.get(path, queryParameters: queryParameters));

  Future<Result<T>> post<T>(String path, {dynamic data, Map<String, dynamic>? queryParameters}) =>
      _safeApiCall(() => _dio.post(path, data: data, queryParameters: queryParameters));

  Future<Result<T>> patch<T>(String path, {dynamic data, Map<String, dynamic>? queryParameters}) =>
      _safeApiCall(() => _dio.patch(path, data: data, queryParameters: queryParameters));

  Future<Result<T>> delete<T>(String path, {dynamic data, Map<String, dynamic>? queryParameters}) =>
      _safeApiCall(() => _dio.delete(path, data: data, queryParameters: queryParameters));

  Future<Result<T>> _safeApiCall<T>(Future<Response<T>> Function() apiCall) async {
    try {
      final Response<T> response = await apiCall();
      return Result.success(response.data);
    } on DioException catch (dioError) {
      return Result.failure(ApiError(
        code: dioError.response?.statusCode,
        message: dioError.message,
      ));
    } catch (error) {
      return Result.failure(ApiError(message: error.toString()));
    }
  }
}
