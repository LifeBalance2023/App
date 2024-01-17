import 'package:flutter/material.dart';
import 'package:frontend/providers.dart';
import 'package:frontend/screens/welcome_screen.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'firebase/firebase_configuration.dart';

void main() async {
  _initializeTimeZones();
  (await FirebaseConfiguration.initialize()).onFailure(print);
  runApp(const MyApp());
}

void _initializeTimeZones() {
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Poland'));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: createProviders(child: const WelcomeScreen()),
    );
  }
}
