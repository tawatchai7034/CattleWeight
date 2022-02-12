import 'package:camera/camera.dart';
import 'package:cattle_weight/Screens/Pages/BlueAndCameraSolution/BluePictureTW.dart';
import 'package:cattle_weight/Screens/Widgets/LineAndPosition.dart';
import 'package:cattle_weight/Screens/Widgets/MainButton.dart';
// import 'package:cattle_weight/Screens/Pages/CameraSolutions/PictureHG.dart';
// import 'package:cattle_weight/Screens/Pages/CameraSolutions/PictureTW.dart';
import 'package:cattle_weight/Screens/Widgets/preview.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

ConvertHex hex = new ConvertHex();

class BluePictureRefRear extends StatefulWidget {
  final BluetoothDevice server;
  final CameraDescription camera;
  final String imgPath;
  final String fileName;
  const BluePictureRefRear(
      {Key? key,
      required this.camera,
      required this.server,
      required this.imgPath,
      required this.fileName})
      : super(key: key);

  @override
  _BluePictureRefRearState createState() => _BluePictureRefRearState();
}

class _BluePictureRefRearState extends State<BluePictureRefRear> {
  bool showState = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("[1/2] กรุณาระบุจุดอ้างอิง",
              style: TextStyle(
                  fontSize: 24,
                  color: Color(hex.hexColor("ffffff")),
                  fontWeight: FontWeight.bold)),
          backgroundColor: Color(hex.hexColor("#007BA4"))),
      body: Stack(children: [
        LineAndPosition(
          imgPath: widget.imgPath,
          fileName: widget.fileName,
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            MainButton(
                onSelected: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BluePictureTW(
                          server: widget.server,
                          camera: widget.camera,
                          imgPath: widget.imgPath,
                          fileName: widget.fileName)));
                },
                title: "บันทึก"),
          ]),
        ),
        showState
            ? Container()
            : AlertDialog(
                // backgroundColor: Colors.black,
                title: Text("กรุณาระบุจุดอ้างอิง",
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                content: Image.asset("assets/images/RearNavigation4.png"),
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