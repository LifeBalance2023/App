import 'package:flutter/cupertino.dart';

class AppRouter {
    static const String home = '/';
    static const String welcomeScreen = '/welcomeScreen';
    static const String login = '/login';
    static const String register = '/register';
    static const String taskCreator = '/taskCreator';
    static const String settings = '/settings';

    static void goToWelcomeScreen(BuildContext context) {
        Navigator.pushNamed(context, welcomeScreen);
    }
    
    static void goToLogin(BuildContext context) {
        Navigator.pushNamed(context, login);
    }
    
    static void goToRegister(BuildContext context) {
        Navigator.pushNamed(context, register);
    }

    static void goToHome(BuildContext context) {
        Navigator.pushNamed(context, home);
    }

    static void goToTaskCreator(BuildContext context) {
        Navigator.pushNamed(context, taskCreator);
    }

    static void goToSettings(BuildContext context) {
        Navigator.pushNamed(context, settings);
    }

    static void goBack(BuildContext context) {
        Navigator.pop(context);
    }
}