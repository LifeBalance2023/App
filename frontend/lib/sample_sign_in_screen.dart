import 'package:flutter/material.dart';
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
    return MaterialApp(
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
      home: createProviders(
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
        title: Text('Firebase Auth Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => signIn(context),
              child: Text('Sign In'),
            ),
            ElevatedButton(
              onPressed: () => signUp(context),
              child: Text('Sign Up'),
            ),
            ElevatedButton(
              onPressed: () => signInWithGoogle(context),
              child: Text('Sign In with Google'),
            ),
            ElevatedButton(
              onPressed: () => getUserId(context),
              child: Text('Get current user id'),
            ),
            ElevatedButton(
              onPressed: () => signOut(context),
              child: Text('Sign Out'),
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
          title: Text('Success'),
          content: Text('${result.value}'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Handle failure (show an error message)
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(result.error?.message ?? 'Unknown error'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
