import 'package:dio/dio.dart';
import 'package:frontend/cache/settings_cache.dart';
import '../domain/result.dart';

class DioWrapper {
  final Dio _dio;
  final SettingsCache _cache;

  DioWrapper._(this._dio, this._cache);

  static Future<DioWrapper> create(Dio dio, SettingsCache cache) async {
    var wrapper = DioWrapper._(dio, cache);
    await wrapper._configureDio();
    return wrapper;
  }

  Future<void> _configureDio() async {
    _dio.interceptors.add(LogInterceptor(
      request: true,
      responseBody: true,
      requestBody: true,
      responseHeader: false,
      requestHeader: false,
      error: true,
    ));

    final settingsResult = await _cache.loadSettings();

    settingsResult.onSuccess((settings) {
      _dio.options = BaseOptions(
        baseUrl: settings?.backendUrl ?? _dio.options.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
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
    if(_dio.options.baseUrl.isEmpty) {
      return Result.failure(ResultError(message: 'Backend url is not set. Go to settings to set it up'));
    }

    try {
      final Response<T> response = await apiCall();
      return Result.success(response.data as T);
    } on DioException catch (dioError) {
      return Result.failure(ResultError(
        code: dioError.response?.statusCode,
        message: dioError.message,
      ));
    } catch (error) {
      return Result.failure(ResultError(message: error.toString()));
    }
  }
}
