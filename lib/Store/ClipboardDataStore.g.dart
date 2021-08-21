// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ClipboardDataStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ClipboardDataStore on _ClipboardDataStore, Store {
  final _$clipboardDataListAtom =
      Atom(name: '_ClipboardDataStore.clipboardDataList');

  @override
  ObservableList<ClipboardItem> get clipboardDataList {
    _$clipboardDataListAtom.reportRead();
    return super.clipboardDataList;
  }

  @override
  set clipboardDataList(ObservableList<ClipboardItem> value) {
    _$clipboardDataListAtom.reportWrite(value, super.clipboardDataList, () {
      super.clipboardDataList = value;
    });
  }

  final _$serverListAtom = Atom(name: '_ClipboardDataStore.serverList');

  @override
  ObservableList<ServerItem> get serverList {
    _$serverListAtom.reportRead();
    return super.serverList;
  }

  @override
  set serverList(ObservableList<ServerItem> value) {
    _$serverListAtom.reportWrite(value, super.serverList, () {
      super.serverList = value;
    });
  }

  final _$_ClipboardDataStoreActionController =
      ActionController(name: '_ClipboardDataStore');

  @override
  void add(String text) {
    final _$actionInfo = _$_ClipboardDataStoreActionController.startAction(
        name: '_ClipboardDataStore.add');
    try {
      return super.add(text);
    } finally {
      _$_ClipboardDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addServer(ServerItem server) {
    final _$actionInfo = _$_ClipboardDataStoreActionController.startAction(
        name: '_ClipboardDataStore.addServer');
    try {
      return super.addServer(server);
    } finally {
      _$_ClipboardDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeServer(ServerItem server) {
    final _$actionInfo = _$_ClipboardDataStoreActionController.startAction(
        name: '_ClipboardDataStore.removeServer');
    try {
      return super.removeServer(server);
    } finally {
      _$_ClipboardDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateServer(ServerItem server, bool isEnable) {
    final _$actionInfo = _$_ClipboardDataStoreActionController.startAction(
        name: '_ClipboardDataStore.updateServer');
    try {
      return super.updateServer(server, isEnable);
    } finally {
      _$_ClipboardDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void remove() {
    final _$actionInfo = _$_ClipboardDataStoreActionController.startAction(
        name: '_ClipboardDataStore.remove');
    try {
      return super.remove();
    } finally {
      _$_ClipboardDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeByTimestamp(int timestamp) {
    final _$actionInfo = _$_ClipboardDataStoreActionController.startAction(
        name: '_ClipboardDataStore.removeByTimestamp');
    try {
      return super.removeByTimestamp(timestamp);
    } finally {
      _$_ClipboardDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
clipboardDataList: ${clipboardDataList},
serverList: ${serverList}
    ''';
  }
}
