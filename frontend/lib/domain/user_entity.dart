import 'package:frontend/domain/identifiable.dart';

class UserEntity implements Identifiable {
  @override
  String id;
  String email;

  UserEntity({required this.id, required this.email});
}
