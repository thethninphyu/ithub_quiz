import 'package:flutter/material.dart';
import 'package:ithub_quiz/constants/colors.dart';
import 'package:ithub_quiz/ui/app_routes.dart';
import 'package:ithub_quiz/ui/auth/login_widget.dart';
import 'package:ithub_quiz/ui/auth/module/auth_module.dart';
import 'package:ithub_quiz/utils/app_router.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    AppRouter.changeRoute<AuthModule>(AppRoutes.login);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 4000,
      splash: Image.asset('assets/quiz.png'),
      splashTransition: SplashTransition.decoratedBoxTransition,
      splashIconSize: 95,
      backgroundColor: AppColors.backgroundColor,
      nextScreen: const LoginWidget(),
    );
  }
}
