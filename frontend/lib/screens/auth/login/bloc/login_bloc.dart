import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/screens/auth/login/bloc/login_event.dart';
import 'package:frontend/screens/auth/login/bloc/login_state.dart';

import '../../../../services/authentication/authentication_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationService _authenticationService;

  LoginBloc(this._authenticationService) : super(LoginInitial()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginWithCredentialsRequest>(_onCredentialsLogin);
    on<LoginWithGoogleRequest>(_onGoogleLogin);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(LoginEdited(email: event.email, password: state.password));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(LoginEdited(email: state.email, password: event.password));
  }

  Future<void> _onCredentialsLogin(
      LoginWithCredentialsRequest event, Emitter<LoginState> emit) async {
    emit(LoginLoading(email: state.email, password: state.password));
    final result = await _authenticationService.signIn(
        email: state.email, password: state.password);

    result
        .onFailure((error) => emit(LoginFailure(
            email: state.email, password: state.password, error: error)))
        .onSuccess((_) =>
            emit(LoginSuccess(email: state.email, password: state.password)));
  }

  Future<void> _onGoogleLogin(
      LoginWithGoogleRequest event, Emitter<LoginState> emit) async {
    emit(LoginLoading(email: state.email, password: state.password));
    final result = await _authenticationService.signInWithGoogle();

    result
        .onFailure((error) => emit(LoginFailure(
            email: state.email, password: state.password, error: error)))
        .onSuccess((_) =>
            emit(LoginSuccess(email: state.email, password: state.password)));
  }
}
