import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:frontend/domain/task_entity.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationScheduler {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationScheduler() {
    _initializeNotifications();
    _requestPermissions();
    cancelAllNotifications();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('launch_background');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _requestPermissions() {
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> scheduleTaskNotification(TaskEntity task) async {
    if (task.notificationTime == null) {
      return;
    }
    await scheduleNotification(
      task.id.hashCode,
      task.title,
      task.description,
      task.notificationTime!,
    );
  }

  Future<void> scheduleNotification(int id, String title, String? body, DateTime scheduledTime) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'life_balance_id',
      'life_balance_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    if (kDebugMode) {
      print('Initial scheduling notification for $scheduledTime\n');
    }

    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidDetails);

    final tzDateTime = tz.TZDateTime.from(scheduledTime.toUtc(), tz.local);

    if (kDebugMode) {
      print('Scheduling notification for $tzDateTime\n');
      print(tz.TZDateTime.now(tz.local));
    }

    // await _flutterLocalNotificationsPlugin.zonedSchedule(
    //   id,
    //   title,
    //   body,
    //   tzDateTime,
    //   platformChannelSpecifics,
    //   uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    //   androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    // );

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  Future<void> cancelTaskNotification(TaskEntity task) async {
    await cancelNotification(task.id.hashCode);
  }

  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
