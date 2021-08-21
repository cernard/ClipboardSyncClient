
import 'dart:developer';

import 'package:clipboardsync/Store/ClipboardItem.dart';
import 'package:clipboardsync/Store/ServerItem.dart';
import 'package:mobx/mobx.dart';

part 'ClipboardDataStore.g.dart';

class ClipboardDataStore = _ClipboardDataStore with _$ClipboardDataStore;

abstract class _ClipboardDataStore with Store {
  @observable
  ObservableList<ClipboardItem> clipboardDataList = new ObservableList();

  @observable
  ObservableList<ServerItem> serverList = new ObservableList<ServerItem>();

  @action
  void add(String text) {
    clipboardDataList.insert(
        0,
        ClipboardItem(
            data: text, timestamp: DateTime.now().millisecondsSinceEpoch));
  }

  @action
  void addServer(ServerItem server) {
    if (serverList.indexWhere((element) => element.ip == server.ip && element.port == server.port) >= 0)
    {
      log("Duplicative Server ${server.ip}:${server.port}");
      return;
    } 
    serverList.add(server);

  }

  @action
  void removeServer(ServerItem server) {
    serverList.remove(server);
  }

  @action
  void updateServer(ServerItem server, bool isEnable) {
    List<ServerItem> serverListCopy = []..addAll(serverList);
    for (var i = 0; i < serverListCopy.length; i++) {
      if (serverListCopy[i].ip == server.ip && serverListCopy[i].port == server.port) {
          serverListCopy[i].isEnable = isEnable;
      } else {
        if (isEnable) {
          serverListCopy[i].isEnable = !isEnable;
        }
      }
    }
    serverList.clear();
    serverList.addAll(serverListCopy);
  }

  @action
  void remove() {
    clipboardDataList.removeAt(0);
  }

  @action
  void removeByTimestamp(int timestamp) {
    clipboardDataList.removeWhere((element) => element.timestamp == timestamp);
  }
}
