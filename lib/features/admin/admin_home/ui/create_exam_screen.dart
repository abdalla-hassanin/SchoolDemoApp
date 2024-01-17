import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_school_app/core/di/dependency_injection.dart';
import 'package:sahl_school_app/core/routing/routes.dart';
import 'package:sahl_school_app/core/widgets/app_text_button.dart';
import 'package:sahl_school_app/core/widgets/app_text_form_field.dart';
import 'package:sahl_school_app/features/admin/admin_home/logic/admin_cubit.dart';
import 'package:sahl_school_app/features/admin/admin_home/logic/admin_state.dart';
import 'package:sahl_school_app/features/admin/admin_home/ui/widgets/new_question_fab.dart';
import 'package:sahl_school_app/features/student/student_home/data/models/question.dart';

class CreateExamScreen extends StatelessWidget {
  CreateExamScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController examTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminCubit(getIt()),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Create Exam',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 36),
                    AppTextFormField(
                      hintText: 'Exam Title',
                      controller: examTitleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Exam Title';
                        }
                      },
                    ),
                    SizedBox(height: 36),
                    Column(
                      children: [
                        Text(
                          'Questions List',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        BlocBuilder<AdminCubit, AdminState>(
                          builder: (context, state) {
                            if (state is AdminQuestionsAdded) {
                              List<Question> questions =
                                  state.questions; // Adjust as needed
                              return Column(
                                children: [
                                  for (int i = 0; i < questions.length; i++)
                                    ListTile(
                                      title: Text(questions[i].questionText),
                                      subtitle: Text(
                                        'Correct Answer: ${String.fromCharCode('A'.codeUnitAt(0) + questions[i].correctAnswerIndex)}',
                                      ),
                                    ),
                                ],
                              );
                            } else {
                              // Handle other states or show loading indicator if needed
                              return SizedBox.shrink();
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 36),
                    BlocBuilder<AdminCubit, AdminState>(
                      builder: (context, state) {
                        return AppTextButton(
                          buttonText: 'Create Exam',
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate() &&
                                context.read<AdminCubit>().questions.isNotEmpty) {
                           await   context.read<AdminCubit>().createExam(
                                    title: examTitleController.text,
                                    questions:
                                        context.read<AdminCubit>().questions,
                                  );
                              examTitleController.clear();
                              context.read<AdminCubit>().questions = [];
                              Navigator.pop(context);
                            }else{
                                   ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please add at least one question')),
                              );}
                          },

                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: NewQuestionFab(),
      ),
    );
  }
}
