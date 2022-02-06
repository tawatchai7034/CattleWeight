import 'dart:async';

import 'package:camera/camera.dart';
import 'package:cattle_weight/Screens/Widgets/MainButton.dart';
import 'package:cattle_weight/Screens/Widgets/PictureCameraSide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'DiscoveryDevice.dart';
import 'package:cattle_weight/convetHex.dart';

// ConvertHex convert color code from web
ConvertHex hex = new ConvertHex();

class BlueMainPage extends StatefulWidget {
  final CameraDescription camera;

  const BlueMainPage({
    Key? key,
    required this.camera,
  }) : super(key: key);

  @override
  _BlueMainPage createState() => new _BlueMainPage();
}

class _BlueMainPage extends State<BlueMainPage> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  String _address = "...";
  String _name = "...";

  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      // Wait if adapter not enabled
      if ((await FlutterBluetoothSerial.instance.isEnabled) ?? false) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      // Update the address field
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          _address = address!;
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {
        _name = name!;
      });
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
      });
    });
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Flutter Bluetooth Serial'),
        // ),
        body: _bluetoothState.isEnabled
            ? DiscoveryPage(
                start: true,
                camera: widget.camera,
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 100),
                    Container(
                        child: Text(
                      "กรุณาเชื่อมต่อบลูทูธ",
                      style: TextStyle(fontSize: 36),
                    )),
                    SizedBox(height: 270),
                    Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MainButton(
                            onSelected: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => TakePictureSide(
                                      blueConnection: false,
                                      camera: widget.camera,
                                      localFront:
                                          "assets/images/SideLeftNavigation.png",
                                      localBack:
                                          "assets/images/SideRightNavigation.png")));
                            },
                            title: "ไม่เชื่อมต่ออุปกรณ์"),
                      ],
                    ))
                  ],
                ),
              ));
  }
}
