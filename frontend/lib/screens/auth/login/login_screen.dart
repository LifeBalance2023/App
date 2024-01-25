import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/components/custom_button.dart';
import 'package:frontend/components/custom_progress_indicator.dart';
import 'package:frontend/components/divider_with_text.dart';
import 'package:frontend/components/form_textfield.dart';
import 'package:frontend/router/router.dart';
import 'package:frontend/screens/auth/login/bloc/login_bloc.dart';
import 'package:frontend/screens/auth/login/bloc/login_event.dart';
import 'package:frontend/screens/auth/login/bloc/login_state.dart';
import 'package:frontend/utils/email_validator.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    EmailValidator emailValidator = EmailValidator();
    final loginBloc = BlocProvider.of<LoginBloc>(context);

    final emailTextController = TextEditingController();
    final passwordTextController = TextEditingController();
    final formKey = GlobalKey<FormState>();

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
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              _blocListener(state, emailTextController, passwordTextController, context);
            },
            builder: (context, state) {
              return _blocBuilder(loginBloc, state, emailTextController, emailValidator, passwordTextController, formKey, context);
            },
          ),
        ),
      ),
    );
  }
}

void _blocListener(
  LoginState state,
  TextEditingController emailTextController,
  TextEditingController passwordTextController,
  BuildContext context,
) {
  if (state is LoginSuccess) {
    AppRouter.goToMainScreen(context);
  } else if (state is LoginFailure) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to log in: ${state.error.message}')),
    );
  } else if (state is ForgotPasswordSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Password reset email sent to ${state.resetEmail}')),
    );
  }
}

Widget _blocBuilder(
  LoginBloc loginBloc,
  LoginState state,
  TextEditingController emailTextController,
  EmailValidator emailValidator,
  TextEditingController passwordTextController,
  GlobalKey<FormState> formKey,
  BuildContext context,
) {
  if (state is LoginLoading) {
    return const CustomProgressIndicator();
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
            text: 'Log in with Google',
            width: 328,
            height: 48,
            iconPath: 'assets/icons/google_icon.png',
            onPressed: () {
              loginBloc.add(LoginWithGoogleRequest());
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
              maxTextSize: 22,
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
              loginBloc.add(EmailChanged(email: value));
            },
            validator: (value) {
              return emailValidator.validate(value);
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
              loginBloc.add(PasswordChanged(password: value));
            },
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
              if (!formKey.currentState!.validate()) {
                return;
              }

              loginBloc.add(LoginWithCredentialsRequest());
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

void _showForgotPasswordDialog(BuildContext context) {
  final dialogFormKey = GlobalKey<FormState>();
  EmailValidator emailValidator = EmailValidator();
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
                    return emailValidator.validate(value);
                  },
                ),
                const SizedBox(height: 20),
                CustomButtonComponent(
                  text: 'Send',
                  width: 150,
                  height: 48,
                  onPressed: () {
                    if (dialogFormKey.currentState!.validate()) {
                      context.read<LoginBloc>().add(ForgotPasswordRequest(email: emailResetController.text));
                      Navigator.pop(context);
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
