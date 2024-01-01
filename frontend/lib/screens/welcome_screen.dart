import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                height: MediaQuery.of(context).size.height * 0.65,
                child: Image.asset(
                  'assets/w_page_picture.png',
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF9A8C98),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(55),
                      topRight: Radius.circular(55),
                    ),
                  ),
                  width: double.infinity,
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
                      ElevatedButton(
                        onPressed: () {
                          // Handle login button press
                        },
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size>(
                              const Size(192, 48)),
                          backgroundColor: MaterialStateProperty.all<Color?>(
                              const Color(0xFF4A4E69)),
                          foregroundColor: MaterialStateProperty.all<Color?>(
                              const Color(0xFFF2E9E4)),
                          overlayColor: MaterialStateProperty.all<Color?>(
                              const Color(0xFF62667C)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  15.0), // Set the desired corner radius
                            ),
                          ),
                        ),
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                            fontFamily: 'JejuGothic',
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle login button press
                        },
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size>(
                              const Size(192, 48)),
                          backgroundColor: MaterialStateProperty.all<Color?>(
                              const Color(0xFF4A4E69)),
                          foregroundColor: MaterialStateProperty.all<Color?>(
                              const Color(0xFFF2E9E4)),
                          overlayColor: MaterialStateProperty.all<Color?>(
                              const Color(0xFF62667C)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  15.0), // Set the desired corner radius
                            ),
                          ),
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            fontFamily: 'JejuGothic',
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
