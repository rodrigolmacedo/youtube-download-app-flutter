import 'package:youtube/app/modules/home/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtube/app/modules/home/home_page.dart';
import 'package:youtube/app/modules/home/repository/data.dart';
import 'player_controller.dart';
import 'youtube_explode.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => HomeController(
            i.get<QueryService>(),
            i.get<YoutubeExplode>(),
            i.get<PlayerController>(),
          ),
        ),
        Bind((i) => PlayerController()),
        Bind((i) => YoutubeExplode()),
        Bind((i) => QueryService()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (_, args) => HomePage()),
      ];
}
