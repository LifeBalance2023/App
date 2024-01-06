import 'package:dio/dio.dart';
import 'package:frontend/cache/settings_cache.dart';
import '../domain/result.dart';

class DioWrapper {
  final Dio _dio;
  final SettingsCache _cache;

  DioWrapper(this._dio, this._cache) {
    configureDio();
  }

  Future<void> configureDio() async {
    final settingsResult = await _cache.loadSettings();

    settingsResult.onSuccess((settings) {
      _dio.options = BaseOptions(
        baseUrl: settings?.backendUrl ?? _dio.options.baseUrl,
      );
    });
  }

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
      if(response.data == null) {
        return Result.voidSuccess();
      }
      return Result.success(response.data as T);
    } on DioException catch (dioError) {
      return Result.failure(Error(
        code: dioError.response?.statusCode,
        message: dioError.message,
      ));
    } catch (error) {
      return Result.failure(Error(message: error.toString()));
    }
  }
}
