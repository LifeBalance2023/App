import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/api/authentication/authentication_api.dart';
import 'package:frontend/api/authentication/requests/add_user_request.dart';
import 'package:frontend/domain/result.dart';
import 'package:frontend/domain/user_entity.dart';
import 'package:frontend/firebase/firebase_authenticator.dart';
import 'package:frontend/repository/user_repository.dart';

class AuthenticationService {
  final AuthenticationApi _authenticationApi;
  final FirebaseAuthenticator _firebaseAuthenticator;
  final UserRepository _userRepository;

  AuthenticationService(this._authenticationApi, this._firebaseAuthenticator, this._userRepository);

  Future<Result<void>> signIn({
    required String email,
    required String password,
  }) async {
    final result = await _firebaseAuthenticator.signIn(email, password);
    return _saveUser(result);
  }

  Future<Result<void>> signUp({
    required String email,
    required String password,
  }) async {
    final result = await _firebaseAuthenticator.signUp(email, password);
    return await _saveUser(result).flatMapFuture((user) => _authenticationApi.addUser(AddUserRequest(email: user.email, userId: user.id)));
  }

  Future<Result<void>> signInWithGoogle() async {
    final result = await _firebaseAuthenticator.signInWithGoogle();
    return _saveUser(result);
  }

  Future<Result<void>> signUpWithGoogle() async {
    final result = await _firebaseAuthenticator.signUpWithGoogle();
    return await _saveUser(result).flatMapFuture((user) => _authenticationApi.addUser(AddUserRequest(email: user.email, userId: user.id)));
  }

  Result<UserEntity> _saveUser(Result<UserCredential> userCredential) => userCredential
      .map((userCredential) => userCredential.user)
      .map((user) => UserEntity(id: user?.uid ?? '', email: user?.email ?? ''))
      .onSuccess(_userRepository.addOrUpdate);

  Future<Result<String>> getUserId() async {
    final userId = _userRepository.getUserId();

    if (userId == null) {
      final firebaseUser = await _firebaseAuthenticator.getCurrentUser();

      return firebaseUser
          .map((user) => UserEntity(id: user.uid, email: user.email ?? ''))
          .onSuccess(_userRepository.addOrUpdate)
          .map((user) => user.id);
    }

    return Result.success(userId);
  }

  Future<Result<void>> signOut() async {
    final result = await _firebaseAuthenticator.signOut();
    return result.onSuccess((_) => _userRepository.clear());
  }
}
