class CreateTaskRequest {
  String title;
  String? description;
  String priority;
  String date;
  String? notificationTime;

  CreateTaskRequest({
    required this.title,
    this.description,
    required this.priority,
    required this.date,
    this.notificationTime,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'priority': priority,
        'date': date,
        if (notificationTime != null) 'notificationTime': notificationTime,
      };
}
