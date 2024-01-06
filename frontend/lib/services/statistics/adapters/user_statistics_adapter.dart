import 'package:frontend/api/statistics/responses/general_statistics_response.dart';
import 'package:frontend/domain/statistics_values.dart';

class UserStatisticsAdapter {
  UserStatisticsValue adapt(GeneralStatisticsResponse response) => UserStatisticsValue(
        amountOfToDo: response.toDo,
        amountOfDone: response.finishedTasks,
        amountOfAllTasks: response.allTasks,
        progress: response.progress,
      );
}
