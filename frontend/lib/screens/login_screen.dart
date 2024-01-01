import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF9A8C98),
        title: const Text(
          'Log in',
          style: TextStyle(
            fontFamily: 'JejuGothic',
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: const Color(0xFF9A8C98),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(const Size(328, 48)),
                backgroundColor:
                    MaterialStateProperty.all<Color?>(const Color(0xFF4A4E69)),
                foregroundColor:
                    MaterialStateProperty.all<Color?>(const Color(0xFFF2E9E4)),
                overlayColor:
                    MaterialStateProperty.all<Color?>(const Color(0xFF62667C)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        15.0), // Set the desired corner radius
                  ),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.login_outlined,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Log in with Google',
                    style: TextStyle(
                      fontFamily: 'JejuGothic',
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
