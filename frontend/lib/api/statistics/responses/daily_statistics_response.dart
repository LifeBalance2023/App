class DailyStatisticsResponse {
  String dateTime;
  int amountOfToDo;
  int amountOfDone;
  int amountOfAllTasks;
  double lifeBalanceValue;

  DailyStatisticsResponse({
    required this.dateTime,
    required this.amountOfToDo,
    required this.amountOfDone,
    required this.amountOfAllTasks,
    required this.lifeBalanceValue,
  });

  factory DailyStatisticsResponse.fromJson(Map<String, dynamic> json) => DailyStatisticsResponse(
        dateTime: json['dateTime'],
        amountOfToDo: json['amountOfToDo'],
        amountOfDone: json['amountOfDone'],
        amountOfAllTasks: json['amountOfAllTasks'],
        lifeBalanceValue: json['lifeBalanceValue'].toDouble(),
      );
}
