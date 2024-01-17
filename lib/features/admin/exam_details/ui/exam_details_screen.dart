import 'package:flutter/material.dart';
import 'package:sahl_school_app/features/admin/admin_home/data/models/exam.dart';
import 'package:sahl_school_app/features/student/student_home/data/models/question.dart';

class ExamDetailsScreen extends StatelessWidget {
  final Exam exam;

  const ExamDetailsScreen({
    Key? key,
    required this.exam,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Details: ${exam.title}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Number of Questions: ${exam.questions.length}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(height: 16),
            Text(
              'Questions and Options:',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 8),
            _buildQuestionsList(exam.questions),
            const SizedBox(height: 16),
            Text(
              'Student Scores:',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 8),
            _buildStudentScores(exam),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionsList(List<Question> questions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < questions.length; i++)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${i + 1}. ${questions[i].questionText}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              for (int j = 0; j < questions[i].options.length; j++)
                ListTile(
                  title: Text(
                    '${String.fromCharCode('A'.codeUnitAt(0) + j)}. ${questions[i].options[j]}',
                  ),
                ),
              const SizedBox(height: 16),
            ],
          ),
      ],
    );
  }

  Widget _buildStudentScores(Exam exam) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for ( int i = 0; i < exam.scores.length; i++)
          ListTile(
            title: Text(
              'Student: ${exam.scores[i].studentName}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Your Score: ${exam.scores[i].score}/${exam.questions.length}'),
          ),
      ],
    );
  }
}
