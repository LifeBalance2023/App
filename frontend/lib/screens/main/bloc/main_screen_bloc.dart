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
    on<LoadMainScreen>(_onLoadMainScreen);
    on<GetTasksAndStatistics>(_onGetTasksAndStatistics);
    on<SignOutRequest>(_onSignOutRequest);
    on<ClickDoneButton>(_onClickDoneButton);
  }

  Future<void> _onLoadMainScreen(LoadMainScreen event, Emitter<MainScreenState> emit) async {
    final userIdResult = await _authenticationService.getUserId();

    if (userIdResult.isSuccess) {
      await _synchronizeTasks(emit);
    } else {
      emit(GoToWelcomeScreen());
    }
  }

  Future<void> _synchronizeTasks(Emitter<MainScreenState> emit) async {
    final synchronizeTasksResult = await _tasksService.synchronizeTasks();

    if (synchronizeTasksResult.isFailure) {
      emit(MainScreenError("Error synchronizing tasks: ${synchronizeTasksResult.error.code} ${synchronizeTasksResult.error.message}}"));
      return;
    }

    await _loadTasksAndStatistics(emit);
  }

  Future<void> _loadTasksAndStatistics(Emitter<MainScreenState> emit) async {
    final getStatisticsResult = await _statisticsService.getDailyStatistics(DateTime.now());
    getStatisticsResult.onFailure((error) {
      emit(MainScreenError("Error getting statistics: ${error.code} ${error.message}}"));
    }).onSuccess((statistics) {
      final tasksResult = _tasksService.getAllTasks(); // TODO: Choose specific date

      tasksResult.onFailure((error) {
        emit(MainScreenError("Error getting tasks: ${error.code} ${error.message}}"));
      }).onSuccess((tasks) {
        emit(ShowMainScreen(tasks, statistics));
      });
    });
  }

  Future<void> _onGetTasksAndStatistics(GetTasksAndStatistics event, Emitter<MainScreenState> emit) async {
    await _loadTasksAndStatistics(emit);
  }

  Future<void> _onSignOutRequest(SignOutRequest event, Emitter<MainScreenState> emit) async {
    final signOutResult = await _authenticationService.signOut();

    signOutResult
        .onFailure((error) => emit(MainScreenError("Error while signing out: ${error.code} ${error.message}}")))
        .onSuccess((_) => emit(GoToWelcomeScreen()));
  }

  Future<void> _onClickDoneButton(ClickDoneButton event, Emitter<MainScreenState> emit) async {
    emit(ShowProgressIndicator());

    final updateTaskResult = await _tasksService.updateTask(
      id: event.task.id,
      isDone: !event.task.isDone,
    );

    updateTaskResult
        .onFailure((error) => emit(MainScreenError("Error while updating task: ${error.code} ${error.message}}")))
        .onSuccess((_) => _loadTasksAndStatistics(emit));
  }
}
