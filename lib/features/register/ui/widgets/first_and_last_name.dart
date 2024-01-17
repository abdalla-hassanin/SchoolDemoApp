import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_school_app/core/helpers/app_regex.dart';
import 'package:sahl_school_app/core/widgets/app_text_form_field.dart';
import 'package:sahl_school_app/features/register/logic/register_cubit.dart';

class FirstAndLastName extends StatelessWidget {
  const FirstAndLastName({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextFormField(
          hintText: 'First Name',
          validator: (value) {
            if (value == null ||
                value.isEmpty ||
                !AppRegex.isValidName(value)) {
              return 'Please enter a valid name';
            }
          },
          controller: context.read<RegisterCubit>().firstNameController,
        ),
        SizedBox(height:18),
        AppTextFormField(
          hintText: 'Last Name',
          validator: (value) {
            if (value == null ||
                value.isEmpty ||
                !AppRegex.isValidName(value)) {
              return 'Please enter a valid name';
            }
          },
          controller: context.read<RegisterCubit>().lastNameController,
        ),
        SizedBox(height:18),
      ],
    );
  }
}
