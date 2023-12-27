class RemoteTask {
  String id;
  String title;
  String? description;
  String priority;
  bool isDone;
  String date;
  String? notificationTime;

  RemoteTask({
    required this.id,
    required this.title,
    this.description,
    required this.priority,
    required this.isDone,
    required this.date,
    this.notificationTime,
  });

  factory RemoteTask.fromJson(Map<String, dynamic> json) => RemoteTask(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    priority: json['priority'],
    isDone: json['isDone'],
    date: json['date'],
    notificationTime: json['notificationTime'],
  );
}
