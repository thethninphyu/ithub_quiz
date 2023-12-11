import 'package:firebase_auth/firebase_auth.dart';
import 'package:ithub_quiz/ui/auth/auth_firestore.dart';
import 'package:ithub_quiz/utils/app_logger.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currenUser => _firebaseAuth.currentUser;

  Stream<User?> get authStageChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      logger.e("Login Success email is $email}");
    } catch (error) {
      logger.e("Authentication Error: ; $error");
      rethrow;
    }
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String name}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      //User? user = _firebaseAuth.currentUser;

      if (currenUser != null) {
        AuthStore().addUserToFirestore(
            userId: currenUser!.uid, name: name, email: email);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
