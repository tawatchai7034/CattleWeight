import 'dart:io';
import 'package:camera/camera.dart';
import 'package:cattle_weight/Screens/Pages/GallorySolutions/AddProfile.dart';
import 'package:cattle_weight/Screens/Pages/GallorySolutions/PictureRef.dart';
import 'package:flutter/material.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:cattle_weight/model/MediaSource.dart';
import 'package:image_picker/image_picker.dart';

ConvertHex hex = new ConvertHex();

// reference https://youtu.be/BAgLOAGga2o

class GalloryButton extends StatefulWidget {
  final CameraDescription camera;
  const GalloryButton({Key? key, required this.camera}) : super(key: key);

  @override
  _GalloryButtonState createState() => _GalloryButtonState();
}

class _GalloryButtonState extends State<GalloryButton> {
  late File _image;
  String imageName = DateTime.now().toString() + ".jpg";
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: 240,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: new RaisedButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddProfile(widget.camera)));
            },
            child: Text("นำเข้าภาพ",
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

  final picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PictureRef(
              camera: widget.camera,
              imgPath: _image.path,
              fileName: imageName)));
    }
  }
}
