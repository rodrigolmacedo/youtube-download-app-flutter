import 'package:flutter/material.dart';
import 'package:youtube/app/modules/home/home_controller.dart';

class PlayerAudioWidget extends StatelessWidget {
  final HomeController controller;

  const PlayerAudioWidget({Key key, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (controller.ytResult != null && !controller.playerController.isLoading) {
      return Card(
          child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(controller.selectedPreview.title),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.fast_rewind),
                      onPressed: () {
                        if (controller.youtubeExplode.durationAudio <=
                            Duration(seconds: 10)) {
                          controller.playerController.assetsAudioPlayer
                              .seek(Duration(seconds: 0));
                        } else {
                          controller.playerController.assetsAudioPlayer.seek(
                            (controller.playerController.assetsAudioPlayer
                                    .currentPosition.valueWrapper.value -
                                Duration(seconds: 10)),
                          );
                        }
                      }),
                  StreamBuilder(
                      stream: controller
                          .playerController.assetsAudioPlayer.isPlaying,
                      builder: (context, snapshot) => snapshot.hasData
                          ? IconButton(
                              icon: Icon(snapshot.data
                                  ? Icons.stop
                                  : Icons.play_arrow),
                              onPressed: () async => await controller
                                  .playerController
                                  .playOrPause(),
                            )
                          : CircularProgressIndicator()),
                  IconButton(
                      icon: Icon(Icons.fast_forward),
                      onPressed: () =>
                          controller.playerController.assetsAudioPlayer.seek(
                            (controller.playerController.assetsAudioPlayer
                                    .currentPosition.valueWrapper.value +
                                Duration(seconds: 10)),
                          )),
                  StreamBuilder(
                    stream: controller
                        .playerController.assetsAudioPlayer.currentPosition,
                    builder: (context, asyncSnapshot) {
                      if (!asyncSnapshot.hasData) {
                        return Center(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final Duration duration = asyncSnapshot.data;
                      return Expanded(
                        child: Stack(children: <Widget>[
                          Slider(
                            value: duration.inSeconds.toDouble(),
                            max: controller
                                    .youtubeExplode.durationAudio?.inSeconds
                                    ?.toDouble() ??
                                0,
                            min: 0,
                            onChanged: (value) => controller
                                .playerController.assetsAudioPlayer
                                .seek(
                              (Duration(seconds: value.toInt())),
                            ),
                          ),
                          Positioned(
                            bottom: -2,
                            right: 20,
                            child: Text(
                                '${duration.mmSSFormat} / ${controller.youtubeExplode.durationAudio?.mmSSFormat}'),
                          )
                        ]),
                      );
                    },
                  ),
                ],
              ),
            ),
            // StreamBuilder(
            //   stream:
            //       controller.playerController.assetsAudioPlayer.volume,
            //   builder: (context, snapshot) => snapshot.hasData
            //       ? Slider(
            //           value: snapshot.data,
            //           onChanged: controller
            //               .playerController.assetsAudioPlayer.setVolume)
            //       : CircularProgressIndicator(),
            // )
          ],
        ),
      ));
    } else {
      return CircularProgressIndicator();
    }
  }
}

extension FormatString on Duration {
  String get mmSSFormat {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String hourDigit =
        twoDigits(this.inHours?.remainder(Duration.hoursPerDay) ?? 0);
    String twoDigitMinutes =
        twoDigits(this.inMinutes.remainder(Duration.minutesPerHour));
    String twoDigitSeconds =
        twoDigits(this.inSeconds.remainder(Duration.secondsPerMinute));
    return "$hourDigit:$twoDigitMinutes:$twoDigitSeconds";
  }
}
