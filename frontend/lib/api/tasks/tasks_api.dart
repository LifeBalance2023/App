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

  Future<Result<GetTasksResponse>> getTasks() async {
    var result = await _dioWrapper.get<Map<String, dynamic>>('$_baseUrl/');
    return result.map((data) => GetTasksResponse.fromJson(data));
  }

  Future<Result<RemoteTask>> postTask(CreateTaskRequest request) async {
    var result = await _dioWrapper.post('$_baseUrl/', data: request.toJson());
    return result.map((data) => RemoteTask.fromJson(data));
  }

  Future<Result<RemoteTask>> patchTask(String taskId, UpdateTaskRequest request) async {
    var result = await _dioWrapper.patch('$_baseUrl/$taskId', data: request.toJson());
    return result.map((data) => RemoteTask.fromJson(data));
  }

  Future<Result<RemoteTask>> deleteTask(String taskId) async {
    var result = await _dioWrapper.delete('$_baseUrl/$taskId');
    return result.map((data) => RemoteTask.fromJson(data));
  }
}
