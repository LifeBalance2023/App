import '../../api/tasks/models/remote_task.dart';
import '../../domain/task_entity.dart';

class TaskAdapter {
  TaskEntity adapt(RemoteTask remoteTask) => TaskEntity(
      id: remoteTask.id,
      title: remoteTask.title,
      description: remoteTask.description,
      priority: _mapPriority(remoteTask.priority),
      date: DateTime.parse(remoteTask.date),
      isDone: remoteTask.isDone,
      notificationTime: remoteTask.notificationTime != null
          ? DateTime.parse(remoteTask.notificationTime!)
          : null,
    );

  PriorityValue _mapPriority(String priorityString) {
    switch (priorityString.toLowerCase()) {
      case 'LOW':
        return PriorityValue.low;
      case 'MEDIUM':
        return PriorityValue.medium;
      case 'HIGH':
        return PriorityValue.high;
      default:
        throw ArgumentError('Invalid priority value: $priorityString');
    }
  }
}
