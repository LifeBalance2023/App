import 'package:frontend/api/statistics/responses/daily_statistics_response.dart';
import 'package:frontend/api/statistics/responses/general_statistics_response.dart';

import '../../domain/result.dart';
import '../dio_wrapper.dart';

class StatisticsApi {
  final DioWrapper _dioWrapper;
  final String _baseUrl = '/statistics';

  StatisticsApi(DioWrapper dioWrapper) : _dioWrapper = dioWrapper;

  Future<Result<GeneralStatisticsResponse>> getUserStatistics() async {
    var result = await _dioWrapper.get<Map<String, dynamic>>(_baseUrl);
    return result.map((data) => GeneralStatisticsResponse.fromJson(data));
  }

  Future<Result<DailyStatisticsResponse>> getDailyStatistics(String date) async {
    var result = await _dioWrapper.get<Map<String, dynamic>>('$_baseUrl/$date');
    return result.map((data) => DailyStatisticsResponse.fromJson(data));
  }
}
