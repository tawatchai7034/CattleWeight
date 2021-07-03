import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:cattle_weight/model/MediaSource.dart';
import 'package:image_picker/image_picker.dart';

ConvertHex hex = new ConvertHex();

// reference https://youtu.be/BAgLOAGga2o

class GalloryButton extends StatefulWidget {
  const GalloryButton({Key? key}) : super(key: key);

  @override
  _GalloryButtonState createState() => _GalloryButtonState();
}

class _GalloryButtonState extends State<GalloryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: 240,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: new RaisedButton(
            onPressed: () {
              pickGalleryMedia(context);
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => FirstAddProfile()));
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

  Future pickGalleryMedia(BuildContext context) async {
    final source = ModalRoute.of(context)!.settings.arguments as MediaSource;

    final getMedia = source == MediaSource.image
        ? ImagePicker().getImage
        : ImagePicker().getVideo;

    final media = await getMedia(source: ImageSource.gallery);
    final file = File(media!.path);

    Navigator.of(context).pop(file);
  }
}