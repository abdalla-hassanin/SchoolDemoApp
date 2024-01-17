import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sahl_school_app/core/helpers/extensions.dart';
import 'package:sahl_school_app/core/routing/routes.dart';

class DoNotHaveAccountText extends StatelessWidget {
  const DoNotHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Don\'t have an account?',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          TextSpan(
              text: ' Sign Up',
              style: Theme.of(context).textTheme.labelMedium,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.pushNamed(Routes.registerScreen);
                }),
        ],
      ),
    );
  }
}
