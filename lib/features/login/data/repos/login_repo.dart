import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahl_school_app/features/login/data/models/login_request_body.dart';

class LoginRepo {
  LoginRepo();

  Future<UserCredential> login(
      LoginRequestBody loginRequestBody) async {
    try {
      final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginRequestBody.email, password: loginRequestBody.password);
      return response;
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
