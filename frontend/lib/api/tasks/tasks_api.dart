import 'package:frontend/api/tasks/requests/create_task_request.dart';
import 'package:frontend/api/tasks/requests/update_task_request.dart';
import 'package:frontend/api/tasks/responses/get_tasks_response.dart';

import '../../domain/result.dart';
import '../dio_wrapper.dart';

class TasksApi {
  final DioWrapper _dioWrapper;

  TasksApi(DioWrapper dioWrapper) : _dioWrapper = dioWrapper;

  Future<Result<List<GetTasksResponse>>> getTasks() => _dioWrapper.get<List<GetTasksResponse>>('/tasks').then((result) {
        if (result.isSuccess) {
          return Result.success((result.value as List).map((taskJson) => GetTasksResponse.fromJson(taskJson)).toList());
        } else {
          return result;
        }
      });

  Future<Result<void>> postTask(CreateTaskRequest request) =>
      _dioWrapper.post('/tasks', data: request.toJson());

  Future<Result<void>> patchTask(String taskId, UpdateTaskRequest request) =>
      _dioWrapper.patch('/tasks/$taskId', data: request.toJson());

  Future<Result<void>> deleteTask(String taskId) =>
      _dioWrapper.delete('/tasks/$taskId');
}
