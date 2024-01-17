import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_school_app/core/helpers/constants.dart';
import 'package:sahl_school_app/core/helpers/extensions.dart';
import 'package:sahl_school_app/features/student/student_home/data/models/exam.dart';
import 'package:sahl_school_app/features/student/student_home/data/repo/student_repo.dart';
import 'package:sahl_school_app/features/student/student_home/logic/student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  final StudentRepo _studentRepo;
  String? uId=userId;

  StudentCubit(this._studentRepo) : super(StudentInitial());

  Future<void> getExams() async {
    try {
      emit(StudentLoading());
      List<Exam> exams = await _studentRepo.fetchExams();
      emit(StudentExamsLoaded(exams));
    } catch (e) {
      emit(StudentError(error: e.toString()));
    }
  }

  Future<void> submitExam(Exam exam, List<int?> userAnswers) async {
    try {
      emit(StudentExamSubmitting());
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .get();
      await _studentRepo.submitExam(exam, userAnswers, uId!, userDoc['firstName']+" "+userDoc['lastName']);

      emit(StudentExamSuccess(
        score: _studentRepo.calculateScore(exam, userAnswers),
        numberOfQuestions: exam.questions.length,
      ));
    } catch (e) {
      emit(StudentExamError(error: e.toString()));
    }
  }
}
