import 'package:flutter_modular/flutter_modular.dart';
import 'package:ithub_quiz/ui/admin_screen/module/question_create/quiz_form_screen.dart';
import 'package:ithub_quiz/ui/admin_screen/module/question_create/create_question_route.dart';
import 'package:ithub_quiz/ui/admin_screen/module/question_create/question_create_screen.dart';

class CreateQuestionModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(CreateQuestionRoutes.root,
            child: ((context, args) => const QuestionCreateScreen())),
        ChildRoute(CreateQuestionRoutes.question,
            child: ((context, args) => const QuestionScreen())),
      ];
}
