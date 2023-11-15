import 'package:flutter_modular/flutter_modular.dart';
import 'package:ithub_quiz/ui/auth/login_widget.dart';
import 'package:ithub_quiz/ui/auth/module/auth_routes.dart';

class AuthModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(AuthRoutes.root,
            child: ((context, args) => const LoginWidget()))
      ];
}
