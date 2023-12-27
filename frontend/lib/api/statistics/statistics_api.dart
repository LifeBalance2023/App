import 'package:frontend/api/statistics/responses/daily_statistics_response.dart';
import 'package:frontend/api/statistics/responses/general_statistics_response.dart';

import '../../domain/result.dart';
import '../dio_wrapper.dart';

class StatisticsApi {
  final DioWrapper _dioWrapper;
  final String _baseUrl = '/statistics';

  StatisticsApi(DioWrapper dioWrapper) : _dioWrapper = dioWrapper;

  Future<Result<GeneralStatisticsResponse>> getUserStatistics() => _dioWrapper.get(_baseUrl)
        .then((result) => result.map((result) => GeneralStatisticsResponse.fromJson(result)));

  Future<Result<DailyStatisticsResponse>> getDailyStatistics(String date) => _dioWrapper.get('$_baseUrl/$date')
        .then((result) => result.map((result) => DailyStatisticsResponse.fromJson(result)));
}
