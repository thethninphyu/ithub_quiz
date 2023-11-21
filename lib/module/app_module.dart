

import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {


@override
  List<Bind<Object>> get binds => [

  ];

  @override
  List<ModularRoute> get routes => [
  ModuleRoute('/', module: AdminModule()),
  ModuleRoute('/login', module: AuthModule()),
  ModuleRoute('/home', module: HomeModule()),
  ];

}
