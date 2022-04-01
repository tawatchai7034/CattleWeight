import 'package:camera/camera.dart';
import 'package:cattle_weight/Screens/Pages/ViewPage.dart';
import 'package:cattle_weight/Screens/Widgets/MainButton.dart';
import 'package:cattle_weight/Screens/Widgets/PictureCameraTop.dart';
import 'package:flutter/material.dart';
import 'package:cattle_weight/convetHex.dart';

ConvertHex hex = new ConvertHex();

class PictureSaveNext extends StatefulWidget {
  // final CameraDescription camera;
  final String localFront;
  final String localBack;
  const PictureSaveNext(
      {Key? key,

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
                MainButton(
                    onSelected: () {
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
                                  )),
                          (route) => false);
                    },
                    title: "คำนวณน้ำหนัก"),
                SizedBox(
                  height: 10,
                ),
                MainButton(
                    onSelected: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => TakePictureTop(
                     
                      //           localFront: widget.localFront,
                      //           localBack: widget.localBack,
                      //         )));

                              // change new camera
                    },
                    title: "ถ่ายภาพกระดูกสันหลังโค"),
              ]),
        ));
  }
}
