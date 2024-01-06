import 'package:frontend/api/authentication/authentication_api.dart';
import 'package:frontend/api/statistics/statistics_api.dart';
import 'package:frontend/api/tasks/tasks_api.dart';
import 'package:frontend/repository/task_repository.dart';
import 'package:frontend/scheduler/notification_scheduler.dart';
import 'package:frontend/services/authentication/authentication_service.dart';
import 'package:frontend/services/statistics/statistics_service.dart';
import 'package:frontend/services/tasks/tasks_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> createServicesProviders() => [
      ProxyProvider3<TasksApi, TaskRepository, NotificationScheduler, TasksService>(
        update: (_, tasksApi, taskRepository, notificationScheduler, __) => TasksService(tasksApi, taskRepository, notificationScheduler),
      ),
      ProxyProvider<StatisticsApi, StatisticsService>(
        update: (_, statisticsApi, __) => StatisticsService(statisticsApi),
      ),
      ProxyProvider<AuthenticationApi, AuthenticationService>(
        update: (_, authenticationApi, __) => AuthenticationService(authenticationApi),
      ),
    ];
