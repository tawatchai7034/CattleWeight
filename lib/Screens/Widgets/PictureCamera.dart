import 'dart:io';
import 'package:cattle_weight/Screens/Pages/SetHarthWidth.dart';
import 'package:flutter/material.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:cattle_weight/model/MediaSource.dart';
import 'package:image_picker/image_picker.dart';

ConvertHex hex = new ConvertHex();

// reference 
// camera :
//  - https://youtu.be/BAgLOAGga2o
//  - https://flutter.dev/docs/cookbook/plugins/picture-using-camera
// กรอบภาพช่วยจัดตำแหน่งโค
//  - https://alex.domenici.net/archive/rotate-and-flip-an-image-in-flutter-with-or-without-animations
// วิธีใช้ stack widget
//  - https://api.flutter.dev/flutter/widgets/Stack-class.html

class CameraButton extends StatefulWidget {
  const CameraButton({Key? key}) : super(key: key);

  @override
  _CameraButtonState createState() => _CameraButtonState();
}

class _CameraButtonState extends State<CameraButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: 240,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: new RaisedButton(
            onPressed: () {
              pickCameraMedia(context);
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => FirstAddProfile()));
            },
            child: Text("ถ่ายภาพ",
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
        ));
  }

  Future pickCameraMedia(BuildContext context) async {
     final  source = ModalRoute.of(context)!.settings.arguments as MediaSource;

    final getMedia = source == MediaSource.image
        ? ImagePicker().getImage
        : ImagePicker().getVideo;

    final media = await getMedia(source: ImageSource.camera);
    final file = File(media!.path);

    Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SetHarthWidth(file)));
  }
}
