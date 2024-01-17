import 'package:get_it/get_it.dart';
import 'package:sahl_school_app/features/admin/admin_home/data/repos/admin_repo.dart';
import 'package:sahl_school_app/features/admin/admin_home/logic/admin_cubit.dart';
import 'package:sahl_school_app/features/login/data/repos/login_repo.dart';
import 'package:sahl_school_app/features/login/logic/login_cubit.dart';
import 'package:sahl_school_app/features/register/data/repos/register_repo.dart';
import 'package:sahl_school_app/features/register/logic/register_cubit.dart';
import 'package:sahl_school_app/features/student/student_home/data/repo/student_repo.dart';
import 'package:sahl_school_app/features/student/student_home/logic/student_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo());
  getIt.registerLazySingleton<LoginCubit>(() => LoginCubit(getIt()));

  //register
  getIt.registerLazySingleton<RegisterRepo>(() => RegisterRepo());
  getIt.registerLazySingleton<RegisterCubit>(() => RegisterCubit(getIt()));

  //student
  getIt.registerLazySingleton<StudentRepo>(() => StudentRepo());
  getIt.registerLazySingleton<StudentCubit>(() => StudentCubit(getIt()));

  //admin
  getIt.registerLazySingleton<AdminRepo>(() => AdminRepo());
  getIt.registerLazySingleton<AdminCubit>(() => AdminCubit(getIt()));

}
