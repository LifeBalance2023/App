import 'package:frontend/domain/identifiable.dart';

class TaskEntity implements Identifiable{
  @override
  String id;
  String title;
  String? description;
  PriorityValue priority;
  DateTime date;
  bool isDone;
  DateTime? notificationTime;

  TaskEntity({
    required this.id,
    required this.title,
    this.description,
    required this.priority,
    required this.date,
    required this.isDone,
    this.notificationTime,
  });
}

enum PriorityValue {
  low(1),
  medium(2),
  high(3);

  final int points;

  const PriorityValue(this.points);
}
