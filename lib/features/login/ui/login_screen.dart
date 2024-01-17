import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_school_app/core/di/dependency_injection.dart';
import 'package:sahl_school_app/core/widgets/app_text_button.dart';
import 'package:sahl_school_app/features/login/logic/login_state.dart';
import 'package:sahl_school_app/features/login/ui/widgets/do_not_have_account_text.dart';
import 'package:sahl_school_app/features/login/ui/widgets/email_and_password.dart';
import 'package:sahl_school_app/features/login/ui/widgets/login_bloc_listener.dart';

import '../data/models/login_request_body.dart';
import '../logic/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 36),
                  Image.asset(
                    'assets/images/logo.png',
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 36),
                  const EmailAndPassword(),
                  SizedBox(height: 16),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text(
                      'Forgot Password?',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  SizedBox(height: 16),
                  AppTextButton(
                    buttonText: 'Login',
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    onPressed: () {
                      validateThenDoLogin(context);
                    },
                  ),
                  SizedBox(height: 16),
                  const DoNotHaveAccountText(),
                  LoginBlocListener()
                ],
              ),
            ),
          ),
        ),
      );
  },
),
    );
  }

  void validateThenDoLogin(BuildContext context) {
    if (context.read<LoginCubit>().formKey.currentState!.validate()) {
      context.read<LoginCubit>().emitLoginStates(
            LoginRequestBody(
              email: context.read<LoginCubit>().emailController.text,
              password: context.read<LoginCubit>().passwordController.text,
            ),
          );
    }
  }
}
