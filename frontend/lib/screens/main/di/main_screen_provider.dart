import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/screens/main/bloc/main_screen_bloc.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> createMainScreenProviders() => [
      BlocProvider<MainScreenBloc>(
        create: (context) => MainScreenBloc(
          context.read(),
          context.read(),
          context.read(),
        ),
      ),
    ];
