import 'package:frontend/api/statistics/responses/daily_statistics_response.dart';
import 'package:frontend/api/statistics/responses/user_statistics_response.dart';

import '../../domain/result.dart';
import '../dio_wrapper.dart';

class StatisticsApi {
  final DioWrapper _dioWrapper;

  StatisticsApi(DioWrapper dioWrapper) : _dioWrapper = dioWrapper;

  Future<Result<UserStatisticsResponse>> getUserStatistics() => _dioWrapper.get('/statistics')
        .then((result) => result.map((result) => UserStatisticsResponse.fromJson(result as Map<String, dynamic>)));

  Future<Result<DailyStatisticsResponse>> getDailyStatistics(String date) => _dioWrapper.get('/statistics/$date')
        .then((result) => result.map((result) => DailyStatisticsResponse.fromJson(result as Map<String, dynamic>)));
}
