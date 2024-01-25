import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/components/custom_button.dart';
import 'package:frontend/components/custom_progress_indicator.dart';
import 'package:frontend/router/router.dart';
import 'package:frontend/screens/main/bloc/main_screen_bloc.dart';
import 'package:frontend/screens/main/bloc/main_screen_event.dart';
import 'package:frontend/screens/main/bloc/main_screen_state.dart';
import 'package:frontend/screens/main/widgets/task_item.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    final mainScreenBloc = BlocProvider.of<MainScreenBloc>(context);
    mainScreenBloc.add(LoadMainScreen());
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double topHeight = screenHeight * 0.35;
    final mainScreenBloc = BlocProvider.of<MainScreenBloc>(context);

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: topHeight,
              width: double.infinity,
              child: Image.asset(
                'assets/graphics/m_page_picture.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF9A8C98),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: BlocConsumer<MainScreenBloc, MainScreenState>(
                listener: (context, state) {
                  _blocListener(state, context);
                },
                builder: (context, state) {
                  return _blocBuilder(mainScreenBloc, state, context);
                },
              ),
            ),
          ],
        ),
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

void _blocListener(MainScreenState state, BuildContext context) {
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
  MainScreenBloc mainScreenBloc,
  MainScreenState state,
  BuildContext context,
) {
  if (state is ShowProgressIndicator) {
    return const CustomProgressIndicator();
  }
  if (state is ShowMainScreen) {
    return Column(
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Today balance is ',
                style: TextStyle(
                  fontFamily: 'JejuGothic',
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                state.harmonyText,
                style: const TextStyle(fontFamily: 'JejuGothic', fontSize: 15.0, fontWeight: FontWeight.w400, color: Color(0xBF4B4BC4)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: LinearPercentIndicator(
            width: MediaQuery.of(context).size.width - 50,
            animation: true,
            lineHeight: 20.0,
            animationDuration: 1500,
            percent: state.statistics.lifeBalanceValue / 100,
            center: Text("${state.statistics.lifeBalanceValue}%"),
            progressColor: Colors.green,
            barRadius: const Radius.circular(10),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Column(
          children: state.tasks
              .map((task) => TaskItem(
                    taskName: task.title,
                    date: task.date,
                    isDone: task.isDone,
                    onCheckboxClicked: () {
                      mainScreenBloc.add(ClickDoneButton(task));
                    },
                  ))
              .toList(),
        ),
        const SizedBox(
          height: 100,
        )
      ],
    );
  }
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        'Error',
        style: TextStyle(fontSize: 25),
      ),
      const SizedBox(
        height: 15.0,
      ),
      CustomButtonComponent(
        text: 'Reload',
        onPressed: () {
          mainScreenBloc.add(LoadMainScreen());
        },
        width: 328,
        height: 48,
      ),
    ],
  );
}
