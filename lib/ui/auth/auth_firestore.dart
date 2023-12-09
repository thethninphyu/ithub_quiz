import 'package:cloud_firestore/cloud_firestore.dart';

class AuthStore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


//to add user to firestore
  Future<void> addUserToFirestore(
      {required String userId,
      required String name,
      required String email}) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'name': name,
        'email': email,
      });
      //print("Successful user adding to firestore.");
    } catch (error) {
      //print('Error adding user data to Firestore: $error');
      rethrow;
    }
  }




}
