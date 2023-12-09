import 'package:flutter/material.dart';
import 'package:ithub_quiz/ui/auth/auth_firebase.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Profile Screen',
            style: TextStyle(color: Colors.amber),
          ),
        ),
        body: Center(
          child: ElevatedButton(
              onPressed: () {
                Auth().signOut();
              },
              child: const Text('Log Out')),
        ));
  }
}
