import 'package:flutter/material.dart';
import 'package:frontend/providers.dart';
import 'package:frontend/scheduler/notification_scheduler.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'domain/task_entity.dart';

void main() {
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Poland'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notification Scheduler - Life Balance Sample App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: createProviders(MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final NotificationScheduler _notificationScheduler = NotificationScheduler();

  @override
  void initState() {
    super.initState();
  }

  void _scheduleTestTaskNotification() async {
    var task = TaskEntity(
      id: '1',
      title: 'Sample Task',
      description: 'This is a sample task',
      priority: PriorityValue.medium,
      date: DateTime.now(),
      isDone: false,
      notificationTime: DateTime.now().add(const Duration(seconds: 10)),
    );

    await _notificationScheduler.scheduleTaskNotification(task);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Notification Tester'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _scheduleTestTaskNotification,
          child: const Text('Schedule Test Task Notification'),
        ),
      ),
    );
  }
}