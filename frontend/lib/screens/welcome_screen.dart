import 'package:flutter/material.dart';
import 'package:frontend/components/custom_button.dart';
import 'package:frontend/screens/register_screen.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double topContainerHeight = screenHeight * 0.65;
    double bottomContainerHeight = screenHeight - topContainerHeight;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade200,
                Colors.blue.shade300,
                Colors.blue.shade400,
              ],
              begin: Alignment.topCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(25),
                height: topContainerHeight,
                child: Image.asset(
                  'assets/graphics/w_page_picture.png',
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF9A8C98),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(55),
                    topRight: Radius.circular(55),
                  ),
                ),
                width: double.infinity,
                height: bottomContainerHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Let’s start to change your balance!',
                        style: TextStyle(
                          fontFamily: 'JejuGothic',
                          fontSize: 24.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    CustomButtonComponent(
                        text: 'Log in',
                        width: 192,
                        height: 48,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 25.0,
                    ),
                    CustomButtonComponent(
                        text: 'Register',
                        width: 192,
                        height: 48,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
