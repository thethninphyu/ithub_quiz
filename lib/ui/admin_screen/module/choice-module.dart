import 'package:flutter_modular/flutter_modular.dart';
import 'package:ithub_quiz/ui/admin_screen/module/choice_route.dart';
import 'package:ithub_quiz/ui/admin_screen/multiple_choice_screen.dart';

class ChoiceFormModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(ChoiceRoute.multiChoice,
            child: ((context, args) => const MultipleChoiceScreen())),
      ];
}
