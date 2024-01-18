import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/screens/welcome/bloc/welcome_screen_event.dart';
import 'package:frontend/screens/welcome/bloc/welcome_screen_state.dart';
import 'package:frontend/services/authentication/authentication_service.dart';

class WelcomeScreenBloc extends Bloc<WelcomeScreenEvent, WelcomeScreenState> {
  final AuthenticationService _authenticationService;

  WelcomeScreenBloc(this._authenticationService) : super(ShowProgressIndicator()) {
    on<CheckIfUserIsLoggedIn>(_onCheckIfUserIsLoggedIn);
  }

  Future<void> _onCheckIfUserIsLoggedIn(CheckIfUserIsLoggedIn event, Emitter<WelcomeScreenState> emit) async {
    final userIdResult = await _authenticationService.getUserId();

    userIdResult.onFailure((error) {
      print(error);
      emit(ShowWelcomeMessage());
    }).onSuccess((userId) {
      print(userId);
      emit(GoToMainScreen());
    });
  }
}
