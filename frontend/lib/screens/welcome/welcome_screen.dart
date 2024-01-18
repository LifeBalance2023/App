import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/components/custom_button.dart';
import 'package:frontend/router/router.dart';
import 'package:frontend/screens/welcome/bloc/welcome_screen_bloc.dart';
import 'package:frontend/screens/welcome/bloc/welcome_screen_event.dart';
import 'package:frontend/screens/welcome/bloc/welcome_screen_state.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double topHeight = screenHeight * 0.65;

    final welcomeScreenBloc = BlocProvider.of<WelcomeScreenBloc>(context);
    welcomeScreenBloc.add(CheckIfUserIsLoggedIn());

    return Scaffold(
      body: BlocConsumer<WelcomeScreenBloc, WelcomeScreenState>(
        listener: (context, state) {
          if (state is GoToMainScreen) {
            AppRouter.goToMainScreen(context);
          }
        },
        builder: (context, state) {
          if(state is ShowProgressIndicator) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: topHeight,
                child: Image.asset(
                  'assets/graphics/w_page_picture.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: topHeight - 25,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF9A8C98),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(55),
                      topRight: Radius.circular(55),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 40.0,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 70),
                        child: Text(
                          'Let’s start to change your balance!',
                          style: TextStyle(
                            fontFamily: 'JejuGothic',
                            fontSize: 24.0,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      CustomButtonComponent(
                        text: 'Log in',
                        width: 192,
                        height: 48,
                        onPressed: () {
                          AppRouter.goToLogin(context);
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      CustomButtonComponent(
                        text: 'Register',
                        width: 192,
                        height: 48,
                        onPressed: () {
                          AppRouter.goToRegister(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
