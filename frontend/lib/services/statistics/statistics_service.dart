import 'package:frontend/api/statistics/statistics_api.dart';
import 'package:frontend/domain/result.dart';
import 'package:frontend/domain/statistics_values.dart';
import 'package:frontend/services/statistics/adapters/daily_statistics_adapter.dart';
import 'package:frontend/services/statistics/adapters/user_statistics_adapter.dart';
import 'package:frontend/utils/date_time_formatter.dart';

class StatisticsService {
  final StatisticsApi _statisticsApi;
  final UserStatisticsAdapter _userStatisticsAdapter = UserStatisticsAdapter();
  final DailyStatisticsAdapter _dailyStatisticsAdapter = DailyStatisticsAdapter();

  StatisticsService(this._statisticsApi);

  Future<Result<UserStatisticsValue>> getUserStatistics() async {
    final response = await _statisticsApi.getUserStatistics();
    return response.map(_userStatisticsAdapter.adapt);
  }

  Future<Result<DailyStatisticsValue>> getDailyStatistics(DateTime date) async {
    final response = await _statisticsApi.getDailyStatistics(DateTimeFormatter.toStringDate(date));
    return response.map(_dailyStatisticsAdapter.adapt);
  }
}
