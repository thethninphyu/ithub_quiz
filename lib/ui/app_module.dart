import 'package:flutter_modular/flutter_modular.dart';

import 'package:ithub_quiz/ui/admin_screen/module/admin_module.dart';
import 'package:ithub_quiz/ui/app_routes.dart';
import 'package:ithub_quiz/ui/auth/module/auth_module.dart';
import 'package:ithub_quiz/ui/home/module/home_module.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(AppRoutes.root, module: AdminModule()),
        //ModuleRoute(AppRoutes.login, module: AuthModule()),
        //ModuleRoute(AppRoutes.home, module: HomeModule()),
      ];
}
