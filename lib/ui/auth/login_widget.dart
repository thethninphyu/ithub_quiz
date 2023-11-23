import 'package:flutter/material.dart';
import 'package:ithub_quiz/constants/colors.dart';
import 'package:ithub_quiz/ui/home/module/home_module.dart';
import 'package:ithub_quiz/ui/home/module/home_routes.dart';
import 'package:ithub_quiz/utils/app_router.dart';
import 'package:ithub_quiz/utils/login_clipper.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: LoginClipper(),
            child: Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                color: AppColors.secondaryColor,
                child: MaterialButton(
                  onPressed: () {
                    AppRouter.changeRoute<HomeModule>(HomeRoutes.home);
                  },
                  child: const Text("Heyy Click Me"),
                )),
          ),
          ClipPath(
            clipper: LoginClipper(),
            child: Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                color: AppColors.secondaryColor,
                child: MaterialButton(
                  onPressed: () {
                    AppRouter.changeRoute<HomeModule>(HomeRoutes.home);
                  },
                  child: const Text("Heyy Click Me"),
                )),
          )
        ],
      ),
    );
  }
}
