import 'dart:async';

import 'package:camera/camera.dart';
import 'package:cattle_weight/Screens/Widgets/PictureCameraSide.dart';
import 'package:cattle_weight/Screens/Widgets/blueAndCameraSide.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'package:cattle_weight/Bluetooth/ChatPage.dart';
import 'package:sqflite/utils/utils.dart';

import 'package:cattle_weight/Bluetooth/BluetoothDeviceListEntry.dart';

// ConvertHex convert color code from web
ConvertHex hex = new ConvertHex();

class DiscoveryPage extends StatefulWidget {
  /// If true, discovery starts on page start, otherwise user must press action button.
  final bool start;
  final CameraDescription camera;

  const DiscoveryPage({
    Key? key,
    required this.start,
    required this.camera,
  }) : super(key: key);

  @override
  _DiscoveryPage createState() => new _DiscoveryPage();
}

class _DiscoveryPage extends State<DiscoveryPage> {
  late StreamSubscription<BluetoothDiscoveryResult> _streamSubscription;
  List<BluetoothDiscoveryResult> results = [];
  late bool isDiscovering;

  @override
  void initState() {
    super.initState();

    isDiscovering = widget.start;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(hex.hexColor("#47B5BE")),
        title: isDiscovering
            ? Text('Discovering devices')
            : Text('Discovered devices'),
        actions: <Widget>[
          isDiscovering
              ? FittedBox(
                  child: Container(
                    margin: new EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
              : IconButton(
                  icon: Icon(Icons.replay),
                  onPressed: _restartDiscovery,
                )
        ],
      ),
      body: Stack(children: [
        ListView.builder(
          itemCount: results.length,
          itemBuilder: (BuildContext context, index) {
            BluetoothDiscoveryResult result = results[index];
            return BluetoothDeviceListEntry(
              device: result.device,
              rssi: result.rssi,
              onTap: () {
                // Navigator.of(context).pop(result.device);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlueAndCameraSide(
                          server: result.device,
                          camera: widget.camera,
                        )));
              },
            );
          },
        ),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: Container(
                height:70,
                width:250,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TakePictureSide(
                            blueConnection: false,
                            camera: widget.camera,
                            localFront: "assets/images/SideLeftNavigation.png",
                            localBack: "assets/images/SideRightNavigation.png")));
                  },
                  child: Text("ไม่เชื่อมต่ออุปกรณ์",
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
            ),
          ],
        ))
      ]),
    );
  }
}
