import 'package:flutter/material.dart';
import 'package:frontend/components/custom_button.dart';
import 'package:frontend/router/router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double topHeight = screenHeight * 0.65;

    return Scaffold(
      body: Stack(
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
                  const SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      AppRouter.goToSettings(context);
                    },
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        fontFamily: 'JejuGothic',
                        fontSize: 18.0,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
