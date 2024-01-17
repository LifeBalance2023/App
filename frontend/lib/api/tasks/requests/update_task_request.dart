class UpdateTaskRequest {
  String? title;
  String? description;
  bool? isDone;
  String? priority;
  String? date;
  String? notificationTime;

  UpdateTaskRequest({
    this.title,
    this.description,
    this.isDone,
    this.priority,
    this.date,
    this.notificationTime,
  });

  Map<String, dynamic> toJson() => {
        if (title != null) 'title': title,
        if (description != null) 'description': description,
        if (isDone != null) 'isDone': isDone,
        if (priority != null) 'priority': priority,
        if (date != null) 'date': date,
        if (notificationTime != null) 'notificationTime': notificationTime,
      };
}
