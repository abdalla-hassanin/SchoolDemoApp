import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_school_app/core/di/dependency_injection.dart';
import 'package:sahl_school_app/features/student/student_home/data/models/exam.dart';
import 'package:sahl_school_app/features/student/student_home/logic/student_cubit.dart';
import 'package:sahl_school_app/features/student/student_home/logic/student_state.dart';

class ExamScreen extends StatefulWidget {
  final Exam exam;

  const ExamScreen(this.exam, {super.key});

  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  late StudentCubit studentCubit;
  List<int?> userAnswers=[];
  @override
  void initState() {
    super.initState();
    studentCubit = StudentCubit(getIt());
    userAnswers= List<int?>.filled(widget.exam.questions.length, null);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => studentCubit,
      child: BlocConsumer<StudentCubit, StudentState>(
        listener: (context, state) {
          if (state is StudentExamSuccess) {
            _showScoreDialog(state.score, state.numberOfQuestions);
          } else if (state is StudentExamError) {
            _showErrorDialog(state.error);
          }
        },
        builder: (context, state) {
          if (state is StudentExamSubmitting) {
            return _buildSubmittingState();
          } else {
            return _buildExamUI();
          }
        },
      ),
    );
  }

  Widget _buildSubmittingState() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exam.title),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildExamUI() {

  return  Scaffold(
      appBar: AppBar(
        title: Text(widget.exam.title),
      ),
      body: ListView.separated(
        itemCount: widget.exam.questions.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Question ${index + 1}: ${widget.exam.questions[index].questionText}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Column(
                  children: widget.exam.questions[index].options.map((option) {
                    int optionIndex = widget.exam.questions[index].options.indexOf(option);
                    return RadioListTile<int>(
                      title: Text(option),
                      value: optionIndex,
                      groupValue: userAnswers[index],
                      onChanged: (value) {
                        setState(() {
                          userAnswers[index] = value;
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (userAnswers.every((answer) => answer != null)) {
          studentCubit.submitExam(widget.exam, userAnswers);}
        },
        child: Icon(Icons.check),
      ),
    );
  }



  void _showScoreDialog(int score, int numberOfQuestions) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Exam Finished'),
          content: Text('Your Score: $score/$numberOfQuestions'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(error),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
