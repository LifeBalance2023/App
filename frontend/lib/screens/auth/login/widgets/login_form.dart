import 'package:flutter/material.dart';
import 'package:frontend/components/custom_button.dart';
import 'package:frontend/components/form_textfield.dart';

class LoginFormWidget extends StatelessWidget {
  LoginFormWidget({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                return 'Please enter your email';
              }

              final emailRegex =
                  RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
              if (!emailRegex.hasMatch(value)) {
                return 'Please enter a valid email';
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
                return 'Please enter your password';
              }

              return null;
            },
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
                GestureDetector(
                  // onTap: () {
                  //   showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       return AlertDialog(
                  //         title: Text('Forgot Password'),
                  //         content: Text('Reset password functionality goes here'),
                  //         actions: <Widget>[
                  //           TextButton(
                  //             child: Text('Close'),
                  //             onPressed: () {
                  //               Navigator.of(context).pop();
                  //             },
                  //           ),
                  //         ],
                  //       );
                  //     },
                  //   );
                  // },
                  onTap: () => _showForgotPasswordDialog(context),
                  child: Text(
                    'Forgot password?',
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
          const SizedBox(
            height: 35,
          ),
          CustomButtonComponent(
              text: 'Log in',
              width: 328,
              height: 48,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // If all fields passed validation make some action
                }
              }),
        ],
      ),
    );
  }

  void _showForgotPasswordDialog(BuildContext context) {
    final dialogFormKey = GlobalKey<FormState>();
    final emailResetController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Form(
              key: dialogFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Forgot password?',
                    style: TextStyle(
                      fontFamily: 'JejuGothic',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Enter your email and we will send you link to reset password.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'JejuGothic',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emailResetController,
                    decoration: const InputDecoration(
                      hintText: 'Enter email',
                      hintStyle: TextStyle(
                        color: Color(0xFFF2E9E4),
                        fontFamily: 'JejuGothic',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                      filled: true,
                      fillColor: Color(0xFF4A4E69),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF4A4E69),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF4A4E69),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF4A4E69),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF4A4E69),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 10.0,
                      ),
                      errorStyle: TextStyle(
                        fontFamily: 'JejuGothic',
                        fontSize: 14.0,
                        color: Color(0xFF6E1010),
                      ),
                    ),
                    style: const TextStyle(
                      color: Color(0xFFF2E9E4),
                      fontFamily: 'JejuGothic',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      final emailRegex =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomButtonComponent(
                    text: 'Send',
                    width: 150,
                    height: 48,
                    onPressed: () {
                      if (dialogFormKey.currentState!.validate()) {
                        // If all fields passed validation make some action
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
