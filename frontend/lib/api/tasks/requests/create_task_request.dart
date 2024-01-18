class CreateTaskRequest {
  String title;
  String? description;
  String priority;
  String date;
  String? notificationTime;
  bool isDone;

  CreateTaskRequest({
    required this.title,
    this.description,
    required this.priority,
    required this.date,
    this.notificationTime,
    this.isDone = false,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'priority': priority,
        'date': date,
        if (notificationTime != null) 'notificationTime': notificationTime,
        'isDone': isDone,
      };
}
