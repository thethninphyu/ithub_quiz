import 'package:flutter/material.dart';

class AdminPageScreen extends StatefulWidget {
  const AdminPageScreen({super.key});

  @override
  State<AdminPageScreen> createState() => _AdminPageScreenState();
}

class _AdminPageScreenState extends State<AdminPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Screen'),
      ),
    );
  }
  

}
