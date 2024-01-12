import 'package:flutter/cupertino.dart';

class AppRouter {
    static const String home = '/';
    static const String taskCreator = '/taskCreator';
    static const String settings = '/settings';


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