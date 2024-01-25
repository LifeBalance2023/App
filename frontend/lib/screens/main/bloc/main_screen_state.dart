import 'package:frontend/domain/statistics_values.dart';
import 'package:frontend/domain/task_entity.dart';

abstract class MainScreenState {}

class ShowProgressIndicator extends MainScreenState {}

class GoToWelcomeScreen extends MainScreenState {}

class MainScreenError extends MainScreenState {
  final String errorMessage;

  MainScreenError(this.errorMessage);
}

class ShowMainScreen extends MainScreenState {
  final List<TaskEntity> tasks;
  final DailyStatisticsValue statistics;
  late final double lifeBalancePercentage;
  late final String harmonyText;

  ShowMainScreen(this.tasks, this.statistics) {
    _sortTasks(tasks);
    lifeBalancePercentage = statistics.lifeBalanceValue * 100;
    harmonyText = _generateHarmonyText(lifeBalancePercentage);
  }

  String _generateHarmonyText(double lifeBalancePercentage) {
    if(lifeBalancePercentage <= 24.0) {
      return 'Disharmony Synchrony';
    } else if(lifeBalancePercentage <= 49.0) {
      return 'Mediocre Melody';
    } else if(lifeBalancePercentage <= 74.0) {
      return 'Semi-Euphony';
    } else {
      return 'Complete Harmony';
    }
  }

  void _sortTasks(List<TaskEntity> tasks) {
    tasks.sort((a, b) {
      if (a.isDone != b.isDone) {
        return a.isDone ? 1 : -1;
      }
      return a.date.compareTo(b.date);
    });
  }
}
