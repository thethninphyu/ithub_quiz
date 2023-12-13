import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ithub_quiz/ui/admin_screen/module/admin_module.dart';
import 'package:ithub_quiz/ui/admin_screen/module/admin_route.dart';
import 'package:ithub_quiz/ui/admin_screen/module/choice-module.dart';
import 'package:ithub_quiz/ui/admin_screen/module/question_create/create_question_module.dart';
import 'package:ithub_quiz/ui/app_routes.dart';
import 'package:ithub_quiz/ui/auth/module/auth_module.dart';
import 'package:ithub_quiz/ui/home/module/home_module.dart';

class AppRouter {
  static void _goToNextPage({
    required String routeName,
    Object? args,
    bool isReplace = false,
    bool isReplaceAll = false,
  }) {
    if (isReplace) {
      Modular.to.pushReplacementNamed(routeName, arguments: args);
    } else if (isReplaceAll) {
      Modular.to.pushNamedAndRemoveUntil(
          routeName, (Route<dynamic> route) => false,
          arguments: args);
    } else {
      Modular.to.pushNamed(routeName, arguments: args);
    }
  }

  static void changeRoute<M extends Module>(
    String routes, {
    Object? args,
    bool? isReplace,
    bool? isReplaceAll,
    required BuildContext context,
  }) {
    String tempRoute = "";

    switch (M) {
      case AuthModule:
        tempRoute = AppRoutes.login;
        break;
      case HomeModule:
        tempRoute = AppRoutes.root;
        break;
      case AdminModule:
        tempRoute = AppRoutes.admin;
        break;
      case CreateQuestionModule:
        tempRoute = AppRoutes.admin + AdminRoutes.create;
        break;
      case ChoiceFormModule:
        tempRoute = AppRoutes.admin + AdminRoutes.multipleChoiceScreen;
        break;
    }

    _goToNextPage(
      routeName: "$tempRoute$routes",
      args: args,
      isReplace: isReplace ?? false,
      isReplaceAll: isReplaceAll ?? false,
    );
  }
}
