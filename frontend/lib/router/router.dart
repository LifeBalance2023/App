import 'package:flutter/cupertino.dart';

class AppRouter {
  static const String main = '/home';
  static const String welcomeScreen = '/welcomeScreen';
  static const String login = '/login';
  static const String register = '/register';
  static const String taskCreator = '/taskCreator';
  static const String settings = '/settings';

  static Future<dynamic> goToWelcomeScreen(BuildContext context) => Navigator.pushNamed(context, welcomeScreen);

  static Future<dynamic> goToLogin(BuildContext context) => Navigator.pushNamed(context, login);

  static Future<dynamic> goToRegister(BuildContext context) => Navigator.pushNamed(context, register);

  static Future<dynamic> goToMainScreen(BuildContext context) => Navigator.pushNamed(context, main);

  static Future<dynamic> goToTaskCreator(BuildContext context) => Navigator.pushNamed(context, taskCreator);

  static Future<dynamic> goToSettings(BuildContext context) => Navigator.pushNamed(context, settings);

  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
