import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/components/custom_button.dart';
import 'package:frontend/components/divider_with_text.dart';
import 'package:frontend/screens/auth/login/bloc/login_bloc.dart';
import 'package:frontend/screens/auth/login/bloc/login_state.dart';
import 'package:frontend/screens/auth/login/widgets/login_form.dart';

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
            fontWeight: FontWeight.w400,
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
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
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
                    text: 'Log in with Google',
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
                    child: const DividerWithTextComponent(
                      text: 'or log in with an email',
                      textSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  LoginFormWidget(),
                  const SizedBox(
                    height: 45,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
