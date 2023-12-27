import 'package:frontend/domain/user_entity.dart';
import 'package:frontend/repository/single_value_repository.dart';

class UserRepository extends SingleValueRepository<UserEntity> {
  String? getUserId() => get()?.id;
}
