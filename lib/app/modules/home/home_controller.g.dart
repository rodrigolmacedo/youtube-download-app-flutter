// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$selectedPreviewAtom =
      Atom(name: '_HomeControllerBase.selectedPreview');

  @override
  YT_API get selectedPreview {
    _$selectedPreviewAtom.reportRead();
    return super.selectedPreview;
  }

  @override
  set selectedPreview(YT_API value) {
    _$selectedPreviewAtom.reportWrite(value, super.selectedPreview, () {
      super.selectedPreview = value;
    });
  }

  final _$isSearchingAtom = Atom(name: '_HomeControllerBase.isSearching');

  @override
  bool get isSearching {
    _$isSearchingAtom.reportRead();
    return super.isSearching;
  }

  @override
  set isSearching(bool value) {
    _$isSearchingAtom.reportWrite(value, super.isSearching, () {
      super.isSearching = value;
    });
  }

  final _$ytResultAtom = Atom(name: '_HomeControllerBase.ytResult');

  @override
  ObservableFuture<List<YT_API>> get ytResult {
    _$ytResultAtom.reportRead();
    return super.ytResult;
  }

  @override
  set ytResult(ObservableFuture<List<YT_API>> value) {
    _$ytResultAtom.reportWrite(value, super.ytResult, () {
      super.ytResult = value;
    });
  }

  final _$callAPIAsyncAction = AsyncAction('_HomeControllerBase.callAPI');

  @override
  Future callAPI() {
    return _$callAPIAsyncAction.run(() => super.callAPI());
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  dynamic selectPreview(YT_API yt) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.selectPreview');
    try {
      return super.selectPreview(yt);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedPreview: ${selectedPreview},
isSearching: ${isSearching},
ytResult: ${ytResult}
    ''';
  }
}
