import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mobx/mobx.dart';
import 'package:youtube/app/modules/home/repository/data.dart';
import 'package:youtube/app/util/constants.dart';
import 'package:youtube_api/youtube_api.dart';
import 'youtube_explode.dart';
import 'player_controller.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final YoutubeAPI ytApi = new YoutubeAPI(YOUTUBE_API_KEY);
  final QueryService queryService;

  final YoutubeExplode youtubeExplode;
  final PlayerController playerController;

  _HomeControllerBase(
      this.queryService, this.youtubeExplode, this.playerController) {
    ytApi.api.maxResults = 25;
  }

  TextEditingController queryController = TextEditingController();
  SuggestionsBoxController suggestionsBoxController =
      SuggestionsBoxController();

  @observable
  YT_API selectedPreview;

  @observable
  bool isSearching = false;

  @observable
  ObservableFuture<List<YT_API>> ytResult;

  searchFunction(String query) {
    if (query.isNotEmpty) {
      queryController.text = query.trim();
      callAPI();
    }
  }

  play() async {
    playerController.assetsAudioPlayer.stop();
    await youtubeExplode.streamAudio(selectedPreview.id);
    playerController.previewAudio(
        youtubeExplode.audio.url.toString(),
        selectedPreview.title,
        selectedPreview.thumbnail['default']['url'],
        selectedPreview.id);
  }

  @action
  selectPreview(YT_API yt) {
    selectedPreview = yt;
    play();
  }

  @action
  callAPI() async {
    isSearching = true;
    if (queryController.text.trim().isNotEmpty) {
      try {
        List<YT_API> result = await ytApi.search(queryController.text.trim());
        ytResult = ObservableFuture.value(result);
      } catch (e) {
        print('Ocorreu um erro =/ $e');
      } finally {
        isSearching = false;
      }
    }
  }

  dispose() {
    playerController.assetsAudioPlayer.dispose();
    youtubeExplode.yt.close();
  }
}
