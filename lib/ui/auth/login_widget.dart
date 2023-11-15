import 'package:flutter/material.dart';
import 'package:ithub_quiz/constants/colors.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Heyy I am title",
          style: TextStyle(
              fontSize: 32,
              color: AppColors.secondaryColor,
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          child: MaterialButton(
        onPressed: () {},
        child: Text("Heyy Click Me"),
      )),
    );
  }
}
