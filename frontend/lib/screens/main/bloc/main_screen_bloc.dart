import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/screens/main/bloc/main_screen_event.dart';
import 'package:frontend/screens/main/bloc/main_screen_state.dart';
import 'package:frontend/services/authentication/authentication_service.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final AuthenticationService _authenticationService;

  MainScreenBloc(this._authenticationService) : super(ShowProgressIndicator()) {
    on<CheckIfUserIsLoggedIn>(_onCheckIfUserIsLoggedIn);
  }

  Future<void> _onCheckIfUserIsLoggedIn(CheckIfUserIsLoggedIn event, Emitter<MainScreenState> emit) async {
    final userIdResult = await _authenticationService.getUserId();

    userIdResult.onFailure((error) {
      emit(ShowWelcomeMessage());
    }).onSuccess((userId) {
      emit(GoToMainScreen());
    });
  }
}
