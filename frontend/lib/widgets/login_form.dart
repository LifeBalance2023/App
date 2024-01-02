import 'package:flutter/material.dart';
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
          height: 35,
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
          child: const Text(
                'Log in',
                style: TextStyle(
                  fontFamily: 'JejuGothic',
                  fontSize: 20.0,
                  color: Color(0xFFF2E9E4),
                ),
              ),
          ),
      ],
    );
  }
}
