import 'package:frontend/api/statistics/responses/daily_statistics_response.dart';
import 'package:frontend/api/statistics/responses/general_statistics_response.dart';
import 'package:frontend/repository/user_repository.dart';

import '../../domain/result.dart';
import '../dio_wrapper.dart';

class StatisticsApi {
  final DioWrapper _dioWrapper;
  final UserRepository _userRepository;
  final String _baseUrl = '/statistics';

  StatisticsApi(this._dioWrapper, this._userRepository);

  Future<Result<GeneralStatisticsResponse>> getUserStatistics() async {
    var result = await _dioWrapper.get<Map<String, dynamic>>('$_baseUrl/${_userRepository.getUserId()}/');
    return result.map((data) => GeneralStatisticsResponse.fromJson(data));
  }

  Future<Result<DailyStatisticsResponse>> getDailyStatistics(String date) async {
    var result = await _dioWrapper.get<Map<String, dynamic>>('$_baseUrl/${_userRepository.getUserId()}?date=$date');
    return result.map((data) => DailyStatisticsResponse.fromJson(data));
  }
}
