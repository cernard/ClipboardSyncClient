import 'dart:io';
import 'package:clipboardsync/Store/ClipboardItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Card extends StatefulWidget {
  const Card({Key? key, required this.content}) : super(key: key);
  final ClipboardItem content;

  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<Card> {
  Color listCellNormalBgColor = Color.fromRGBO(248, 249, 253, 1);
  Color listCellNormalFontColor = Color.fromRGBO(26, 26, 26, 1.0);
  Color listCellTapedBgColor = Color.fromRGBO(70, 70, 70, 1.0);
  Color listCellTapedFontColor = Color.fromRGBO(248, 249, 253, 1);
  bool isTaped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: isTaped ? listCellTapedBgColor : listCellNormalBgColor,
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(20),
        height: 66.66,
        child: Row(
          children: [
            Expanded(
              flex: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(147, 220, 230, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.only(right: 20),
                width: 6.66,
              ),
            ),
            Expanded(
                child: Text(
              widget.content.data,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  color: isTaped
                      ? listCellTapedFontColor
                      : listCellNormalFontColor),
            ))
          ],
        ),
      ),
      onTapDown: (e) {
        setState(() {
          isTaped = true;
        });
      },
      onTapUp: (e) {
        setState(() {
          isTaped = false;
        });
      },
      onTap: () {
        Clipboard.setData(ClipboardData(text: widget.content.data));
        if (Platform.isIOS || Platform.isAndroid) {
          Fluttertoast.showToast(msg: "Content has been set to clipboard", backgroundColor: Color.fromRGBO(0, 0, 0, 0.5));
        }
      },
      onTapCancel: () {
        setState(() {
          isTaped = false;
        });
      },
      onLongPress: () {
        _showDialog(context);
      },
    );
  }

  void _showDialog(widgetContext) {
    showCupertinoDialog(
        context: widgetContext,
        builder: (context) {
          return GestureDetector(
            child: CupertinoAlertDialog(
              title: Text("Text"),
              content: Text(
                widget.content.data,
                textAlign: TextAlign.left,
              ),
            ),
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          );
        });
  }
}
