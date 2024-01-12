import 'package:frontend/domain/result.dart';
import 'package:frontend/domain/task_entity.dart';

abstract class TaskCreatorState {
  final String title;
  String? description;
  final PriorityValue priority;
  final DateTime date;
  DateTime? notificationTime;

  TaskCreatorState({
    required this.title,
    this.description,
    required this.priority,
    required this.date,
    this.notificationTime,
  });
}

class TaskCreatorInitial extends TaskModificationState {
  TaskCreatorInitial()
      : super(
          title: '',
          priority: PriorityValue.low,
          date: DateTime.now(),
        );
}

class TaskModificationState extends TaskCreatorState {
  TaskModificationState({
    required String title,
    String? description,
    required PriorityValue priority,
    required DateTime date,
    DateTime? notificationTime,
  }) : super(
          title: title,
          description: description,
          priority: priority,
          date: date,
          notificationTime: notificationTime,
        );

  TaskModificationState copyWith({
    String? title,
    String? description,
    PriorityValue? priority,
    DateTime? date,
    DateTime? notificationTime,
  }) =>
      TaskModificationState(
        title: title ?? this.title,
        description: description ?? this.description,
        priority: priority ?? this.priority,
        date: date ?? this.date,
        notificationTime: notificationTime ?? this.notificationTime,
      );
}

class TaskCreationSavingInProgress extends TaskCreatorState {
  TaskCreationSavingInProgress({
    required String title,
    String? description,
    required PriorityValue priority,
    required DateTime date,
    DateTime? notificationTime,
  }) : super(
          title: title,
          description: description,
          priority: priority,
          date: date,
          notificationTime: notificationTime,
        );
}

class TaskCreationSavingSuccess extends TaskCreatorState {
  TaskCreationSavingSuccess({
    required String title,
    String? description,
    required PriorityValue priority,
    required DateTime date,
    DateTime? notificationTime,
  }) : super(
          title: title,
          description: description,
          priority: priority,
          date: date,
          notificationTime: notificationTime,
        );
}

class TaskCreationSavingFailure extends TaskCreatorState {
  final ResultError error;

  TaskCreationSavingFailure({
    required String title,
    String? description,
    required PriorityValue priority,
    required DateTime date,
    DateTime? notificationTime,
    required this.error,
  }) : super(
          title: title,
          description: description,
          priority: priority,
          date: date,
          notificationTime: notificationTime,
        );
}
