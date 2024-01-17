import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_school_app/core/di/dependency_injection.dart';
import 'package:sahl_school_app/core/widgets/app_text_button.dart';
import 'package:sahl_school_app/features/register/data/models/register_request_body.dart';
import 'package:sahl_school_app/features/register/logic/register_cubit.dart';
import 'package:sahl_school_app/features/register/logic/register_state.dart';
import 'package:sahl_school_app/features/register/ui/widgets/already_have_account_text.dart';
import 'package:sahl_school_app/features/register/ui/widgets/email_and_password_confirm.dart';
import 'package:sahl_school_app/features/register/ui/widgets/first_and_last_name.dart';
import 'package:sahl_school_app/features/register/ui/widgets/register_as_teacher_or_student.dart';
import 'package:sahl_school_app/features/register/ui/widgets/register_bloc_listener.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => getIt<RegisterCubit>(),
  child: BlocConsumer<RegisterCubit, RegisterState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Create Account',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 24),
            ),
            SizedBox(height: 36),
            Column(
              children: [
                Form(
                    key: context.read<RegisterCubit>().formKey,
                    child: Column(children: [
                      FirstAndLastName(),
                      EmailAndPasswordConfirm(),
                      RegisterAsTeacherOrStudent(),
                    ])),
                AppTextButton(
                  buttonText: 'Create Account',
                  textStyle: Theme.of(context).textTheme.titleMedium!,
                  onPressed: () {
                    validateThenDoRegister(context);
                  },
                ),
                SizedBox(height: 16),
                const AlreadyHaveAccountText(),
                const RegisterBlocListener(),
              ],
            ),
          ],
        ),
      ),
    )));
  },
),
);
  }

  void validateThenDoRegister(BuildContext context) {
    if (context.read<RegisterCubit>().formKey.currentState!.validate() &&
        context.read<RegisterCubit>().registerAsSelection.contains(true)) {
      context.read<RegisterCubit>().emitRegisterStates(RegisterRequestBody(
          firstName: context.read<RegisterCubit>().firstNameController.text,
          lastName: context.read<RegisterCubit>().lastNameController.text,
          email: context.read<RegisterCubit>().emailController.text,
          password: context.read<RegisterCubit>().passwordController.text,
          registerAs: context.read<RegisterCubit>().registerAsValue));
    }
  }
}
