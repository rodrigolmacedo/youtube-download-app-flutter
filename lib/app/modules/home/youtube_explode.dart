import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as y;
import 'package:path/path.dart' as path;

part 'youtube_explode.g.dart';

class YoutubeExplode = _YoutubeExplodeBase with _$YoutubeExplode;

abstract class _YoutubeExplodeBase with Store {
  _YoutubeExplodeBase() {
    criarPastaPadrao();
  }
  final y.YoutubeExplode yt = y.YoutubeExplode();
  final FlutterFFmpeg _flutterFFmpeg = new FlutterFFmpeg();

  String pathDownload;

  void criarPastaPadrao() async {
    var dir = await DownloadsPathProvider.downloadsDirectory;
    var diretorioPadraoDownloads = path.join(dir.uri.path, "youtube_download");
    final Directory diretorio = Directory(diretorioPadraoDownloads);
    if (!await diretorio.exists()) {
      diretorio.create();
    }

    pathDownload = diretorio.path;
  }

  void cancelarConversao() {
    if (conversao == false && progress == 1.0) _flutterFFmpeg.cancel();
  }

  void cancelarDownload() async {
    if (_streamSubscription != null) {
      _streamSubscription.cancel();
      downloadingVideo = '';

      var filePath = path.join(pathDownload, 'audio');
      var file = File(filePath);

      if (file.existsSync()) {
        file.deleteSync();
      }
    }
  }

  StreamSubscription<List<int>> _streamSubscription;

  @observable
  y.AudioOnlyStreamInfo audio;

  @observable
  double progress = 0;

  @action
  void setUpdate(double valor) => progress = valor;

  @observable
  bool conversao = false;

  @action
  void finishConversao() => conversao = true;

  @observable
  String downloadingVideo;

  Duration durationAudio;

  @action
  Future<void> streamAudio(String videoId) async {
    y.VideoId id = y.VideoId(videoId);
    y.Video video = await yt.videos.get(id);
    y.StreamManifest manifest = await yt.videos.streamsClient.getManifest(id);
    audio = manifest.audioOnly.last;
    durationAudio = video.duration;
  }

  @action
  Future<void> downloadVideoAudio(
    String videoId,
    String title,
  ) async {
    if (await Permission.storage.isDenied) {
      openAppSettings();
    }

    await Permission.storage.request();

    progress = 0;
    conversao = false;

    downloadingVideo = videoId;
    y.VideoId id = y.VideoId(videoId);
    y.StreamManifest manifest = await yt.videos.streamsClient.getManifest(id);
    var audio = manifest.audioOnly.last;

    var fileName = '${title.trim()}'
        //.replaceAll(r'[^0-9a-zA-Z:,]+', '');
        .replaceAll(new RegExp(r'(?:_|[^\w\s])+'), '')
        .replaceAll(' ', '_');

    print("filename : $fileName");

    var filePath = path.join(pathDownload, 'audio');
    var file = File(filePath);

    if (file.existsSync()) {
      file.deleteSync();
    }
    filePath = path.join(pathDownload, 'audio');
    file = File(filePath);

    var fileStream = file.openWrite(mode: FileMode.writeOnlyAppend);
    var len = audio.size.totalBytes;

    var count = 0;

    _streamSubscription = yt.videos.streamsClient.get(audio).listen((data) {
      count += data.length;
      // Calculate the current progress.
      print("total bytes: $len");
      print("total count: $count");

      var progressAtual = ((count / len) * 100).ceil();
      print("total count: $progressAtual");
      // Update the progressbar.
      //progressBar.update(progress);
      setUpdate(progressAtual.toDouble() * 0.01);
      print(progressAtual.toDouble() * 0.01);
      // Write to file.
      fileStream.add(data);
    });
    _streamSubscription.onDone(() async {
      String audioFileOriginal = file.path;
      var filePath2 = path.join(pathDownload, '$fileName.mp3');
      var file2 = File(filePath2);
      String audioOutputFile = file2.path;

      String mp3Command =
          "-hide_banner -y -i $audioFileOriginal -c:a libmp3lame -qscale:a 2 $audioOutputFile";

      print("mp3_command : $mp3Command");

      await fileStream.flush();
      await fileStream.close();

      _flutterFFmpeg.execute(mp3Command).then((value) {
        if (file.existsSync()) {
          file.deleteSync();
        }
        //renomeando
        file2.renameSync(path.join(pathDownload, '${title.trim()}.mp3'));

        downloadingVideo = '';
        print('finalizou');

        finishConversao();
      });
    });
  }
}
