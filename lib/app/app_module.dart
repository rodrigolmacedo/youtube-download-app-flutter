import 'package:youtube/app/app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtube/app/modules/home/home_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute("/", module: HomeModule()),
      ];
}
