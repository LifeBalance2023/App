import 'package:frontend/api/tasks/models/remote_task.dart';
import 'package:frontend/api/tasks/requests/create_task_request.dart';
import 'package:frontend/api/tasks/requests/update_task_request.dart';
import 'package:frontend/api/tasks/responses/get_tasks_response.dart';
import 'package:frontend/repository/user_repository.dart';

import '../../domain/result.dart';
import '../dio_wrapper.dart';

class TasksApi {
  final DioWrapper _dioWrapper;
  final UserRepository _userRepository;
  final String _baseUrl = '/tasks';

  TasksApi(this._dioWrapper, this._userRepository);

  Future<Result<GetTasksResponse>> getTasks() async {
    var result = await _dioWrapper.get<Map<String, dynamic>>('$_baseUrl/${_userRepository.getUserId()}/');
    return result.map((data) => GetTasksResponse.fromJson(data));
  }

  Future<Result<RemoteTask>> postTask(CreateTaskRequest request) async {
    var result = await _dioWrapper.post('$_baseUrl/${_userRepository.getUserId()}', data: request.toJson());
    return result.map((data) => RemoteTask.fromJson(data));
  }

  Future<Result<RemoteTask>> patchTask(String taskId, UpdateTaskRequest request) async {
    var result = await _dioWrapper.patch('$_baseUrl/${_userRepository.getUserId()}/$taskId', data: request.toJson());
    return result.map((data) => RemoteTask.fromJson(data));
  }

  Future<Result<RemoteTask>> deleteTask(String taskId) async {
    var result = await _dioWrapper.delete('$_baseUrl/${_userRepository.getUserId()}/$taskId');
    return result.map((data) => RemoteTask.fromJson(data));
  }
}
