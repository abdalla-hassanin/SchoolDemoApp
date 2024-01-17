import 'package:sahl_school_app/features/student/student_home/data/models/question.dart';

class Exam {
  final String title;
  final List<Question> questions;
  final List<Score> scores;

  Exam({
    required this.title,
    required this.questions,
    required this.scores,
  });
}

class Score {
  final String studentId;
  final String studentName;
  final int score;

  Score({
    required this.studentId,
    required this.studentName,
    required this.score,
  });
}