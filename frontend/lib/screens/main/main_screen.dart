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
        title: const Text(
          'Main screen',
          style: TextStyle(
            fontFamily: 'JejuGothic',
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFF9A8C98),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('@user_id'),
                  ],
                )),
            ListTile(
              title: const Text('Settings'),
              trailing: const Icon(Icons.settings_sharp),
              onTap: () {
                Navigator.pop(context);
                AppRouter.goToSettings(context);
              },
            ),
            ListTile(
              title: const Text('Sign out'),
              trailing: const Icon(Icons.power_settings_new_sharp),
              onTap: () {
                Navigator.pop(context);
                mainScreenBloc.add(SignOutRequest());
              },
            )
          ],
        ),
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
          return const Center(
            child: Text('Error'),
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
