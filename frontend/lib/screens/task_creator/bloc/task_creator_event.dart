abstract class TaskCreatorEvent {}

class TaskCreatorTitleChanged extends TaskCreatorEvent {
  final String title;

  TaskCreatorTitleChanged(this.title);
}

class TaskCreatorDescriptionChanged extends TaskCreatorEvent {
  final String description;

  TaskCreatorDescriptionChanged(this.description);
}

class TaskCreatorPriorityChanged extends TaskCreatorEvent {
  final int priority;

  TaskCreatorPriorityChanged(this.priority);
}

class TaskCreatorDateChanged extends TaskCreatorEvent {
  final DateTime date;

  TaskCreatorDateChanged(this.date);
}

class TaskCreatorNotificationTimeChanged extends TaskCreatorEvent {
  final DateTime notificationTime;

  TaskCreatorNotificationTimeChanged(this.notificationTime);
}

class TaskCreatorSaveRequested extends TaskCreatorEvent {}
