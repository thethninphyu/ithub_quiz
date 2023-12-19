import 'package:flutter/material.dart';
import 'package:ithub_quiz/constants/colors.dart';
import 'package:ithub_quiz/ui/admin_screen/module/admin_module.dart';
import 'package:ithub_quiz/ui/app_routes.dart';
import 'package:ithub_quiz/ui/auth/auth_firebase.dart';
import 'package:ithub_quiz/ui/auth/module/auth_module.dart';
import 'package:ithub_quiz/utils/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Auth().authStageChanges.listen((snapShot) {
        if (snapShot != null && snapShot.email != null) {
          AppRouter.changeRoute<AdminModule>(AppRoutes.root, context: context, isReplaceAll: true,);
          //AppStrings.logger.e("Login email address is ${snapShot.email}");
        } else {
          AppRouter.changeRoute<AuthModule>(AppRoutes.login, context: context);
          //AppStrings.logger.e("Login Failed");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.backgroundColor,
        child: Center(
          child: Image.asset('assets/quiz.png', width: 95, height: 95),
        ),
      ),
    );
  }
}
