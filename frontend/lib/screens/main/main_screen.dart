import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/screens/main/bloc/main_screen_bloc.dart';
import 'package:frontend/screens/main/bloc/main_screen_state.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
      ),
      body: BlocConsumer<MainScreenBloc, MainScreenState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return Container();
        },
      ),
    );
  }
}
