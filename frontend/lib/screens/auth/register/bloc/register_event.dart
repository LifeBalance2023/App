abstract class RegisterEvent {}

class EmailChanged extends RegisterEvent {
  final String email;

  EmailChanged({required this.email});
}

class PasswordChanged extends RegisterEvent {
  final String password;

  PasswordChanged({required this.password});
}

class ConfirmPasswordChanged extends RegisterEvent {
  final String confirmPassword;

  ConfirmPasswordChanged({required this.confirmPassword});
}

class RegisterWithCredentialsRequest extends RegisterEvent {}

class RegisterWithGoogleRequest extends RegisterEvent {}
