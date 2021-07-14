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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Bodr Lenght page [3/3]",
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
                onPressed: () =>_openImagePicker(),
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
