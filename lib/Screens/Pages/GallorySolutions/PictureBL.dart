import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cattle_weight/Screens/Pages/GallorySolutions/PictureRef2.dart';
import 'package:cattle_weight/Screens/Pages/GallorySolutions/PictureTW.dart';
import 'package:cattle_weight/Screens/Widgets/PictureCamera2.dart';
import 'package:cattle_weight/Screens/Widgets/preview.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

ConvertHex hex = new ConvertHex();

class PictureBL extends StatefulWidget {
  final CameraDescription camera;
  final String imgPath;
  final String fileName;
  const PictureBL(
      {Key? key,
      required this.camera,
      required this.imgPath,
      required this.fileName})
      : super(key: key);

  @override
  _PictureBLState createState() => _PictureBLState();
}

class _PictureBLState extends State<PictureBL> {
  late File _image;
  String imageName = DateTime.now().toString() + ".jpg";
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
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          // backgroundColor: Colors.black,
                          title: Text("กรุณาเลือกรูปด้านหลังโค",
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold)),
                          content: Image.asset(
                              "assets/images/RearNavigation2.png"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'ยกเลิก'),
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
                title: Text("กรุณาระบุความยาวลำตัวโค",
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                content: Image.asset("assets/images/SideLeftNavigation4.png"),
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

  final picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PictureRef2(
              camera: widget.camera,
              imgPath: _image.path,
              fileName: imageName)));
    }
  }
}
