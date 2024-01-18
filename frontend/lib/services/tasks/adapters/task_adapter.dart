import 'package:frontend/api/tasks/models/remote_task.dart';
import 'package:frontend/domain/task_entity.dart';

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
      case 'low':
        return PriorityValue.low;
      case 'medium':
        return PriorityValue.medium;
      case 'high':
        return PriorityValue.high;
      default:
        throw ArgumentError('Invalid priority value: $priorityString');
    }
  }
}
