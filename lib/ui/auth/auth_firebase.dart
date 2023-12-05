import 'package:firebase_auth/firebase_auth.dart';
import 'package:ithub_quiz/ui/auth/auth_firestore.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currenUser => _firebaseAuth.currentUser;

  Stream<User?> get authStageChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String name}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = _firebaseAuth.currentUser;
      print("Current user $user");

      if (user != null) {
        AuthStore()
            .addUserToFirestore(userId: user.uid, name: name, email: email);
      }
    } catch (error) {
      print('Error creating user: $error');
      throw error;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
