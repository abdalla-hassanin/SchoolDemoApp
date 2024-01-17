import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_school_app/core/helpers/app_regex.dart';
import 'package:sahl_school_app/core/widgets/app_text_form_field.dart';
import 'package:sahl_school_app/features/login/ui/widgets/password_validations.dart';
import 'package:sahl_school_app/features/register/logic/register_cubit.dart';

class EmailAndPasswordConfirm extends StatefulWidget {
  const EmailAndPasswordConfirm({super.key});

  @override
  State<EmailAndPasswordConfirm> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPasswordConfirm> {
  bool isObscureTextPassword = true;
  bool isObscureTextPasswordConfirm = true;

  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    passwordController = context.read<RegisterCubit>().passwordController;
    setupPasswordControllerListener();
  }

  void setupPasswordControllerListener() {
    passwordController.addListener(() {
      setState(() {
        hasLowercase = AppRegex.hasLowerCase(passwordController.text);
        hasUppercase = AppRegex.hasUpperCase(passwordController.text);
        hasSpecialCharacters =
            AppRegex.hasSpecialCharacter(passwordController.text);
        hasNumber = AppRegex.hasNumber(passwordController.text);
        hasMinLength = AppRegex.hasMinLength(passwordController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextFormField(
          hintText: 'Email',
          validator: (value) {
            if (value == null ||
                value.isEmpty ||
                !AppRegex.isEmailValid(value)) {
              return 'Please enter a valid email';
            }
          },
          controller: context.read<RegisterCubit>().emailController,
        ),
        SizedBox(height:18),
        AppTextFormField(
          controller: context.read<RegisterCubit>().passwordController,
          hintText: 'Password',
          isObscureText: isObscureTextPassword,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                isObscureTextPassword = !isObscureTextPassword;
              });
            },
            child: Icon(
              isObscureTextPassword ? Icons.visibility_off : Icons.visibility,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a valid password';
            }
          },
        ),
        //TODO: Hide PasswordValidations when passwordController is empty
        if (!(hasLowercase &&
            hasUppercase &&
            hasSpecialCharacters &&
            hasNumber &&
            hasMinLength))
          Column(
            children: [
              SizedBox(height:8),
              PasswordValidations(
                hasLowerCase: hasLowercase,
                hasUpperCase: hasUppercase,
                hasSpecialCharacters: hasSpecialCharacters,
                hasNumber: hasNumber,
                hasMinLength: hasMinLength,
              )
            ],
          ),
        SizedBox(height:18),
        AppTextFormField(
          controller: context.read<RegisterCubit>().passwordConfirmController,
          hintText: 'Password Confirm',
          isObscureText: isObscureTextPasswordConfirm,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                isObscureTextPasswordConfirm = !isObscureTextPasswordConfirm;
              });
            },
            child: Icon(
              isObscureTextPasswordConfirm
                  ? Icons.visibility_off
                  : Icons.visibility,
            ),
          ),
          validator: (value) {
            if (value == null ||
                value.isEmpty
            ||value !=
                context.read<RegisterCubit>().passwordController.text
            ) {
              return 'Please enter a valid password';
            }
          },
        ),
        SizedBox(height:18),
      ],
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }
}
