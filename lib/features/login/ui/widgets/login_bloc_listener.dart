import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_school_app/core/helpers/constants.dart';
import 'package:sahl_school_app/core/helpers/extensions.dart';
import 'package:sahl_school_app/core/routing/routes.dart';
import 'package:sahl_school_app/core/theming/color/light_colors.dart';
import 'package:sahl_school_app/features/login/logic/login_cubit.dart';
import 'package:sahl_school_app/features/login/logic/login_state.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          current is LoginLoading ||
          current is LoginSuccess ||
          current is LoginError,
      listener: (context, state) async {
        if (state is LoginLoading) {
          showDialog(
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: LightColors.primaryColor,
              ),
            ),
          );
        } else if (state is LoginSuccess) {
          UserCredential userCredential = state.data;
          DocumentSnapshot<Map<String, dynamic>> userDoc =
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(userCredential.user?.uid)
                  .get();
          userId = userCredential.user?.uid;
          registerAs = userDoc['registerAs'];
          if (userDoc['registerAs'] == 'admin') {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.adminScreen, (context) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.studentHomeScreen, (context) => false);
          }
        } else if (state is LoginError) {
          setupErrorState(context, state.error);
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  void setupErrorState(BuildContext context, String error) {
    context.pop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.error,
          color: Colors.red,
          size: 32,
        ),
        content: Text(
          error,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              'Got it',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ],
      ),
    );
  }
}
