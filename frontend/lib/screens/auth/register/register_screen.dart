import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/components/custom_button.dart';
import 'package:frontend/components/divider_with_text.dart';
import 'package:frontend/components/form_textfield.dart';
import 'package:frontend/router/router.dart';
import 'package:frontend/screens/auth/register/bloc/register_bloc.dart';
import 'package:frontend/screens/auth/register/bloc/register_state.dart';
import 'package:frontend/screens/auth/register/bloc/register_event.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final registerBloc = BlocProvider.of<RegisterBloc>(context);

    final emailTextController = TextEditingController();
    final passwordTextController = TextEditingController();
    final confirmPasswordTextController = TextEditingController();
    final formKey = GlobalKey<FormState>();

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
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
              Future.delayed(const Duration(milliseconds: 200), () {
                AppRouter.goToWelcomeScreen(context);
              });
            } else {
              AppRouter.goToWelcomeScreen(context);
            }
          },
        ),
      ),
      body: Container(
        color: const Color(0xFF9A8C98),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
            child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            _blocListener(state, emailTextController, passwordTextController,
                confirmPasswordTextController, context);
          },
          builder: (context, state) {
            return _blocBuilder(
                registerBloc,
                state,
                emailTextController,
                passwordTextController,
                confirmPasswordTextController,
                formKey,
                context);
          },
        )),
      ),
    );
  }
}

void _blocListener(
  RegisterState state,
  TextEditingController emailTextController,
  TextEditingController passwordTextController,
  TextEditingController confirmPasswordTextController,
  BuildContext context,
) {
  if (state is RegisterSuccess) {
    AppRouter.goToMainScreen(context);
  } else if (state is RegisterFailure) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to sign up: ${state.error.message}')),
    );
  }
}

Widget _blocBuilder(
  RegisterBloc registerBloc,
  RegisterState state,
  TextEditingController emailTextController,
  TextEditingController passwordTextController,
  TextEditingController confirmPasswordTextController,
  GlobalKey<FormState> formKey,
  BuildContext context,
) {
  if (state is RegisterLoading) {
    return const CircularProgressIndicator();
  } else {
    return Form(
      key: formKey,
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
              //TODO
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
              text: 'or register with an email',
              textSize: 24,
            ),
          ),
          const SizedBox(
            height: 45,
          ),
          FormTextfieldComponent(
            fieldName: 'Email',
            hintText: 'Enter your email',
            obscureText: false,
            controller: emailTextController,
            onChanged: (value) {
              registerBloc.add(EmailChanged(email: value));
            },
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
            controller: passwordTextController,
            onChanged: (value) {
              registerBloc.add(PasswordChanged(password: value));
            },
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
            controller: confirmPasswordTextController,
            onChanged: (value) {
              registerBloc.add(ConfirmPasswordChanged(confirmPassword: value));
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Field can\'t be empty';
              }

              if (value != passwordTextController.text) {
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
              if (!formKey.currentState!.validate()) {
                return;
              }

              registerBloc.add(RegisterWithCredentialsRequest());
            },
          ),
          const SizedBox(
            height: 45,
          ),
        ],
      ),
    );
  }
}
