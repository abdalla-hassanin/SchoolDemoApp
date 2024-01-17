import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sahl_school_app/features/login/data/models/login_request_body.dart';
import 'package:sahl_school_app/features/login/data/repos/login_repo.dart';
import 'package:sahl_school_app/features/login/logic/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;

  LoginCubit(this._loginRepo) : super( LoginInitial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void emitLoginStates(LoginRequestBody loginRequestBody) async {
    try {
      emit( LoginLoading());
      final response = await _loginRepo.login(loginRequestBody);
      emit(LoginSuccess(response));
    } catch (e) {
      emit(LoginError(error: e.toString() ?? ''));
    }
  }
}
