import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ithub_quiz/constants/colors.dart';
import 'package:ithub_quiz/ui/home/module/home_module.dart';
import 'package:ithub_quiz/ui/home/module/home_routes.dart';
import 'package:ithub_quiz/utils/app_router.dart';

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
        onPressed: () {
          AppRouter.changeRoute<HomeModule>(HomeRoutes.home);
        },
        child: Text("Heyy Click Me"),
      )),
    );
  }
}
