import 'package:flutter/material.dart';
import 'package:sahl_school_app/core/routing/app_router.dart';
import 'package:sahl_school_app/core/routing/routes.dart';
import 'package:sahl_school_app/core/theming/theme/light_theme.dart';

import 'core/helpers/constants.dart';

class SahlSchoolApp extends StatelessWidget {
  final AppRouter appRouter;

  const SahlSchoolApp({super.key,required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getLightTheme(),
      initialRoute:(userId!=null&&registerAs!=null)?(registerAs=='admin')?Routes.adminScreen:Routes.studentHomeScreen :Routes.loginScreen,
      onGenerateRoute: appRouter.generateRoute,

    );
  }
}
