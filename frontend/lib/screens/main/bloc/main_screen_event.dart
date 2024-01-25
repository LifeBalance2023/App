import 'package:frontend/domain/task_entity.dart';

abstract class MainScreenEvent {}

class LoadMainScreen extends MainScreenEvent {}

class GetTasksAndStatistics extends MainScreenEvent {}

class SignOutRequest extends MainScreenEvent {}

class ClickDoneButton extends MainScreenEvent {
  final TaskEntity task;

  ClickDoneButton(this.task);
}