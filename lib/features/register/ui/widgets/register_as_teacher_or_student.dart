import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_school_app/core/theming/color/light_colors.dart';
import 'package:sahl_school_app/features/register/logic/register_cubit.dart';

class RegisterAsTeacherOrStudent extends StatefulWidget {
  RegisterAsTeacherOrStudent({super.key});

  @override
  State<RegisterAsTeacherOrStudent> createState() =>
      _RegisterAsTeacherOrStudent();
}

class _RegisterAsTeacherOrStudent
    extends State<RegisterAsTeacherOrStudent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Register As', style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height:8),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ToggleButtons(
                  isSelected: context.read<RegisterCubit>().registerAsSelection,
                  onPressed: (index) {
                    setState(() {
                      context.read<RegisterCubit>().registerAsSelection =
                          List.generate(
                        context
                            .read<RegisterCubit>()
                            .registerAsSelection
                            .length,
                        (i) => index == i ? true : false,
                      );
                      context
                          .read<RegisterCubit>()
                          .emitRegisterAsSelectionStates();
                    });
                  },
                  borderRadius: BorderRadius.circular(16.0),
                  fillColor: LightColors.primaryColor,
                  borderWidth: 2,
                  borderColor: Colors.grey,
                  selectedBorderColor: LightColors.primaryColor,
                  children: const [
                    TabBarButton(
                      label: 'Teacher',
                    ),
                    TabBarButton(
                      label: 'Student',
                    ),
                  ],
                ),
                SizedBox(height:4),
                // Show error message if no toggle button is selected
                if (!context
                    .read<RegisterCubit>()
                    .registerAsSelection
                    .contains(true))
                  const Text(
                    'Please select a role',
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
          SizedBox(height:18),
        ],
      ),
    );
  }
}

class TabBarButton extends StatelessWidget {
  final String label;

  const TabBarButton({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 80,
      height: 45,
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
