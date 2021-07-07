import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtube/app/modules/home/home_controller.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:intl/intl.dart';

class ItemListWidget extends StatelessWidget {
  final YT_API ytResult;
  final HomeController controller;

  const ItemListWidget({Key key, this.ytResult, this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 7.0),
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Column(
                  children: [
                    Image.network(
                      ytResult.thumbnail['default']['url'],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Data " +
                          DateFormat("dd/MM/yyyy").format(
                              DateTime.parse(ytResult.publishedAt).toLocal())),
                    ),
                    Text("Duração - ${ytResult.duration}")
                  ],
                ),
                Padding(padding: EdgeInsets.only(right: 20.0)),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        ytResult.title,
                        softWrap: true,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 1.5)),
                      Text(
                        ytResult.channelTitle,
                        softWrap: true,
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 3.0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.play_circle_outline,
                              size: 50,
                            ),
                            onPressed: () => controller.selectPreview(ytResult),
                          ),
                          Observer(builder: (context) {
                            return controller.youtubeExplode.downloadingVideo ==
                                    ytResult.id
                                ? Center(
                                    child: CircularProgressIndicator(
                                      value: controller.youtubeExplode.progress,
                                      backgroundColor: Colors.grey,
                                    ),
                                  )
                                : IconButton(
                                    icon: Icon(
                                      Icons.file_download,
                                      size: 50,
                                    ),
                                    onPressed: () {
                                      controller.youtubeExplode
                                          .downloadVideoAudio(
                                              ytResult.id, ytResult.title);
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) {
                                          return Center(
                                              child: Observer(
                                            builder: (context) => Card(
                                              margin: EdgeInsets.all(20),
                                              child: Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Baixando: ${(controller.youtubeExplode.progress * 100).ceil()}%",
                                                          ),
                                                          controller.youtubeExplode
                                                                      .progress ==
                                                                  1.0
                                                              ? AnimatedContainer(
                                                                  duration:
                                                                      Duration(
                                                                          seconds:
                                                                              1),
                                                                  curve: Curves
                                                                      .bounceIn,
                                                                  child: Icon(
                                                                    Icons
                                                                        .check_circle,
                                                                    color: Colors
                                                                        .green,
                                                                    size: 30,
                                                                  ))
                                                              : CircularProgressIndicator(
                                                                  value: controller
                                                                      .youtubeExplode
                                                                      .progress,
                                                                  semanticsValue:
                                                                      "${controller.youtubeExplode.progress * 100}",
                                                                  semanticsLabel:
                                                                      "%",
                                                                  backgroundColor:
                                                                      Colors
                                                                          .grey,
                                                                )
                                                        ],
                                                      ),
                                                      Divider(),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Convertendo para MP3",
                                                          ),
                                                          controller.youtubeExplode
                                                                          .progress ==
                                                                      1.0 &&
                                                                  controller
                                                                          .youtubeExplode
                                                                          .conversao ==
                                                                      false
                                                              ? CircularProgressIndicator(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .grey,
                                                                )
                                                              : Icon(
                                                                  controller
                                                                          .youtubeExplode
                                                                          .conversao
                                                                      ? Icons
                                                                          .check_circle
                                                                      : Icons
                                                                          .update,
                                                                  size: 30,
                                                                  color: controller
                                                                          .youtubeExplode
                                                                          .conversao
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .grey)
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 10),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            controller.youtubeExplode
                                                                            .conversao ==
                                                                        false ||
                                                                    controller
                                                                            .youtubeExplode
                                                                            .progress <
                                                                        1.0
                                                                ? OutlineButton(
                                                                    child: Text(
                                                                        'Cancelar'),
                                                                    onPressed:
                                                                        () {
                                                                      if (controller
                                                                              .youtubeExplode
                                                                              .progress <
                                                                          1.0) {
                                                                        controller
                                                                            .youtubeExplode
                                                                            .cancelarDownload();
                                                                        Modular
                                                                            .to
                                                                            .pop();
                                                                      } else {
                                                                        controller
                                                                            .youtubeExplode
                                                                            .cancelarConversao();
                                                                      }
                                                                    })
                                                                : OutlineButton(
                                                                    child: Text(
                                                                        'OK'),
                                                                    onPressed:
                                                                        Modular
                                                                            .to
                                                                            .pop)
                                                          ],
                                                        ),
                                                      )
                                                    ]),
                                              ),
                                            ),
                                          ));
                                        },
                                      );
                                    });
                          })
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
