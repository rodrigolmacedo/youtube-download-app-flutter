import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtube/app/modules/home/widgets/searchBar.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'home_controller.dart';
import 'package:youtube_api/youtube_api.dart';
import 'widgets/item_list.dart';
import 'widgets/player_audio.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  // final wss = Modular.get<WebSs>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    // wss.dispose();
  }

  Future<bool> _willPopScope() {
    return Future.value(false);
  }

  // void testStomp() {
  //   wss.stompClient.send(
  //       destination: '/app/broadcast',
  //       body: json.encode({'from': 'userName', 'text': 'text'}));
  // }
  double valor = 0;
  addValue() {
    print(valor);
    setState(() {
      valor += 0.1;
    });
  }

  resetValue() {
    print(valor);
    setState(() {
      valor = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopScope,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: <Widget>[
              SearchBarWidget(
                searchFunction: controller.searchFunction,
                queryController: controller.queryController,
                suggestionsBoxController: controller.suggestionsBoxController,
                queryService: controller.queryService,
              ),
              Expanded(
                child: Observer(
                  builder: (context) {
                    if (controller.ytResult == null &&
                        !controller.isSearching) {
                      return Center(
                          child: Image.asset('assets/images/empty_bg.png',
                              fit: BoxFit.contain));
                    }
                    if (controller.isSearching) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView.builder(
                        itemCount: controller.ytResult.value
                            .where((element) => element.kind == 'video')
                            .toList()
                            .length,
                        itemBuilder: (_, int index) {
                          final YT_API ytResult = controller.ytResult.value
                              .where((element) => element.kind == 'video')
                              .toList()[index];
                          // print("video: ${ytResult.title} - ${ytResult.kind}");
                          return listItem(ytResult);
                        });
                  },
                ),
              ),
              Observer(builder: (context) {
                if (controller.selectedPreview == null) {
                  return Container();
                }
                if (controller.playerController.isLoading) {
                  return Card(
                      child: Container(
                          padding: const EdgeInsets.all(15),
                          width: double.infinity,
                          child: Center(child: CircularProgressIndicator())));
                }
                return PlayerAudioWidget(controller: controller);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget listItem(YT_API ytResult) {
    return ItemListWidget(controller: controller, ytResult: ytResult);
  }
}
