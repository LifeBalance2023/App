import 'package:frontend/api/authentication/authentication_api.dart';
import 'package:frontend/api/authentication/requests/add_user_request.dart';
import 'package:frontend/domain/result.dart';

class AuthenticationService {
  final AuthenticationApi _authenticationApi;

  AuthenticationService(this._authenticationApi);

  Future<Result<void>> addUser({
    required String email,
    required String userId,
  }) => _authenticationApi.addUser(AddUserRequest(email: email, userId: userId));
}
