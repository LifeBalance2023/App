import 'package:firebase_auth/firebase_auth.dart';

import '../domain/result.dart';

class FirebaseAuthenticator {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Result<UserCredential>> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return Result.success(userCredential);
    } on FirebaseAuthException catch (e) {
      return Result.failure(Error(message: "${e.code} ${e.message}"));
    } catch (e) {
      return Result.failure(Error(message: e.toString()));
    }
  }

  Future<Result<UserCredential>> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return Result.success(userCredential);
    } on FirebaseAuthException catch (e) {
      return Result.failure(Error(message: "${e.code} ${e.message}"));
    } catch (e) {
      return Result.failure(Error(message: e.toString()));
    }
  }
}
