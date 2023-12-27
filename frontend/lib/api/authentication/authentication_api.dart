import 'package:frontend/api/authentication/requests/add_user_request.dart';

import '../../domain/result.dart';
import '../dio_wrapper.dart';

class AuthenticationApi {
  final DioWrapper _dioWrapper;
  final String _baseUrl = '/users';

  AuthenticationApi(DioWrapper dioWrapper) : _dioWrapper = dioWrapper;

  Future<Result<void>> addUser(AddUserRequest request) => _dioWrapper.post(_baseUrl, data: request.toJson());
}
