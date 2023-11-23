import 'package:flutter/material.dart';
import 'package:ithub_quiz/constants/colors.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  // ignore: prefer_typing_uninitialized_variables
  var width, height;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Profile Screen',
          style: TextStyle(color: Colors.amber),
        ),
      ),
      body: Container(
        color: AppColors.secondaryColor,
        child: Column(
          children: [
            Container(
              height: height * 0.25,
              width: width,
            ),
            Expanded(
              child: Container(
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
