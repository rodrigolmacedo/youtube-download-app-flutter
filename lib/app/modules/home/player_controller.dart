import 'package:mobx/mobx.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

part 'player_controller.g.dart';

class PlayerController = _PlayerControllerBase with _$PlayerController;

abstract class _PlayerControllerBase with Store {
  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  @observable
  bool isLoading = false;

  stop() {
    assetsAudioPlayer.stop();
  }

  playOrPause() {
    assetsAudioPlayer.playOrPause();
  }

  Future<void> previewAudio(
      String url, String tittle, String imageCapa, String id) async {
    if (isLoading) return;
    stop();
    isLoading = true;
    try {
      final audio = Audio.liveStream(url,
          metas: Metas(
              title: tittle, image: MetasImage.network(imageCapa), id: id),
          playSpeed: 1.0);
      await assetsAudioPlayer
          .open(
        audio,
        playInBackground: PlayInBackground.enabled,
        showNotification: true,
        autoStart: true,
        notificationSettings: NotificationSettings(
            customPlayPauseAction: (player) => player.playOrPause(),
            customStopAction: (player) => player.stop(),
            nextEnabled: false,
            prevEnabled: false,
            //seek not working..
            seekBarEnabled: false),
      )
          .whenComplete(() {
        isLoading = false;
      });
    } catch (t) {
      //stream unreachable
      print(t);
    }
  }
}
