import 'package:flutter/material.dart';

import '../widgets/divider_with_text.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF9A8C98),
        title: const Text(
          'Register',
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 45,
            ),
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
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/google_icon.png',
                    width: 30,
                    height: 30,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    'Register with Google',
                    style: TextStyle(
                      fontFamily: 'JejuGothic',
                      fontSize: 20.0,
                      color: Color(0xFFF2E9E4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 45,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: const DividerWithTextWidget(
                text: 'or register with an email',
                textSize: 24,
              ),
            ),
            const SizedBox(
              height: 45,
            ),
          ],
        ),
      ),
    );
  }
}
