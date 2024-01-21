import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/router/router.dart';
import 'package:frontend/screens/main/bloc/main_screen_bloc.dart';
import 'package:frontend/screens/main/bloc/main_screen_event.dart';
import 'package:frontend/screens/main/bloc/main_screen_state.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mainScreenBloc = BlocProvider.of<MainScreenBloc>(context);

    mainScreenBloc.add(LoadMainScreen());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
      ),
      body: BlocConsumer<MainScreenBloc, MainScreenState>(
        listener: (context, state) {
          if (state is MainScreenError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          }

          if (state is GoToWelcomeScreen) {
            AppRouter.goToWelcomeScreen(context);
          }
        },
        builder: (context, state) {
          if (state is ShowProgressIndicator) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ShowMainScreen) {
            return Center(
              child: Text(
                  'Main Screen ${state.tasks.length} ${state.statistics.amountOfAllTasks}'),
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Error'),
                ElevatedButton(
                  onPressed: () {
                    mainScreenBloc.add(SignOutRequest());
                  },
                  child: const Text('Sign out'),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await AppRouter.goToTaskCreator(context);
          mainScreenBloc.add(GetTasksAndStatistics());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
