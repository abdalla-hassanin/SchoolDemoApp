// student_repo.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sahl_school_app/features/student/student_home/data/models/exam.dart';
import 'package:sahl_school_app/features/student/student_home/data/models/question.dart';

class StudentRepo {
  StudentRepo();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Exam>> fetchExams() async {
    try {
      QuerySnapshot examSnapshot = await _firestore.collection('exams').get();

      List<Exam> exams = examSnapshot.docs.map((doc) {
        List<Question> questions = (doc['questions'] as List<dynamic>).map((q) {
          return Question(
            q['questionText'],
            List<String>.from(q['options']),
            q['correctAnswerIndex'],
          );
        }).toList();
        return Exam(doc.id, doc['title'], questions);
      }).toList();

      return exams;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching exams from Firestore: $e');
      }
      rethrow;
    }
  }


  Future<void> submitExam(Exam exam, List<int?> userAnswers, String studentId, String studentName) async {
    try {
      await _firestore.collection('exams').doc(exam.id).update({
        'scores': [{
          'studentId': studentId,
          'studentName': studentName,
          'score': calculateScore(exam, userAnswers),
        }],
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error saving score to Firestore: $e');
      }
      rethrow;
    }
  }

  int calculateScore(Exam exam, List<int?> userAnswers) {
    int score = 0;
    for (int i = 0; i < exam.questions.length; i++) {
      if (userAnswers[i] == exam.questions[i].correctAnswerIndex) {
        score++;
      }
    }
    return score;
  }
}
