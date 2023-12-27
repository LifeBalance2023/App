class UserStatisticsResponse {
  int amountOfToDo;
  int amountOfDone;
  int amountOfAllTasks;
  double progress;

  UserStatisticsResponse({
    required this.amountOfToDo,
    required this.amountOfDone,
    required this.amountOfAllTasks,
    required this.progress,
  });

  factory UserStatisticsResponse.fromJson(Map<String, dynamic> json) => UserStatisticsResponse(
        amountOfToDo: json['amountOfToDo'],
        amountOfDone: json['amountOfDone'],
        amountOfAllTasks: json['amountOfAllTasks'],
        progress: json['progress'].toDouble(),
      );
}
