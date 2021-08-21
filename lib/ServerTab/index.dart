import 'dart:developer';

import 'package:clipboardsync/Store/ClipboardDataStore.dart';
import 'package:clipboardsync/Store/ServerItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class Server {
  Server({required this.ip, required this.connected});

  String ip;
  bool connected;
}

class ServerTab extends StatefulWidget {
  const ServerTab({Key? key}) : super(key: key);

  @override
  _ServerTabState createState() => _ServerTabState();
}

class _ServerTabState extends State<ServerTab> {
  ClipboardDataStore? clipboardDataStore;
  late TextEditingController _ipController;
  late TextEditingController _portController;

  @override
  void initState() {
    super.initState();
    _ipController = TextEditingController();
    _portController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    clipboardDataStore = Provider.of<ClipboardDataStore>(context);

    const Key centerKey = ValueKey<String>('bottom-sliver-list');
    return CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          largeTitle: Text("Server"),
          trailing: GestureDetector(
              child: Icon(Ionicons.add),
              onTap: () {
                _showDialog(context);
              }),
        ),
        Observer(
            builder: (_) => SliverList(
                key: centerKey,
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      var server = clipboardDataStore!.serverList.elementAt(index);
                  return Slidable(
                    actionPane: SlidableScrollActionPane(),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${server.ip}:${server.port}"),
                          CupertinoSwitch(
                              value: server.isEnable,
                              onChanged: (value) {
                                log("update server ${server.ip}:${server.port} ${value} ${index}");
                                clipboardDataStore!.updateServer(server, value);
                              })
                        ],
                      ),
                    ),
                    secondaryActions: [
                      IconSlideAction(
                        caption: "Delete",
                        color: Color.fromRGBO(227, 99, 87, 1),
                        icon: Ionicons.list,
                        onTap: () {
                          log("Delete");
                          clipboardDataStore!.removeServer(server);
                        },
                      )
                    ],
                  );
                }, childCount: clipboardDataStore!.serverList.length)))
      ],
    );
  }

  void _showDialog(widgetContext) {
    showCupertinoDialog(
        context: widgetContext,
        builder: (context) {
          return GestureDetector(
            child: CupertinoAlertDialog(
              title: Text("Add Server"),
              content: Container(
                margin: EdgeInsets.only(top: 10),
                height: 88,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 0,
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              width: 30,
                              child: Text("Ip:", textAlign: TextAlign.right),
                            )),
                        Expanded(
                            child: CupertinoTextField(
                          controller: _ipController,
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 0,
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              width: 30,
                              child: Text(
                                "Port:",
                                textAlign: TextAlign.right,
                              ),
                            )),
                        Expanded(
                            child: CupertinoTextField(
                          controller: _portController,
                        ))
                      ],
                    )
                  ],
                ),
              ),
              actions: [
                CupertinoDialogAction(
                  child: Text('Cancel'),
                  isDestructiveAction: true,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                CupertinoDialogAction(
                  child: Text('Add'),
                  isDestructiveAction: false,
                  onPressed: () {
                    clipboardDataStore!.addServer(ServerItem(
                        ip: _ipController.text,
                        port: int.parse(_portController.text),
                        isEnable: false));
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          );
        });
  }
}
