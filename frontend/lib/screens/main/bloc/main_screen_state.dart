import 'package:frontend/domain/statistics_values.dart';
import 'package:frontend/domain/task_entity.dart';

abstract class MainScreenState {}

class ShowProgressIndicator extends MainScreenState {}

class GoToWelcomeScreen extends MainScreenState {}

class ShowErrorMessage extends MainScreenState {
  final String message;

  ShowErrorMessage(this.message);
}

class ShowMainScreen extends MainScreenState {
  final List<TaskEntity> tasks;
  final DailyStatisticsValue statistics;

  ShowMainScreen(this.tasks, this.statistics);
}
