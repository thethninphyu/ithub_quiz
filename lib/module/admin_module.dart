
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ithub_quiz/module/home_module.dart';

class AdminModule extends Module{
  

@override
  List<Bind<Object>> get binds => [

  ];

  @override
  List<ModularRoute> get routes => [
ModuleRoute('/home', module: HomeModule()),
  ];

}
