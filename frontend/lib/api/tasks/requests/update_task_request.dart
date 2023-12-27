class UpdateTaskRequest {
  String title;
  String description;
  bool isDone;
  String priority;
  String date;
  String? notificationTime;

  UpdateTaskRequest({
    required this.title,
    required this.description,
    required this.isDone,
    required this.priority,
    required this.date,
    this.notificationTime,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'isDone': isDone,
        'priority': priority,
        'date': date,
        if (notificationTime != null) 'notificationTime': notificationTime,
      };
}
