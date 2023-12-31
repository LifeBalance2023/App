import 'package:frontend/api/authentication/authentication_api.dart';
import 'package:frontend/api/statistics/statistics_api.dart';
import 'package:frontend/api/tasks/tasks_api.dart';
import 'package:frontend/cache/settings_cache.dart';
import 'package:frontend/firebase/firebase_authenticator.dart';
import 'package:frontend/repository/task_repository.dart';
import 'package:frontend/repository/user_repository.dart';
import 'package:frontend/scheduler/notification_scheduler.dart';
import 'package:frontend/services/authentication/authentication_service.dart';
import 'package:frontend/services/settings/settings_service.dart';
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
      ProxyProvider3<AuthenticationApi, FirebaseAuthenticator, UserRepository, AuthenticationService>(
        update: (_, authenticationApi, firebaseAuthenticator, userRepository, __) =>
            AuthenticationService(authenticationApi, firebaseAuthenticator, userRepository),
      ),
      ProxyProvider<SettingsCache, SettingsService>(
        update: (_, settingsCache , __) => SettingsService(settingsCache),
      ),
    ];
