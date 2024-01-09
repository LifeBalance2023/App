import 'package:flutter/material.dart';
import 'package:frontend/widgets/register_form.dart';

import '../components/custom_button.dart';
import '../widgets/divider_with_text.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
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
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
                Future.delayed(const Duration(milliseconds: 200), () {
                  Navigator.pop(context);
                });
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ),
        body: Container(
          color: const Color(0xFF9A8C98),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 45,
                ),
                CustomButtonComponent(
                  text: 'Register with Google',
                  width: 328,
                  height: 48,
                  iconPath: 'assets/icons/google_icon.png',
                  onPressed: () {
                    // Handle button press
                  },
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
                RegisterFormWidget(),
                const SizedBox(
                  height: 45,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
