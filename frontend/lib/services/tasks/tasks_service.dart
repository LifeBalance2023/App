import 'package:frontend/api/tasks/requests/create_task_request.dart';
import 'package:frontend/api/tasks/requests/update_task_request.dart';
import 'package:frontend/domain/result.dart';
import 'package:frontend/domain/task_entity.dart';
import 'package:frontend/repository/task_repository.dart';
import 'package:frontend/scheduler/notification_scheduler.dart';
import 'package:frontend/services/tasks/adapters/task_adapter.dart';

import '../../api/tasks/tasks_api.dart';
import '../../repository/repository.dart';

class TasksService {
  final TasksApi _tasksApi;
  final TaskRepository _taskRepository;
  final NotificationScheduler _notificationScheduler;
  final TaskAdapter _taskAdapter = TaskAdapter();

  TasksService(this._tasksApi, this._taskRepository, this._notificationScheduler);

  Future<void> initializeNotifications() async {
    _taskRepository.addListener(_taskChangedListener);
  }

  void _taskChangedListener(RepositoryAction action, TaskEntity task) {
    if (action == RepositoryAction.delete || task.notificationTime == null) {
      _notificationScheduler.cancelTaskNotification(task);
    } else {
      _notificationScheduler.scheduleTaskNotification(task);
    }
  }

  Future<Result<void>> synchronizeTasks() async {
    final result = await _tasksApi.getTasks();
    return result.onSuccess((response) {
      final tasks = response.tasks.map(_taskAdapter.adapt).toList();
      _taskRepository.replaceAll(tasks);
    });
  }

  Result<List<TaskEntity>> getTasksForDate(DateTime date) => Result.success(_taskRepository.getTasksForDate(date));

  Result<List<TaskEntity>> getAllTasks() => Result.success(_taskRepository.getAll());

  Result<TaskEntity> getTaskById(String id) {
    final task = _taskRepository.get(id);
    if (task == null) {
      return Result.failure(Error(message: 'Task with id $id not found'));
    }
    return Result.success(task);
  }

  Future<Result<void>> createTask({
    required String title,
    required String description,
    required String priority,
    required String date,
    String? notificationTime,
  }) async {
    final request = CreateTaskRequest(title: title, description: description, priority: priority, date: date, notificationTime: notificationTime);
    final result = await _tasksApi.postTask(request);

    return result.onSuccess((response) {
      final task = _taskAdapter.adapt(response);
      _taskRepository.addOrUpdate(task);
    });
  }

  Future<Result<void>> updateTask({
    required String id,
    String? title,
    String? description,
    String? priority,
    String? date,
    String? notificationTime,
  }) async {
    var request = UpdateTaskRequest(title: title, description: description, priority: priority, date: date, notificationTime: notificationTime);
    final result = await _tasksApi.patchTask(id, request);

    return result.onSuccess((response) {
      final task = _taskAdapter.adapt(response);
      _taskRepository.addOrUpdate(task);
    });
  }

  Future<Result<void>> deleteTask(String id) async {
    final result = await _tasksApi.deleteTask(id);
    return result.onSuccess((response) {
      _taskRepository.delete(id);
    });
  }
}
