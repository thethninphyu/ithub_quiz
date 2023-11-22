import 'package:flutter_modular/flutter_modular.dart';
import 'package:ithub_quiz/ui/admin_screen/admin_page_screen.dart';
import 'package:ithub_quiz/ui/admin_screen/module/admin_route.dart';
import 'package:ithub_quiz/ui/admin_screen/admin_profile_screen.dart';
import 'package:ithub_quiz/ui/admin_screen/module/question_create/create_question_module.dart';

class AdminModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(AdminRoutes.root,
            child: (context, args) => const AdminPageScreen()),
        ModuleRoute(AdminRoutes.create, module: CreateQuestionModule()),
        ChildRoute(AdminRoutes.profileScreen,
            child: ((context, args) => const AdminProfileScreen())),
      ];
}
