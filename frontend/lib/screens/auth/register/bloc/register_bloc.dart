import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/screens/auth/register/bloc/register_event.dart';
import 'package:frontend/screens/auth/register/bloc/register_state.dart';
import 'package:frontend/services/authentication/authentication_service.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationService _authenticationService;

  RegisterBloc(this._authenticationService) : super(RegisterInitial()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<RegisterWithCredentialsRequest>(_onCredentialsRegister);
    on<RegisterWithGoogleRequest>(_onGoogleRegister);
  }

  void _onEmailChanged(EmailChanged event, Emitter<RegisterState> emit) {
    emit(
      RegisterEdited(
          email: event.email,
          password: state.password,
          confirmPassword: state.confirmPassword),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<RegisterState> emit) {
    emit(
      RegisterEdited(
          email: state.email,
          password: event.password,
          confirmPassword: state.confirmPassword),
    );
  }

  void _onConfirmPasswordChanged(
      ConfirmPasswordChanged event, Emitter<RegisterState> emit) {
    emit(
      RegisterEdited(
          email: state.email,
          password: state.password,
          confirmPassword: event.confirmPassword),
    );
  }

  Future<void> _onCredentialsRegister(
      RegisterWithCredentialsRequest event, Emitter<RegisterState> emit) async {
    emit(
      RegisterLoading(
          email: state.email,
          password: state.password,
          confirmPassword: state.confirmPassword),
    );
    final result = await _authenticationService.signUp(
      email: state.email,
      password: state.password,
    );

    result
        .onFailure(
          (error) => emit(
            RegisterFailure(
              email: state.email,
              password: state.password,
              confirmPassword: state.confirmPassword,
              error: error,
            ),
          ),
        )
        .onSuccess(
          (_) => emit(
            RegisterSuccess(
              email: state.email,
              password: state.password,
              confirmPassword: state.confirmPassword,
            ),
          ),
        );
  }

  Future<void> _onGoogleRegister(
      RegisterWithGoogleRequest event, Emitter<RegisterState> emit) async {
    emit(
      RegisterLoading(
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
      ),
    );
    final result = await _authenticationService.signInWithGoogle();

    result
        .onFailure(
          (error) => emit(
            RegisterFailure(
              email: state.email,
              password: state.password,
              confirmPassword: state.confirmPassword,
              error: error,
            ),
          ),
        )
        .onSuccess(
          (_) => emit(
            RegisterSuccess(
              email: state.email,
              password: state.password,
              confirmPassword: state.confirmPassword,
            ),
          ),
        );
  }
}
