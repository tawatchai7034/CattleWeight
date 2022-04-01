import 'package:camera/camera.dart';
import 'package:cattle_weight/Screens/Pages/CameraSolutions/PictureHG.dart';
import 'package:cattle_weight/Screens/Pages/CameraSolutions/PictureTW.dart';
import 'package:cattle_weight/Screens/Widgets/LineAndPosition.dart';
import 'package:cattle_weight/Screens/Widgets/MainButton.dart';
import 'package:cattle_weight/Screens/Widgets/preview.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:flutter/material.dart';

import 'dart:ffi';
import 'dart:math';

ConvertHex hex = new ConvertHex();

class PictureRef2 extends StatefulWidget {
  // final CameraDescription camera;
  final String imgPath;
  final String fileName;
  const PictureRef2(
      {Key? key,

      required this.imgPath,
      required this.fileName})
      : super(key: key);

  @override
  _PictureRef2State createState() => _PictureRef2State();
}

class _PictureRef2State extends State<PictureRef2> {
  bool showState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("[1/2] กรุณาระบุจุดอ้างอิง",
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
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                MainButton(
                    onSelected: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PictureTW(
                              
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
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold)),
                    content: Image.asset("assets/images/RearNavigation4.png"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          setState(() => showState = !showState);
                        },
                        // => Navigator.pop(context, 'ตกลง'),
                        child:
                            const Text('ตกลง', style: TextStyle(fontSize: 24)),
                      ),
                    ],
                  ),
          ],
        ));
  }
}
