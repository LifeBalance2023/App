import 'package:flutter/material.dart';
import 'package:frontend/providers.dart';
import 'package:frontend/router/router.dart';
import 'package:frontend/screens/auth/login/login_screen.dart';
import 'package:frontend/screens/auth/register/register_screen.dart';
import 'package:frontend/screens/settings/settings_screen.dart';
import 'package:frontend/screens/task_creator/task_creator_screen.dart';
import 'package:frontend/screens/welcome_screen.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'firebase/firebase_configuration.dart';

void main() async {
  _initializeTimeZones();
  (await FirebaseConfiguration.initialize()).onFailure((error) {
    print(error.message);
  });
  runApp(const MyApp());
}

void _initializeTimeZones() {
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Poland'));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return createProviders(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Life Balance App',
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
      home: const WelcomeScreen(),
      routes: {
        AppRouter.taskCreator: (context) => const TaskCreatorScreen(),
        AppRouter.settings: (context) => const SettingsScreen(),
        AppRouter.welcomeScreen: (context) => const WelcomeScreen(),
        AppRouter.login: (context) => const LoginScreen(),
        AppRouter.register: (context) => const RegisterScreen(),
      },
    ));
  }
}
