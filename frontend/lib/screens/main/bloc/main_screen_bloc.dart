import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/screens/main/bloc/main_screen_event.dart';
import 'package:frontend/screens/main/bloc/main_screen_state.dart';
import 'package:frontend/services/authentication/authentication_service.dart';
import 'package:frontend/services/statistics/statistics_service.dart';
import 'package:frontend/services/tasks/tasks_service.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final AuthenticationService _authenticationService;
  final TasksService _tasksService;
  final StatisticsService _statisticsService;

  MainScreenBloc(this._authenticationService, this._tasksService, this._statisticsService) : super(ShowProgressIndicator()) {
    on<LoadMainScreen>(_onLoadTasks);
  }

  Future<void> _onLoadTasks(LoadMainScreen event, Emitter<MainScreenState> emit) async {
    final userIdResult = await _authenticationService.getUserId();

    userIdResult.onFailure((error) {
      emit(GoToWelcomeScreen());
    }).onSuccess((userId) {
      _loadTasks(emit);
    });
  }

  Future<void> _loadTasks(Emitter<MainScreenState> emit) async {
    final synchronizeTasksResult = await _tasksService.synchronizeTasks();
    synchronizeTasksResult.onFailure((error) {
      emit(MainScreenError("Error synchronizing tasks: ${error.code} ${error.message}}"));
    }).onSuccess((p0) {
      _loadStatistics(emit);
    });
  }

  Future<void> _loadStatistics(Emitter<MainScreenState> emit) async {
    final getStatisticsResult = await _statisticsService.getDailyStatistics(DateTime.now());
    getStatisticsResult.onFailure((error) {
      emit(MainScreenError("Error getting statistics: ${error.code} ${error.message}}"));
    }).onSuccess((statistics) {
      final tasksResult = _tasksService.getTasksForDate(DateTime.now()); // TODO: Think about getting all tasks

      tasksResult.onFailure((error) {
        emit(MainScreenError("Error getting tasks: ${error.code} ${error.message}}"));
      }).onSuccess((tasks) {
        emit(ShowMainScreen(tasks, statistics));
      });
    });
  }
}
