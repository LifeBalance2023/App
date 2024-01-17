import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithGooglePressed) {
      yield LoginLoading();
      try {
        // Perform login with Google
        yield LoginSuccess();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    } else if (event is LoginWithCredentialsPressed) {
      yield LoginLoading();
      try {
        // Perform login with credentials
        yield LoginSuccess();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}