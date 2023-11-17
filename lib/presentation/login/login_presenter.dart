import 'package:firebase_auth/firebase_auth.dart';
import '../../config/auth/auth.dart';

class LoginPresenter {
  static Future<String?> signInWithEmailAndPassword(email, password) async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  static Future<String?> createUserWithEmailAndPassword(email, password) async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
