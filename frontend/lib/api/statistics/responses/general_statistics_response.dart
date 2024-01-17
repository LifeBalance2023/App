class GeneralStatisticsResponse {
  double progress;
  int finishedTasks;
  int toDo;
  int allTasks;

  GeneralStatisticsResponse({
    required this.progress,
    required this.finishedTasks,
    required this.toDo,
    required this.allTasks,
  });

  factory GeneralStatisticsResponse.fromJson(Map<String, dynamic> json) => GeneralStatisticsResponse(
        progress: json['progress'].toDouble(),
        finishedTasks: json['finishedTasks'],
        toDo: json['toDo'],
        allTasks: json['allTasks'],
      );
}
