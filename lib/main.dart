import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_school_app/core/helpers/bloc_observer.dart';
import 'package:sahl_school_app/core/routing/app_router.dart';
import 'package:sahl_school_app/firebase_options.dart';
import 'package:sahl_school_app/sahl_school_app.dart';

import 'core/di/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupGetIt();
  Bloc.observer = MyBlocObserver();

  runApp(SahlSchoolApp(appRouter:AppRouter(),));
}

