import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/screens/auth/login/bloc/login_bloc.dart';
import 'package:frontend/services/authentication/authentication_service.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> createLoginProviders() => [
      BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
          context.read<AuthenticationService>(),
        ),
      ),
    ];
