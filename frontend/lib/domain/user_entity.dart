import 'package:frontend/domain/identifiable.dart';

class UserEntity implements Identifiable {
  @override
  String id;
  String name;

  UserEntity({required this.id, required this.name});
}
