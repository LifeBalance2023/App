import 'package:flutter/material.dart';
import 'package:frontend/components/custom_button.dart';
import 'package:frontend/components/form_textfield.dart';

class RegisterFormWidget extends StatelessWidget {
  RegisterFormWidget({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FormTextfieldComponent(
            fieldName: 'Email',
            hintText: 'Enter your email',
            obscureText: false,
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Field can\'t be empty';
              }

              final emailRegex =
                  RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
              if (!emailRegex.hasMatch(value)) {
                return 'Please provide an email in valid form';
              }

              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          FormTextfieldComponent(
            fieldName: 'Password',
            hintText: 'Enter your password',
            obscureText: true,
            controller: _passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Field can\'t be empty';
              } else if (value.length < 6) {
                return 'Min. 6 characters';
              }

              final passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*\d)');
              if (!passwordRegex.hasMatch(value)) {
                return 'Password needs capital letters and digits';
              }

              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          FormTextfieldComponent(
            hintText: 'Confirm your password',
            obscureText: true,
            controller: _confirmPasswordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Field can\'t be empty';
              }

              if (value != _passwordController.text) {
                return 'Passwords don\'t match';
              }

              return null;
            },
          ),
          const SizedBox(
            height: 35,
          ),
          CustomButtonComponent(
              text: 'Register now',
              width: 328,
              height: 48,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // If all fields passed validation make some action
                }
              })
        ],
      ),
    );
  }
}
