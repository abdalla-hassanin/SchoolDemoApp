import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sahl_school_app/core/helpers/extensions.dart';
import 'package:sahl_school_app/core/routing/routes.dart';

class AlreadyHaveAccountText extends StatelessWidget {
  const AlreadyHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Already have an account?',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          TextSpan(
              text: ' Sign In',
              style: Theme.of(context).textTheme.labelMedium,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.pop();
                  context.pushNamed(Routes.loginScreen);
                }),
        ],
      ),
    );
  }
}
