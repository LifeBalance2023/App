import 'package:frontend/domain/result.dart';

abstract class LoginState {
  final String email;
  final String password;

  LoginState({required this.email, required this.password});
}

class LoginInitial extends LoginState {
  LoginInitial() : super(email: '', password: '');
}

class LoginEdited extends LoginState {
  LoginEdited({email, password}) : super(email: email, password: password);
}

class LoginLoading extends LoginState {
  LoginLoading({email, password}) : super(email: email, password: password);
}

class ForgotPasswordSuccess extends LoginState {
  final String resetEmail;
  ForgotPasswordSuccess({email, password, required this.resetEmail}) : super(email: email, password: password);
}

class LoginSuccess extends LoginState {
  LoginSuccess({email, password}) : super(email: email, password: password);
}

class LoginFailure extends LoginState {
  final ResultError error;

  LoginFailure({email, password, required this.error})
      : super(email: email, password: password);
}
