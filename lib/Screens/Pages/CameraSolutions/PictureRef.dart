import 'package:camera/camera.dart';
import 'package:cattle_weight/Screens/Pages/CameraSolutions/PictureHG.dart';
import 'package:cattle_weight/Screens/Widgets/preview.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:flutter/material.dart';

ConvertHex hex = new ConvertHex();

class PictureRef extends StatefulWidget {
  final CameraDescription camera;
  final String imgPath;
  final String fileName;
  const PictureRef(
      {Key? key,
      required this.camera,
      required this.imgPath,
      required this.fileName})
      : super(key: key);

  @override
  _PictureRefState createState() => _PictureRefState();
}

class _PictureRefState extends State<PictureRef> {
  bool showState = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("[1/3] กรุณาระบุจุดอ้างอิง",
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PictureHG(
                          camera: widget.camera,
                          imgPath: widget.imgPath,
                          fileName: widget.fileName)));
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
                title: Text("กรุณาระบุจุดอ้างอิง",
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                content: Image.asset("assets/images/SideLeftNavigation5.png"),
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