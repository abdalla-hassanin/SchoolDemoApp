// admin_repo.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sahl_school_app/features/admin/admin_home/data/models/exam.dart';
import 'package:sahl_school_app/features/student/student_home/data/models/question.dart';

class AdminRepo {
  AdminRepo();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Exam>> fetchExams() async {
    try {
      QuerySnapshot<Map<String, dynamic>> examsSnapshot =
      await _firestore.collection('exams').get();


      List<Exam> exams = examsSnapshot.docs.map((doc) {
        final Map<String, dynamic>? data = doc.data();


        final scoresList = data?['scores'] as List<dynamic>?;
        List<Question> questions = (data?['questions'] as List<dynamic>?)
            ?.map((questionData) => Question.fromMap(questionData))
            .toList() ?? [];
        return Exam(
          title: data?['title'] ?? '',
          questions: questions ,
          scores: scoresList != null
              ? scoresList
              .map((score) => Score(
            studentId: score['studentId'],
            studentName: score['studentName'],
            score: score['score'],
          ))
              .toList()
              : [],
        );
      }).toList();

      return exams;
    } catch (e) {

      if (kDebugMode) {
        print('Error fetching exams: $e');
      }
      rethrow;
    }
  }

  Future<void> createExam(String title, List<Question> questions) async {

    try {
      await _firestore.collection('exams').add({
        'title': title,
        'questions': questions.map((question) => question.toMap()).toList(),
      });
    } catch (e) {
      // You might want to handle errors here, e.g., log them or throw a custom exception.
      print('Error creating exam: $e');
      throw e;
    }
  }
}
