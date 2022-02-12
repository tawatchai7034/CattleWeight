import 'package:camera/camera.dart';
import 'package:cattle_weight/Screens/Widgets/LineAndPosition.dart';
import 'package:cattle_weight/Screens/Widgets/MainButton.dart';
import 'package:cattle_weight/Screens/Widgets/PictureCameraRear.dart';
import 'package:cattle_weight/Screens/Widgets/preview.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:flutter/material.dart';

import 'dart:ffi';
import 'dart:math';

ConvertHex hex = new ConvertHex();

class PictureBL extends StatefulWidget {
  final bool blueConnection;
  final CameraDescription camera;
  final String imgPath;
  final String fileName;
  const PictureBL(
      {Key? key,
      required this.blueConnection,
      required this.camera,
      required this.imgPath,
      required this.fileName})
      : super(key: key);

  @override
  _PictureBLState createState() => _PictureBLState();
}

class _PictureBLState extends State<PictureBL> {
  bool showState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("[3/3] กรุณาระบุความยาวลำตัวโค",
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
                          builder: (context) => TakePictureRear(
                              blueConnection: widget.blueConnection,
                              camera: widget.camera,
                              localFront: "assets/images/RearNavigation.png",
                              localBack: "assets/images/RearNavigation.png")));
                    },
                    title: "บันทึก"),
              ]),
            ),
            showState
                ? Container()
                : AlertDialog(
                    // backgroundColor: Colors.black,
                    title: Text("กรุณาระบุความยาวลำตัวโค",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold)),
                    content:
                        Image.asset("assets/images/SideLeftNavigation4.png"),
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
