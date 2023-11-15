import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ithub_quiz/constants/colors.dart';
import 'package:ithub_quiz/constants/strings.dart';

class IthubQuiz extends StatelessWidget {
  const IthubQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          secondaryHeaderColor: AppColors.secondaryColor,
          fontFamily: 'Gilroy'),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
