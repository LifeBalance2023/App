import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/api/dio_wrapper.dart';
import 'package:frontend/cache/settings_cache.dart';
import 'package:frontend/services/authentication/authentication_service.dart';
import 'package:provider/provider.dart';
import 'domain/result.dart';
import 'package:frontend/providers.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'firebase/firebase_configuration.dart';

void main() async {
  _initializeTimeZones();
  (await FirebaseConfiguration.initialize()).onFailure(print);

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Life Balance App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: createProviders(
        dioWrapper: dioWrapper,
        child: SampleSignInScreen(),
      ),
    );
  }
}

class SampleSignInScreen extends StatelessWidget {
  final String email = 'test@example.com'; // Sample email
  final String password = 'password123'; // Sample password

  late AuthenticationService _authenticationService;

  @override
  Widget build(BuildContext context) {
    _authenticationService = Provider.of<AuthenticationService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Auth Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => signIn(context),
              child: const Text('Sign In'),
            ),
            ElevatedButton(
              onPressed: () => signUp(context),
              child: const Text('Sign Up'),
            ),
            ElevatedButton(
              onPressed: () => signInWithGoogle(context),
              child: const Text('Sign In with Google'),
            ),
            ElevatedButton(
              onPressed: () => getUserId(context),
              child: const Text('Get current user id'),
            ),
            ElevatedButton(
              onPressed: () => signOut(context),
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }

  void signIn(BuildContext context) async {
    final result = await _authenticationService.signIn(email: email, password: password);
    _handleAuthResult(context, result);
  }

  void signUp(BuildContext context) async {
    final result = await _authenticationService.signUp(email: email, password: password);
    _handleAuthResult(context, result);
  }

  void signInWithGoogle(BuildContext context) async {
    final result = await _authenticationService.signInWithGoogle();
    _handleAuthResult(context, result);
  }

  void getUserId(BuildContext context) async {
    final result = await _authenticationService.getUserId();
    _handleAuthResult(context, result);
  }

  void signOut(BuildContext context) async {
    final result = await _authenticationService.signOut();
    _handleAuthResult(context, result);
  }

  void _handleAuthResult<T>(BuildContext context, Result<T> result) {
    if (result.isSuccess) {
      // Handle success (navigate to another screen or show a success message)
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: Text('${result.value}'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Handle failure (show an error message)
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(result.error?.message ?? 'Unknown error'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
