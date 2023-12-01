import 'package:flutter_modular/flutter_modular.dart';
import 'package:ithub_quiz/ui/admin_screen/module/admin_module.dart';
import 'package:ithub_quiz/ui/app_routes.dart';
import 'package:ithub_quiz/ui/auth/module/auth_module.dart';
import 'package:ithub_quiz/ui/home/module/home_module.dart';
import 'package:ithub_quiz/ui/splash_screen/splash_screen.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(AppRoutes.root, child: (context, args) => const SplashScreen()),
        ModuleRoute(AppRoutes.login, module: AuthModule()),
        ModuleRoute(AppRoutes.home, module: HomeModule()),
        ModuleRoute(AppRoutes.admin, module: AdminModule())
      ];
}
