import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ithub_quiz/ui/auth/auth_firebase.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final User? user = Auth().currenUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget title() {
    return const Text("Firebase Auth");
  }

  Widget userUid() {
    return Text(user?.email ?? "Firebase Auth");
  }

  Widget signOutButton() {
    return ElevatedButton(onPressed: signOut, child: const Text("Sign Out"));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
