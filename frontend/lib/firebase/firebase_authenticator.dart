import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../domain/result.dart';

class FirebaseAuthenticator {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<Result<UserCredential>> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return Result.success(userCredential);
    } on FirebaseAuthException catch (e) {
      return Result.failure(Error(message: "Code:${e.code} Message:${e.message}"));
    } catch (e) {
      return Result.failure(Error(message: e.toString()));
    }
  }

  Future<Result<UserCredential>> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return Result.success(userCredential);
    } on FirebaseAuthException catch (e) {
      return Result.failure(Error(message: "Code:${e.code} Message:${e.message}"));
    } catch (e) {
      return Result.failure(Error(message: e.toString()));
    }
  }

  Future<Result<UserCredential>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return Result.failure(Error(message: "Google sign-in was cancelled by user"));
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      return Result.success(userCredential);
    } on FirebaseAuthException catch (e) {
      return Result.failure(Error(message: "Code:${e.code} Message:${e.message}"));
    } catch (e) {
      return Result.failure(Error(message: e.toString()));
    }
  }

  Future<Result<User>> getCurrentUser() async {
    try {
      User? user = _auth.currentUser;

      switch (user) {
        case null:
          return Result.failure(Error(message: "User not logged in"));
        default:
          return Result.success(user);
      }
    } on FirebaseAuthException catch (e) {
      return Result.failure(Error(message: "Code:${e.code} Message:${e.message}"));
    } catch (e) {
      return Result.failure(Error(message: e.toString()));
    }
  }

  Future<Result<void>> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      return Result.success(null);
    } on FirebaseAuthException catch (e) {
      return Result.failure(Error(message: "Code:${e.code} Message:${e.message}"));
    } catch (e) {
      return Result.failure(Error(message: e.toString()));
    }
  }
}
