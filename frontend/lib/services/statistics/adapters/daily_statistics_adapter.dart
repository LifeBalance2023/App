import 'package:frontend/api/statistics/responses/daily_statistics_response.dart';
import 'package:frontend/domain/statistics_values.dart';

class DailyStatisticsAdapter {
  DailyStatisticsValue adapt(DailyStatisticsResponse response) => DailyStatisticsValue(
        dateTime: DateTime.parse(response.date),
        amountOfToDo: response.toDo,
        amountOfDone: response.finishedTasks,
        amountOfAllTasks: response.allTasks,
        lifeBalanceValue: response.lifeBalanceValue,
      );
}
