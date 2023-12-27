import 'package:frontend/api/tasks/requests/create_task_request.dart';
import 'package:frontend/api/tasks/requests/update_task_request.dart';
import 'package:frontend/domain/result.dart';
import 'package:frontend/domain/task_entity.dart';
import 'package:frontend/repository/task_repository.dart';
import 'package:frontend/services/tasks/adapters/task_adapter.dart';

import '../../api/tasks/tasks_api.dart';

class TasksService {
  final TasksApi _tasksApi;
  final TaskRepository _taskRepository;
  final TaskAdapter _taskAdapter = TaskAdapter();

  TasksService(this._tasksApi, this._taskRepository);

  Future<Result<void>> synchronizeTasks() => _tasksApi.getTasks().then((value) => value.onSuccess((response) {
        final tasks = response.tasks.map((remoteTask) => _taskAdapter.adapt(remoteTask)).toList();
        _taskRepository.replaceAll(tasks);
      }));

  Result<List<TaskEntity>> getTasksForDate(DateTime date) => Result.success(_taskRepository.getTasksForDate(date));

  Result<List<TaskEntity>> getAllTasks() => Result.success(_taskRepository.getAll());

  Result<TaskEntity> getTaskById(String id) => Result.success(_taskRepository.get(id));

  Future<Result<void>> createTask({
    required String title,
    required String description,
    required String priority,
    required String date,
    String? notificationTime,
  }) =>
      _tasksApi
          .postTask(
              CreateTaskRequest(title: title, description: description, priority: priority, date: date, notificationTime: notificationTime))
          .then((value) => value.onSuccess((response) {
                final task = _taskAdapter.adapt(response);
                _taskRepository.addOrUpdate(task);
              }));

  Future<Result<void>> updateTask({
    required String id,
    String? title,
    String? description,
    String? priority,
    String? date,
    String? notificationTime,
  }) =>
      _tasksApi
          .patchTask(id,
              UpdateTaskRequest(title: title, description: description, priority: priority, date: date, notificationTime: notificationTime))
          .then((value) => value.onSuccess((response) {
                final task = _taskAdapter.adapt(response);
                _taskRepository.addOrUpdate(task);
              }));

  Future<Result<void>> deleteTask(String id) => _tasksApi.deleteTask(id).then((value) => value.onSuccess((response) {
        _taskRepository.delete(id);
      }));
}
