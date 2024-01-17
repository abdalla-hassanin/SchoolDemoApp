import 'package:sahl_school_app/features/student/student_home/data/models/exam.dart';

abstract class StudentState {}

class StudentInitial extends StudentState {}

class StudentLoading extends StudentState {}

class StudentError extends StudentState {
  final String error;

  StudentError({required this.error});
}

class StudentExamsLoaded extends StudentState {
  final List<Exam> exams;

  StudentExamsLoaded(this.exams);
}

class StudentExamSubmitting extends StudentState {}

class StudentExamSuccess extends StudentState {
  final int score;
  final int numberOfQuestions;

  StudentExamSuccess({required this.score, required this.numberOfQuestions});
}

class StudentExamError extends StudentState {
  final String error;

  StudentExamError({required this.error});
}
