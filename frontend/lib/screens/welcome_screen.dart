import 'package:flutter/material.dart';
import 'package:frontend/components/custom_button.dart';
import 'package:frontend/router/router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenHeight = constraints.maxHeight;
        double screenWidth = constraints.maxWidth;
        double topHeight = screenHeight * 0.6;
        double bottomHeight = screenHeight - topHeight;

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
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.15,
                        vertical: bottomHeight * 0.08),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Let’s start to change your balance!',
                          style: TextStyle(
                            fontFamily: 'JejuGothic',
                            fontSize: 24.0,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: bottomHeight * 0.1,
                        ),
                        CustomButtonComponent(
                          text: 'Log in',
                          width: screenWidth * 0.5,
                          height: bottomHeight * 0.15,
                          onPressed: () {
                            AppRouter.goToLogin(context);
                          },
                        ),
                        SizedBox(
                          height: bottomHeight * 0.05,
                        ),
                        CustomButtonComponent(
                          text: 'Register',
                          width: screenWidth * 0.5,
                          height: bottomHeight * 0.15,
                          onPressed: () {
                            AppRouter.goToRegister(context);
                          },
                        ),
                        SizedBox(
                          height: bottomHeight * 0.1,
                        ),
                        GestureDetector(
                          onTap: () {
                            AppRouter.goToSettings(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.settings,
                                color: Colors.grey[800],
                              ),
                              SizedBox(
                                width: screenWidth * 0.01,
                              ),
                              Text(
                                'Settings',
                                style: TextStyle(
                                  fontFamily: 'JejuGothic',
                                  fontSize: 18.0,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
