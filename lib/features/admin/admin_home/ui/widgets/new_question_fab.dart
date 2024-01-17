import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_school_app/core/theming/color/light_colors.dart';
import 'package:sahl_school_app/features/admin/admin_home/logic/admin_cubit.dart';
import 'package:sahl_school_app/features/student/student_home/data/models/question.dart';

class NewQuestionFab extends StatefulWidget {
  const NewQuestionFab({super.key});

  @override
  State<NewQuestionFab> createState() => _NewQuestionFabState();
}

class _NewQuestionFabState extends State<NewQuestionFab> {
  late AdminCubit cubit;
  @override
  Widget build(BuildContext context) {
     cubit=context.read<AdminCubit>();
    return FloatingActionButton.extended(
      onPressed: () {
        _showDialog();
      },
      label: Text('New Question'),
      icon: const Icon(Icons.add),
      foregroundColor: LightColors.whiteColor,
      backgroundColor: LightColors.primaryColor,
    );
  }

  void _showDialog() {
    final _formKey = GlobalKey<FormState>();
    TextEditingController questionController = TextEditingController();
    TextEditingController answerController1 = TextEditingController();
    TextEditingController answerController2 = TextEditingController();
    TextEditingController answerController3 = TextEditingController();
    TextEditingController answerController4 = TextEditingController();
    TextEditingController answerController5 = TextEditingController();
    int correctAnswerIndex = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Add Question'),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: double.maxFinite,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          controller: questionController,
                          decoration:
                              const InputDecoration(labelText: 'Enter Question'),
                          validator: (value) {
                            if (value == null || questionController.text.isEmpty) {
                              return 'Please enter a question';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        _buildAnswerTextField(
                            answerController1, 0, correctAnswerIndex, setState),
                        _buildAnswerTextField(
                            answerController2, 1, correctAnswerIndex, setState),
                        _buildAnswerTextField(
                            answerController3, 2, correctAnswerIndex, setState),
                        _buildAnswerTextField(
                            answerController4, 3, correctAnswerIndex, setState),
                        _buildAnswerTextField(
                            answerController5, 4, correctAnswerIndex, setState),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            const Text('Correct Answer: '),
                            const SizedBox(width: 8.0),
                            DropdownButton<int>(
                              value: correctAnswerIndex,
                              onChanged: (int? newValue) {
                                setState(() {
                                  correctAnswerIndex = newValue!;
                                });
                              },
                              items: List.generate(5, (index) => index - 1)
                                  .map<DropdownMenuItem<int>>(
                                    (int value) => DropdownMenuItem<int>(
                                      value: value + 1,
                                      child: Text(
                                          'Answer ${String.fromCharCode('A'.codeUnitAt(0) + value + 1)}'),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Validate and save the question
                    if (_formKey.currentState!.validate()) {
                      // Save the question in NewExamCubit

                      cubit.addQuestion(
                        Question( questionController.text,
                           [
                            answerController1.text,
                            answerController2.text,
                            answerController3.text,
                            answerController4.text,
                            answerController5.text,
                          ],
                           correctAnswerIndex,
                        ),
                      );

                      Navigator.pop(context);
                    }
                  },
                  child: Text('Add Question'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildAnswerTextField(
    TextEditingController controller,
    int index,
    int correctAnswerIndex,
    StateSetter setState,
  ) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || controller.text.isEmpty) {
          return 'Please enter an answer';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Answer ${String.fromCharCode('A'.codeUnitAt(0) + index)}',
        suffixIcon: Radio<int>(
          value: index,
          groupValue: correctAnswerIndex,
          onChanged: (int? value) {
            setState(() {
              correctAnswerIndex = value!;
            });
          },
        ),
      ),
    );
  }

}
