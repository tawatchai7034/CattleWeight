import 'package:camera/camera.dart';
import 'package:cattle_weight/Screens/Pages/HomePage.dart';
import 'package:cattle_weight/Screens/Pages/ViewPage.dart';
import 'package:cattle_weight/Screens/Widgets/PictureCamera3.dart';
import 'package:flutter/material.dart';
import 'package:cattle_weight/convetHex.dart';

ConvertHex hex = new ConvertHex();

class PictureSaveNext extends StatefulWidget {
  final CameraDescription camera;
  final String localFront;
  final String localBack;
  const PictureSaveNext(
      {Key? key,
      required this.camera,
      required this.localFront,
      required this.localBack})
      : super(key: key);

  @override
  _PictureSaveNextState createState() => _PictureSaveNextState();
}

class _PictureSaveNextState extends State<PictureSaveNext> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Save page",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Color(hex.hexColor("#007BA4")),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  child: Center(
                      child: Text(
                    "Heart Girth : 2XX CM.",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                  color: Colors.blue,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 120,
                  width: double.infinity,
                  child: Center(
                      child: Text(
                    "Boar Lenght : 2XX CM.",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                  color: Colors.green,
                ),
                SizedBox(
                  height: 180,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                      // Navigator.pushAndRemoveUntil จะไม่สามารถย้อนกลับมายัง Screen เดิมได้
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CattleData(
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
                    child: Text("คำนวณน้ำหนัก",
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
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TakePictureScreen3(
                                camera: widget.camera,
                                localFront: widget.localFront,
                                localBack: widget.localBack,
                              )));
                    },
                    child: Text("ถ่ายภาพถัดไป",
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
        ));
  }
}
