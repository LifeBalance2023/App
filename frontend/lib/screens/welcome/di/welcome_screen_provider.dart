import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/screens/welcome/bloc/welcome_screen_bloc.dart';
import 'package:frontend/services/authentication/authentication_service.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> createWelcomeScreenProviders() => [
      BlocProvider<WelcomeScreenBloc>(
        create: (context) => WelcomeScreenBloc(
          context.read<AuthenticationService>(),
        ),
      ),
    ];
