import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'domain/result.dart';
import 'firebase/firebase_authenticator.dart';

class SampleSignInScreen extends StatelessWidget {
  final FirebaseAuthenticator _authenticator = FirebaseAuthenticator();

  final String email = 'test@example.com'; // Sample email
  final String password = 'password123';  // Sample password

  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      ),
    );
  }

  void signIn(BuildContext context) async {
    final result = await _authenticator.signIn(email, password);
    _handleAuthResult(context, result);
  }

  void signUp(BuildContext context) async {
    final result = await _authenticator.signUp(email, password);
    _handleAuthResult(context, result);
  }

  void signInWithGoogle(BuildContext context) async {
    final result = await _authenticator.signInWithGoogle();
    _handleAuthResult(context, result);
  }

  void _handleAuthResult(BuildContext context, Result<UserCredential> result) {
    if (result.isSuccess) {
      // Handle success (navigate to another screen or show a success message)
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Authentication successful!'),
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