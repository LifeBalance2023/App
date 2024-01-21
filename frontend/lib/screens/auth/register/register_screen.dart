import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/components/custom_button.dart';
import 'package:frontend/components/divider_with_text.dart';
import 'package:frontend/router/router.dart';
import 'package:frontend/screens/auth/register/bloc/register_bloc.dart';
import 'package:frontend/screens/auth/register/bloc/register_state.dart';

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
          ),
        ),
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
  if (state is RegisterEdited) {
    emailTextController.text = state.email;
    passwordTextController.text = state.password;
    confirmPasswordTextController.text = state.confirmPassword;
  }
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
          //TODO add register fields
          const SizedBox(
            height: 45,
          ),
        ],
      ),
    );
  }
}
