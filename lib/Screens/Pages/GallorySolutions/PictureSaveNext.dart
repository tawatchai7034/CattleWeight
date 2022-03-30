import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cattle_weight/Screens/Pages/GallorySolutions/PictureTW2.dart';
import 'package:cattle_weight/Screens/Pages/ViewPage.dart';
import 'package:cattle_weight/Screens/Widgets/MainButton.dart';
import 'package:cattle_weight/Screens/Widgets/PictureCameraTop.dart';
import 'package:flutter/material.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:image_picker/image_picker.dart';

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
  late File _image;
  String imageName = DateTime.now().toString() + ".jpg";
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
                                  widget.camera)),
                          (route) => false);
                    },
                    title: "คำนวณน้ำหนัก"),
                SizedBox(
                  height: 10,
                ),
                MainButton(
                    onSelected: () {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              // backgroundColor: Colors.black,
                              title: Text("กรุณาเลือกรูปด้านกระดูกสันหลังโค",
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold)),
                              content: Image.asset(
                                  "assets/images/TopLeftNavigation2.png"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'ยกเลิก'),
                                  child: const Text('ยกเลิก',
                                      style: TextStyle(fontSize: 24)),
                                ),
                                TextButton(
                                  onPressed: () => _openImagePicker(),
                                  child: const Text('ตกลง',
                                      style: TextStyle(fontSize: 24)),
                                ),
                              ],
                            );
                          });
                    },
                    title: "ภาพกระดูกสันหลังโค"),
              ]),
        ));
  }

  final picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PictureTW2(
              camera: widget.camera,
              imgPath: _image.path,
              fileName: imageName)));
    }
  }
}
