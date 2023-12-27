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
}
