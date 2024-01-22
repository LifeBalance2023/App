import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:frontend/router/router.dart';
import 'package:frontend/screens/main/bloc/main_screen_bloc.dart';
import 'package:frontend/screens/main/bloc/main_screen_event.dart';
import 'package:frontend/screens/main/bloc/main_screen_state.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double topHeight = screenHeight * 0.35;
    final mainScreenBloc = BlocProvider.of<MainScreenBloc>(context);

    mainScreenBloc.add(LoadMainScreen());

    final List<String> sampleList = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
      'Item 6',
      'Item 7',
      'Item 8',
      'Item 9',
      'Item 10',
    ];

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
      // body: BlocConsumer<MainScreenBloc, MainScreenState>(
      //   listener: (context, state) {
      //     _blocListener(state, context);
      //   },
      //   builder: (context, state) {
      //     return _blocBuilder(state, context);
      //   },
      // ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: topHeight,
            child: Image.asset(
              'assets/graphics/m_page_picture.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: topHeight - 45,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF9A8C98),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Your level of balance looks great!',
                      style: TextStyle(
                        fontFamily: 'JejuGothic',
                        fontSize: 24.0,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Today balance is ',
                          style: TextStyle(
                            fontFamily: 'JejuGothic',
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'complete harmony',
                          style: TextStyle(
                              fontFamily: 'JejuGothic',
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xBF4B4BC4)),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: RoundedProgressBar(
                      childCenter: const Text("85%",
                          style: TextStyle(color: Colors.white)),
                      style: RoundedProgressBarStyle(
                          colorProgress: const Color(0xBF4B4BC4),
                          borderWidth: 0,
                          widthShadow: 0),
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      borderRadius: BorderRadius.circular(24),
                      percent: 85,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color(0xFF91778F),
                      ),
                      width: double.infinity,
                      height: 180,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: ListView.builder(
                        itemCount: sampleList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(sampleList[index]),
                            // You can add other properties to customize each tile
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () async {
              await AppRouter.goToTaskCreator(context);
              mainScreenBloc.add(GetTasksAndStatistics());
            },
            shape: const CircleBorder(),
            backgroundColor: const Color(0xFF81767F),
            foregroundColor: Colors.black,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 15,
                ),
                Text('Task'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _blocListener(
  MainScreenState state,
  BuildContext context,
) {
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
}

Widget _blocBuilder(
  MainScreenState state,
  BuildContext context,
) {
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
}
