import 'package:frontend/domain/result.dart';

abstract class RegisterState {
  final String email;
  final String password;
  final String confirmPassword;

  RegisterState({required this.email, required this.password, required this.confirmPassword});
}

class RegisterInitial extends RegisterState {
  RegisterInitial() : super(email: '', password: '', confirmPassword: '');
}

class RegisterEdited extends RegisterState {
  RegisterEdited({email, password, confirmPassword}) : super(email: email, password: password, confirmPassword: confirmPassword);
}

class RegisterLoading extends RegisterState {
  RegisterLoading({email, password, confirmPassword}) : super(email: email, password: password, confirmPassword: confirmPassword);
}

class RegisterSuccess extends RegisterState {
  RegisterSuccess({email, password, confirmPassword}) : super(email: email, password: password, confirmPassword: confirmPassword);
}

class RegisterFailure extends RegisterState {
  final ResultError error;

  RegisterFailure({email, password, confirmPassword, required this.error})
      : super(email: email, password: password, confirmPassword: confirmPassword);
}