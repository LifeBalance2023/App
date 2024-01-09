import 'package:flutter/material.dart';
import 'package:frontend/components/custom_button.dart';
import 'package:frontend/components/form_textfield.dart';

class RegisterFormWidget extends StatelessWidget {
  RegisterFormWidget({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
        FormTextfieldComponent(
          controller: confirmPasswordController,
          hintText: 'Confirm your password',
          obscureText: true,
        ),
        const SizedBox(
          height: 35,
        ),
        CustomButtonComponent(
            text: 'Register now', width: 328, height: 48, onPressed: () {})
      ],
    );
  }
}
