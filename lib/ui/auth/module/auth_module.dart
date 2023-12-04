import 'package:flutter_modular/flutter_modular.dart';
import 'package:ithub_quiz/ui/app_routes.dart';
import 'package:ithub_quiz/ui/auth/login_widget.dart';
import 'package:ithub_quiz/ui/auth/module/auth_routes.dart';
import 'package:ithub_quiz/ui/auth/register_widget.dart';
import 'package:ithub_quiz/ui/splash_screen/splash_screen.dart';

class AuthModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(AuthRoutes.root,
            child: (context, args) => const SplashScreen()),
        ChildRoute(AppRoutes.login,
            child: ((context, args) => const LoginWidget())),
        ChildRoute(AppRoutes.register,
            child: ((context, args) => const RegisterWidget())),
        // ModuleRoute(AppRoutes.login, module: AuthModule()),
      ];
}
