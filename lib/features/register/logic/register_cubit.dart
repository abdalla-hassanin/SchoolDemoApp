import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_school_app/features/register/data/models/register_request_body.dart';
import 'package:sahl_school_app/features/register/data/repos/register_repo.dart';
import 'package:sahl_school_app/features/register/logic/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepo _registerRepo;

  RegisterCubit(this._registerRepo) : super( RegisterInitial());

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List<bool> registerAsSelection = [false, false];
  String registerAsValue = '';

  void emitRegisterAsSelectionStates() {
    if (registerAsSelection[0]) {
      registerAsValue = 'admin';
    } else if (registerAsSelection[1]) {
      registerAsValue = 'student';
    }
  }

  void emitRegisterStates(RegisterRequestBody registerRequestBody) async {
    try{
    emit( RegisterLoading());
    final response = await _registerRepo.register(registerRequestBody);

      emit(RegisterSuccess(response));
    }catch(error) {
      emit(RegisterError(error: error.toString() ?? ''));
    }
  }
}
