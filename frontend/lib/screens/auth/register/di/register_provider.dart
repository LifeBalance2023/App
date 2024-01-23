import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/screens/auth/register/bloc/register_bloc.dart';
import 'package:frontend/services/authentication/authentication_service.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> createRegisterProviders() => [
      BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(
          context.read<AuthenticationService>(),
        ),
      ),
    ];
