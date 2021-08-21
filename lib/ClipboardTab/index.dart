import 'package:clipboardsync/ClipboardTab/card.dart';
import 'package:clipboardsync/Store/ClipboardDataStore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ClipboardTab extends StatefulWidget {
  const ClipboardTab({Key? key}) : super(key: key);

  @override
  _ClipboardTabState createState() => _ClipboardTabState();
}

class _ClipboardTabState extends State<ClipboardTab> {
  ClipboardDataStore? clipboardDataStore;

  @override
  Widget build(BuildContext context) {
    clipboardDataStore = Provider.of<ClipboardDataStore>(context);
    const Key centerKey = ValueKey<String>('bottom-sliver-list');
    return CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          largeTitle: Text("Clipboard"),
        ),
        Observer(
          builder: (_) => SliverList(
              key: centerKey,
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return Card(
                  content: clipboardDataStore!.clipboardDataList.elementAt(index),
                );
              }, childCount: clipboardDataStore!.clipboardDataList.length)),
        )
      ],
    );
  }
}
