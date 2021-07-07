// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'youtube_explode.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$YoutubeExplode on _YoutubeExplodeBase, Store {
  final _$audioAtom = Atom(name: '_YoutubeExplodeBase.audio');

  @override
  y.AudioOnlyStreamInfo get audio {
    _$audioAtom.reportRead();
    return super.audio;
  }

  @override
  set audio(y.AudioOnlyStreamInfo value) {
    _$audioAtom.reportWrite(value, super.audio, () {
      super.audio = value;
    });
  }

  final _$progressAtom = Atom(name: '_YoutubeExplodeBase.progress');

  @override
  double get progress {
    _$progressAtom.reportRead();
    return super.progress;
  }

  @override
  set progress(double value) {
    _$progressAtom.reportWrite(value, super.progress, () {
      super.progress = value;
    });
  }

  final _$conversaoAtom = Atom(name: '_YoutubeExplodeBase.conversao');

  @override
  bool get conversao {
    _$conversaoAtom.reportRead();
    return super.conversao;
  }

  @override
  set conversao(bool value) {
    _$conversaoAtom.reportWrite(value, super.conversao, () {
      super.conversao = value;
    });
  }

  final _$downloadingVideoAtom =
      Atom(name: '_YoutubeExplodeBase.downloadingVideo');

  @override
  String get downloadingVideo {
    _$downloadingVideoAtom.reportRead();
    return super.downloadingVideo;
  }

  @override
  set downloadingVideo(String value) {
    _$downloadingVideoAtom.reportWrite(value, super.downloadingVideo, () {
      super.downloadingVideo = value;
    });
  }

  final _$streamAudioAsyncAction =
      AsyncAction('_YoutubeExplodeBase.streamAudio');

  @override
  Future<void> streamAudio(String videoId) {
    return _$streamAudioAsyncAction.run(() => super.streamAudio(videoId));
  }

  final _$downloadVideoAudioAsyncAction =
      AsyncAction('_YoutubeExplodeBase.downloadVideoAudio');

  @override
  Future<void> downloadVideoAudio(String videoId, String title) {
    return _$downloadVideoAudioAsyncAction
        .run(() => super.downloadVideoAudio(videoId, title));
  }

  final _$_YoutubeExplodeBaseActionController =
      ActionController(name: '_YoutubeExplodeBase');

  @override
  void setUpdate(double valor) {
    final _$actionInfo = _$_YoutubeExplodeBaseActionController.startAction(
        name: '_YoutubeExplodeBase.setUpdate');
    try {
      return super.setUpdate(valor);
    } finally {
      _$_YoutubeExplodeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void finishConversao() {
    final _$actionInfo = _$_YoutubeExplodeBaseActionController.startAction(
        name: '_YoutubeExplodeBase.finishConversao');
    try {
      return super.finishConversao();
    } finally {
      _$_YoutubeExplodeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
audio: ${audio},
progress: ${progress},
conversao: ${conversao},
downloadingVideo: ${downloadingVideo}
    ''';
  }
}
