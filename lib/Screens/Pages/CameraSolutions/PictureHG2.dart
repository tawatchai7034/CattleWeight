import 'package:camera/camera.dart';
import 'package:cattle_weight/Screens/Pages/HomePage.dart';
import 'package:cattle_weight/Screens/Pages/ViewPage.dart';

import 'package:cattle_weight/Screens/Widgets/preview.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:flutter/material.dart';

ConvertHex hex = new ConvertHex();

class PictureHG2 extends StatefulWidget {
  final CameraDescription camera;
  final String imgPath;
  final String fileName;
  const PictureHG2(
      {Key? key,
      required this.camera,
      required this.imgPath,
      required this.fileName})
      : super(key: key);

  @override
  _PictureHG2State createState() => _PictureHG2State();
}

class _PictureHG2State extends State<PictureHG2> {
  bool showState = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Heart Girth page [2/2]",
              style: TextStyle(
                  fontSize: 24,
                  color: Color(hex.hexColor("ffffff")),
                  fontWeight: FontWeight.bold)),
          backgroundColor: Color(hex.hexColor("#007BA4"))),
      body: Stack(children: [
        PreviewScreen(
          imgPath: widget.imgPath,
          fileName: widget.fileName,
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              height: 50,
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  // Navigator.pushAndRemoveUntil จะไม่สามารถย้อนกลับมายัง Screen เดิมได้
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => CattleData(
                                  "01",
                                  "cattle01",
                                  "male",
                                  "Brahman",
                                  "assets/images/cattle01.jpg",
                                  "assets/images/cattle01.jpg",
                                  "assets/images/cattle01.jpg",
                                  255,
                                  255,
                                  255,
                                  widget.camera)),
                      (route) => false);
                },
                child: Text("บันทึก",
                    style: TextStyle(
                        fontSize: 24,
                        color: Color(hex.hexColor("ffffff")),
                        fontWeight: FontWeight.bold)),
                color: Color(hex.hexColor("#47B5BE")),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ]),
        ),
        showState
            ? Container()
            : AlertDialog(
                // backgroundColor: Colors.black,
                title: Text("กรุณาระบุความยาวรอบอกโค",
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                content: Image.asset("assets/images/TopLeftNavigation4.png"),
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
      ]),
    );
  }
}
