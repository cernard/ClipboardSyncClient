import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:clipboardsync/Store/ClipboardDataStore.dart';
import 'package:clipboardsync/ClipboardTab/index.dart';
import 'package:clipboardsync/ServerTab/index.dart';
import 'package:clipboardsync/Store/ServerItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => ClipboardDataStore(),
        child: CupertinoApp(
          title: 'Clipboard Sync Client',
          home: MyHomePage(title: 'Clipboard Sync Client'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ClipboardDataStore? clipboardDataStore;
  Socket? socket;

  @override
  void initState() {
    super.initState();
    startClipboardMonitor();
    connectToServer();
  }

// TODO 当Server列表变动时，自动修改socket连接服务器
  connectToServer() async {
    socket = await Socket.connect('127.0.0.1', 8888);
    listenToServer();
    // if (clipboardDataStore != null && clipboardDataStore.serverList.length > 0) {
    //   ServerItem server = clipboardDataStore.serverList.firstWhere((element) => element.isEnable);
    //   log("Connect to server ${server.ip}:${server.port}");
    //   socket = await Socket.connect(server.ip, server.port);
    //   listenToServer();
    // }
    // autorun((_) async {
    //   log("autorun");
    //   if (clipboardDataStore != null &&
    //       clipboardDataStore!.serverList.length > 0) {
    //     ServerItem server = clipboardDataStore!.serverList
    //         .firstWhere((element) => element.isEnable);
    //     log("Connect to server ${server.ip}:${server.port}");
    //     socket = await Socket.connect(server.ip, server.port);
    //     listenToServer();
    //   }
    // });
    // autorun((p0) => {
    //   log("autorun ${clipboardDataStore!.clipboardDataList.length}")
    // });
  }

  listenToServer() async {
    log("Listen to server...");
    socket!.listen((Uint8List data) async {
      // await Future.delayed(Duration(seconds: 1));
      final message = String.fromCharCodes(data);
      Clipboard.setData(ClipboardData(text: message));
      log("[FromeServer] $message");
    });
  }

  broadcastToAllDevices(String data) {
    if (socket != null) {
      socket!.write(data);
      socket!.flush();
    }
  }

  startClipboardMonitor() async {
    await Clipboard.getData(Clipboard.kTextPlain).then((value) => {
          if (value != null && value.text != null)
            getDataFromClipboard(value.text ?? "")
        });
    await Future.delayed(Duration(milliseconds: 50));
    startClipboardMonitor();
  }

  bool checkHas(String data) {
    var lastData = "";
    if (clipboardDataStore!.clipboardDataList.isNotEmpty) {
      lastData = clipboardDataStore!.clipboardDataList.first.data;
    }
    if (lastData == data) {
      Clipboard.setData(ClipboardData(text: lastData));
      return true;
    } else {
      return false;
    }
  }

  // 获取剪切板数据，如果剪切板数据和最新的一条相同则将剪切板数据设置成从本App读取，防止ios不停出现用户提示
  // 否则通过socket广播给所有网内设备
  getDataFromClipboard(String data) {
    if (!checkHas(data)) {
      clipboardDataStore!.add(data);
      broadcastToAllDevices(data);
      checkHas(data);
      log("===== START =====");
      clipboardDataStore!.clipboardDataList.forEach((e) {
        log(e.data);
      });
      log("=====  END  =====");
    }
  }

  @override
  Widget build(BuildContext context) {
    clipboardDataStore = Provider.of<ClipboardDataStore>(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.list_bullet),
            label: "Clipboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.cloud),
            label: "Server",
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: ClipboardTab(),
              );
            });
          case 1:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: ServerTab(),
              );
            });
        }
        return CupertinoTabView(builder: (context) {
          return CupertinoPageScaffold(
            child: Container(
                child: Text(clipboardDataStore!.serverList.length.toString())),
          );
        });
      },
    );
  }
}
