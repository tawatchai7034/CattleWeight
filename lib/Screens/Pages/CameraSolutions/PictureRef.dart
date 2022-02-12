import 'dart:ffi';
import 'package:camera/camera.dart';
import 'package:cattle_weight/Screens/Pages/CameraSolutions/PictureHG.dart';
import 'package:cattle_weight/Screens/Widgets/LineAndPosition.dart';
import 'package:cattle_weight/Screens/Widgets/MainButton.dart';
import 'package:cattle_weight/Screens/Widgets/preview.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:cattle_weight/Screens/Pages/CameraSolutions/Position.dart';
import 'package:cattle_weight/Screens/Pages/CameraSolutions/PaintLine.dart';
import 'package:cattle_weight/Screens/Pages/CameraSolutions/PaintPoint.dart';
import 'dart:math';
import 'package:flutter/material.dart';

ConvertHex hex = new ConvertHex();

Positions pos = new Positions();

class PictureRef extends StatefulWidget {
  final bool blueConnection;
  final CameraDescription camera;
  final String imgPath;
  final String fileName;
  const PictureRef(
      {Key? key,
      required this.blueConnection,
      required this.camera,
      required this.imgPath,
      required this.fileName})
      : super(key: key);

  @override
  _PictureRefState createState() => _PictureRefState();
}

class _PictureRefState extends State<PictureRef> {
  bool showState = false;

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
            imgPath: widget.imgPath,
            fileName: widget.fileName,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              MainButton(
                  onSelected: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PictureHG(
                            blueConnection: widget.blueConnection,
                            camera: widget.camera,
                            imgPath: widget.imgPath,
                            fileName: widget.fileName)));
                  },
                  title: "บันทึก"),
            ]),
          ),
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
