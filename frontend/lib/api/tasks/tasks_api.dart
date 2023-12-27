import 'package:frontend/api/tasks/models/remote_task.dart';
import 'package:frontend/api/tasks/requests/create_task_request.dart';
import 'package:frontend/api/tasks/requests/update_task_request.dart';
import 'package:frontend/api/tasks/responses/get_tasks_response.dart';

import '../../domain/result.dart';
import '../dio_wrapper.dart';

class TasksApi {
  final DioWrapper _dioWrapper;
  final String _baseUrl = '/tasks';

  TasksApi(DioWrapper dioWrapper) : _dioWrapper = dioWrapper;

  Future<Result<GetTasksResponse>> getTasks() => _dioWrapper
      .get<Map<String, dynamic>>(_baseUrl)
      .then((result) => result.map((result) => GetTasksResponse.fromJson(result)));

  Future<Result<RemoteTask>> postTask(CreateTaskRequest request) => _dioWrapper
      .post(_baseUrl, data: request.toJson())
      .then((value) => value.map((value) => RemoteTask.fromJson(value)));

  Future<Result<RemoteTask>> patchTask(String taskId, UpdateTaskRequest request) => _dioWrapper
      .patch('$_baseUrl/$taskId', data: request.toJson())
      .then((value) => value.map((value) => RemoteTask.fromJson(value)));

  Future<Result<RemoteTask>> deleteTask(String taskId) => _dioWrapper
      .delete('$_baseUrl/$taskId')
      .then((value) => value.map((value) => RemoteTask.fromJson(value)));
}
