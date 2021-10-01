import 'package:camera/camera.dart';
import 'package:cattle_weight/Screens/Pages/HomePage.dart';
import 'package:cattle_weight/Screens/Pages/ViewPage.dart';
import 'package:cattle_weight/Screens/Widgets/PictureCameraTop.dart';
import 'package:cattle_weight/Screens/Widgets/blueAndCameraTop.dart';
import 'package:flutter/material.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

ConvertHex hex = new ConvertHex();

class BluePictureSaveNext extends StatefulWidget {
  final BluetoothDevice server;
  final CameraDescription camera;
  final String localFront;
  final String localBack;
  const BluePictureSaveNext(
      {Key? key,
      required this.server,
      required this.camera,
      required this.localFront,
      required this.localBack})
      : super(key: key);

  @override
  _BluePictureSaveNextState createState() => _BluePictureSaveNextState();
}

class _BluePictureSaveNextState extends State<BluePictureSaveNext> {
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
                          builder: (context) => BlueAndCameraTop(
                                server:widget.server,
                                camera: widget.camera,
                              )));
                    },
                    child: Text("ถ่ายภาพกระดูกสันหลังโค",
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
