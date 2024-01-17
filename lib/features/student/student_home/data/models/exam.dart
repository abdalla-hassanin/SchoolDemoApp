import 'package:sahl_school_app/features/student/student_home/data/models/question.dart';

class Exam {
  final String id;
  final String title;
  final List<Question> questions;

  Exam(this.id, this.title, this.questions);
}