import 'package:flutter/material.dart';
import 'package:frontend/components/custom_button.dart';
import 'package:frontend/components/form_textfield.dart';

class LoginFormWidget extends StatelessWidget {
  LoginFormWidget({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormTextfieldComponent(
          controller: emailController,
          fieldName: 'Email',
          hintText: 'Enter your email',
          obscureText: false,
        ),
        const SizedBox(
          height: 20,
        ),
        FormTextfieldComponent(
          controller: passwordController,
          fieldName: 'Password',
          hintText: 'Enter your password',
          obscureText: true,
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 35.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Forgot password?',
                style: TextStyle(
                  fontFamily: 'JejuGothic',
                  fontSize: 18.0,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 35,
        ),
        CustomButtonComponent(text: 'Log in', width: 328, height: 48, onPressed: () {})
      ],
    );
  }
}
