import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahl_school_app/features/register/data/models/register_request_body.dart';

class RegisterRepo {
  RegisterRepo();

  Future<UserCredential> register(
      RegisterRequestBody registerRequestBody) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: registerRequestBody.email,
              password: registerRequestBody.password);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(registerRequestBody.toJson());

      return userCredential;
    } catch (error) {
      if (error is FirebaseAuthException) {
        throw error.message.toString();
      } else {
        // Handle other errors
        throw 'An unexpected error occurred: $error';
      }
    }
  }
}
