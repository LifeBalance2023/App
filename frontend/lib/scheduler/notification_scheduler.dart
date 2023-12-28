import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:frontend/domain/task_entity.dart';
import 'package:frontend/repository/repository.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationScheduler {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  NotificationScheduler() {
    _initializeNotifications();
    _flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleNotification(
      int id, String title, String body, DateTime scheduledTime) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'life_balance_id',
      'life_balance_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  void taskChangedListener(TaskEntity task, RepositoryAction action) {
    if (action == RepositoryAction.delete || task.notificationTime == null) {
      cancelNotification(task.id.hashCode);
    } else {
      scheduleNotification(
        task.id.hashCode,
        task.title,
        task.description ?? '',
        task.notificationTime!,
      );
    }
  }
}
