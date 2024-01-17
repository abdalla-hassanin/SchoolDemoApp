import 'package:sahl_school_app/features/admin/admin_home/data/models/exam.dart';
import 'package:sahl_school_app/features/student/student_home/data/models/question.dart';

abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminLoaded extends AdminState {
  final List<Exam> exams;

  AdminLoaded(this.exams);
}

class AdminError extends AdminState {
  final String errorMessage;

  AdminError({required this.errorMessage});
}

class AdminQuestionsAdded extends AdminState {
  final List<Question> questions;

  AdminQuestionsAdded(this.questions);}

class AdminCreatingExam extends AdminState {}

class AdminCreateExamSuccess extends AdminState {}

class AdminCreateExamError extends AdminState {
  final String error;

   AdminCreateExamError({required this.error});
}
