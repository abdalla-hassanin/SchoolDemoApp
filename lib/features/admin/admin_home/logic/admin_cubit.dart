import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahl_school_app/features/admin/admin_home/data/models/exam.dart';
import 'package:sahl_school_app/features/admin/admin_home/data/repos/admin_repo.dart';
import 'package:sahl_school_app/features/admin/admin_home/logic/admin_state.dart';
import 'package:sahl_school_app/features/student/student_home/data/models/question.dart';

class AdminCubit extends Cubit<AdminState> {
  final AdminRepo _adminRepo;

  AdminCubit(this._adminRepo) : super(AdminInitial());

  List<Question> questions = [];

  Future<void> addQuestion(Question question) async {
    questions.add(question);
    emit(AdminQuestionsAdded(questions));
  }


  Future<void> getExams() async {
    emit(AdminLoading());
    try {
      // Fetch exams from Firestore using AdminRepo
      List<Exam> exams  = await _adminRepo.fetchExams();
      emit(AdminLoaded(exams));
    } catch (e) {
      // Handle errors
      emit(AdminError(errorMessage: e.toString()));
    }
  }
  // admin_cubit.dart
  Future<void> createExam({required String title, required List<Question> questions}) async {
    try {
      emit(AdminCreatingExam());

      // Assuming you have a method in your repo to save the exam to Firestore
      await _adminRepo.createExam(title, questions);
      emit(AdminCreateExamSuccess());

    } catch (e) {
      emit(AdminCreateExamError(error: e.toString()));
    }
  }
}
