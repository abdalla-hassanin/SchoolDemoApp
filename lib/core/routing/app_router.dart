import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_school_app/core/di/dependency_injection.dart';
import 'package:sahl_school_app/core/routing/routes.dart';
import 'package:sahl_school_app/features/admin/admin_home/ui/create_exam_screen.dart';
import 'package:sahl_school_app/features/admin/admin_home/ui/admin_screen.dart';
import 'package:sahl_school_app/features/login/logic/login_cubit.dart';
import 'package:sahl_school_app/features/login/ui/login_screen.dart';
import 'package:sahl_school_app/features/register/logic/register_cubit.dart';
import 'package:sahl_school_app/features/register/ui/registerScreen.dart';
import 'package:sahl_school_app/features/student/student_home/ui/home_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case Routes.registerScreen:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      case Routes.studentHomeScreen:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case Routes.adminScreen:
        return MaterialPageRoute(
          builder: (_) => AdminScreen(),
        );
      case Routes.createExamScreen:
        return MaterialPageRoute(
          builder: (_) => CreateExamScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
