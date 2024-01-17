class DailyStatisticsResponse {
  String date;
  double lifeBalanceValue;
  int finishedTasks;
  int toDo;
  int allTasks;

  DailyStatisticsResponse({
    required this.date,
    required this.lifeBalanceValue,
    required this.finishedTasks,
    required this.toDo,
    required this.allTasks,
  });

  factory DailyStatisticsResponse.fromJson(Map<String, dynamic> json) => DailyStatisticsResponse(
        date: json['date'],
        lifeBalanceValue: json['lifeBalanceValue'].toDouble(),
        finishedTasks: json['finishedTasks'],
        toDo: json['toDo'],
        allTasks: json['allTasks'],
      );
}
