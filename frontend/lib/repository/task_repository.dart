import 'package:frontend/domain/task_entity.dart';
import 'package:frontend/repository/repository.dart';

class TaskRepository extends Repository<TaskEntity> {
  List<TaskEntity> getTasksForDate(DateTime date) =>
      getAll().where((task) => task.date == date).toList();
}