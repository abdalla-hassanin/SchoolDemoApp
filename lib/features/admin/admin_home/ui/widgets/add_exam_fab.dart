import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_school_app/core/routing/routes.dart';
import 'package:sahl_school_app/core/theming/color/light_colors.dart';
import 'package:sahl_school_app/features/admin/admin_home/logic/admin_cubit.dart';

class AddExamFAB extends StatelessWidget {
  const AddExamFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.pushNamed(context, Routes.createExamScreen,);
        context.read<AdminCubit>().getExams();
      },
      label: const Text('New Exam'),
      icon: const Icon(Icons.add),
      foregroundColor: LightColors.whiteColor,
      backgroundColor: LightColors.primaryColor,
    );
  }
}
