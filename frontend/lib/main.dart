import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/api/dio_wrapper.dart';
import 'package:frontend/cache/settings_cache.dart';
import 'package:frontend/providers.dart';
import 'package:frontend/router/router.dart';
import 'package:frontend/screens/auth/login/login_screen.dart';
import 'package:frontend/screens/auth/register/register_screen.dart';
import 'package:frontend/screens/main/main_screen.dart';
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
  final dioWrapper = await DioWrapper.create(Dio(), SettingsCache());
  runApp(MyApp(dioWrapper: dioWrapper));
}

void _initializeTimeZones() {
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Poland'));
}

class MyApp extends StatelessWidget {
  final DioWrapper dioWrapper;

  const MyApp({super.key, required this.dioWrapper});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return createProviders(
        dioWrapper: dioWrapper,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Life Balance App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const WelcomeScreen(),
          routes: {
            AppRouter.taskCreator: (context) => const TaskCreatorScreen(),
            AppRouter.settings: (context) => const SettingsScreen(),
            AppRouter.welcomeScreen: (context) => const WelcomeScreen(),
            AppRouter.login: (context) => const LoginScreen(),
            AppRouter.register: (context) => const RegisterScreen(),
            AppRouter.main: (context) => const MainScreen(),
          },
        ));
  }
}
