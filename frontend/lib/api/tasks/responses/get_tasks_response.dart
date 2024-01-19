import '../models/remote_task.dart';

class GetTasksResponse {
  List<RemoteTask> tasks;

  GetTasksResponse({
    required this.tasks,
  });

  factory GetTasksResponse.fromJson(Map<String, dynamic> json) =>
      GetTasksResponse(tasks: (json['tasks'] as List<dynamic>).map((task) => RemoteTask.fromJson(task)).toList());
}
