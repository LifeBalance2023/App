import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/screens/task_creator/bloc/task_creator_event.dart';
import 'package:frontend/screens/task_creator/bloc/task_creator_state.dart';
import 'package:frontend/services/tasks/tasks_service.dart';

class TaskCreatorBloc extends Bloc<TaskCreatorEvent, TaskCreatorState> {
  final TasksService _tasksService;

  TaskCreatorBloc(this._tasksService) : super(TaskCreatorInitial()) {
    on<TaskCreatorTitleChanged>(_onTitleChanged);
    on<TaskCreatorDescriptionChanged>(_onDescriptionChanged);
    on<TaskCreatorPriorityChanged>(_onPriorityChanged);
    on<TaskCreatorDateChanged>(_onDateChanged);
    on<TaskCreatorNotificationTimeChanged>(_onNotificationTimeChanged);
    on<TaskCreatorSaveRequested>(_onSaveRequested);
  }

  void _onTitleChanged(TaskCreatorTitleChanged event, Emitter<TaskCreatorState> emit) {
    if (state is TaskModificationState) {
      emit((state as TaskModificationState).copyWith(title: event.title));
    }
  }

  void _onDescriptionChanged(TaskCreatorDescriptionChanged event, Emitter<TaskCreatorState> emit) {
    if (state is TaskModificationState) {
      emit((state as TaskModificationState).copyWith(description: event.description));
    }
  }

  void _onPriorityChanged(TaskCreatorPriorityChanged event, Emitter<TaskCreatorState> emit) {
    if (state is TaskModificationState) {
      emit((state as TaskModificationState).copyWith(priority: event.priority));
    }
  }

  void _onDateChanged(TaskCreatorDateChanged event, Emitter<TaskCreatorState> emit) {
    if (state is TaskModificationState) {
      emit((state as TaskModificationState).copyWith(date: event.date));
    }
  }

  void _onNotificationTimeChanged(TaskCreatorNotificationTimeChanged event, Emitter<TaskCreatorState> emit) {
    if (state is TaskModificationState) {
      emit((state as TaskModificationState).copyWith(notificationTime: event.notificationTime));
    }
  }

  Future<void> _onSaveRequested(TaskCreatorSaveRequested event, Emitter<TaskCreatorState> emit) async {
    emit(TaskCreationSavingInProgress(
      title: state.title,
      description: state.description,
      priority: state.priority,
      date: state.date,
      notificationTime: state.notificationTime,
    ));

    var result = await _tasksService.createTask(
      title: state.title,
      description: state.description,
      priority: state.priority.name,
      date: state.date.toString(),
      notificationTime: state.notificationTime?.toString(),
    );

    result
        .onFailure((error) => emit(TaskCreationSavingFailure(
              title: state.title,
              description: state.description,
              priority: state.priority,
              date: state.date,
              notificationTime: state.notificationTime,
              error: error,
            )))
        .onSuccess((_) => emit(TaskCreationSavingSuccess(
              title: state.title,
              description: state.description,
              priority: state.priority,
              date: state.date,
              notificationTime: state.notificationTime,
            )));
  }
}
