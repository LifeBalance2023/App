class DailyStatisticsValue {
  DateTime dateTime;
  int amountOfToDo;
  int amountOfDone;
  int amountOfAllTasks;
  double lifeBalanceValue;

  DailyStatisticsValue({
    required this.dateTime,
    required this.amountOfToDo,
    required this.amountOfDone,
    required this.amountOfAllTasks,
    required this.lifeBalanceValue,
  });
}

class UserStatisticsValue {
  int amountOfToDo;
  int amountOfDone;
  int amountOfAllTasks;
  double progress;

  UserStatisticsValue({
    required this.amountOfToDo,
    required this.amountOfDone,
    required this.amountOfAllTasks,
    required this.progress,
  });
}