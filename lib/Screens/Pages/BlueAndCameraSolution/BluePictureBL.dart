import 'dart:async';
import 'package:camera/camera.dart';
import 'package:cattle_weight/Screens/Widgets/LineAndPosition.dart';
import 'package:cattle_weight/Screens/Widgets/MainButton.dart';
import 'package:cattle_weight/Screens/Widgets/PictureCameraRear.dart';
import 'package:cattle_weight/Screens/Widgets/blueAndCameraRear.dart';
import 'package:cattle_weight/Screens/Widgets/preview.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

ConvertHex hex = new ConvertHex();

class BluePictureBL extends StatefulWidget {
  final BluetoothDevice server;
  final CameraDescription camera;
  final String imgPath;
  final String fileName;
  const BluePictureBL(
      {Key? key,
      required this.server,
      required this.camera,
      required this.imgPath,
      required this.fileName})
      : super(key: key);

  @override
  _BluePictureBLState createState() => _BluePictureBLState();
}

class _BluePictureBLState extends State<BluePictureBL> {
  bool showState = false;
  bool start = true;
  late StreamSubscription<BluetoothDiscoveryResult> _streamSubscription;
  List<BluetoothDiscoveryResult> results = [];
  late bool isDiscovering;

  @override
  void initState() {
    super.initState();

    isDiscovering = start;
    if (isDiscovering) {
      _startDiscovery();
    }
  }

  void _restartDiscovery() {
    setState(() {
      results.clear();
      isDiscovering = true;
    });

    _startDiscovery();
  }

  void _startDiscovery() {
    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        results.add(r);
      });
    });

    _streamSubscription.onDone(() {
      setState(() {
        isDiscovering = false;
      });
    });
  }

  // @TODO . One day there should be `_pairDevice` on long tap on something... ;)

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    _streamSubscription.cancel();

    super.dispose();
  }

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
                      builder: (context) => BlueAndCameraRear(
                            server: widget.server,
                            camera: widget.camera,
                          )));
                },
                title: "บันทึก"),
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
}
