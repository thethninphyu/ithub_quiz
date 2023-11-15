import 'package:flutter_modular/flutter_modular.dart';
import 'package:ithub_quiz/module/app_routes.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: AppRoutes.login);

  @override
  Future<bool> canActivate(String path, ModularRoute route) {
    return Future.value(true);
  }
}
