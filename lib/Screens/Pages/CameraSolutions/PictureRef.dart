import 'dart:ffi';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:cattle_weight/Screens/Pages/CameraSolutions/PictureHG.dart';
import 'package:cattle_weight/Screens/Widgets/Alerts.dart';
import 'package:cattle_weight/Screens/Widgets/LineAndPosition.dart';
import 'package:cattle_weight/Screens/Widgets/MainButton.dart';
import 'package:cattle_weight/Screens/Widgets/position.dart';
import 'package:cattle_weight/Screens/Widgets/preview.dart';
import 'package:cattle_weight/convetHex.dart';

import 'dart:math';
import 'package:flutter/material.dart';

ConvertHex hex = new ConvertHex();
Positions pos = new Positions();

class PictureRef extends StatefulWidget {
  final File imageFile;
  final String fileName;
  const PictureRef({Key? key, required this.imageFile, required this.fileName})
      : super(key: key);

  @override
  _PictureRefState createState() => _PictureRefState();
}

class _PictureRefState extends State<PictureRef> {
  bool showState = false;
  TextEditingController _textFieldController = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'ระบุความยาวของจุดอ้างอิง',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration:
                  InputDecoration(hintText: "กรุณาระบุความยาวของจุดอ้างอิง"),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('ยกเลิก'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('บันทึก'),
                onPressed: () {
                  setState(() {
                    codeDialog = valueText;
                    print('Input = ' + codeDialog);
                    print('Pixel Distance = ${pos.getPixelDistance()}');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PictureHG(
                            imgPath: widget.imageFile.path,
                            fileName: widget.fileName)));
                  });
                },
              ),
            ],
          );
        });
  }

  late String codeDialog;
  late String valueText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("[1/3] กรุณาระบุจุดอ้างอิง",
              style: TextStyle(
                  fontSize: 24,
                  color: Color(hex.hexColor("ffffff")),
                  fontWeight: FontWeight.bold)),
          backgroundColor: Color(hex.hexColor("#007BA4"))),
      body: new Stack(
        children: [
          LineAndPosition(
            imgPath: widget.imageFile.path,
            fileName: widget.fileName,
            onSelected: () {
              _displayTextInputDialog(context);
            },
          ),
          // Padding(
          //   padding: EdgeInsets.all(20),
          //   child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          //     MainButton(
          //         onSelected: () {
          //           _displayTextInputDialog(
          //             context,
          //           );
          //         },
          //         title: "บันทึก"),
          //   ]),
          // ),
          showState
              ? Container()
              : AlertDialog(
                  // backgroundColor: Colors.black,
                  title: Text("กรุณาระบุจุดอ้างอิง",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  content: Image.asset("assets/images/SideLeftNavigation5.png"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        setState(() => showState = !showState);
                      },
                      // => Navigator.pop(context, 'ตกลง'),
                      child: const Text('ตกลง', style: TextStyle(fontSize: 24)),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
