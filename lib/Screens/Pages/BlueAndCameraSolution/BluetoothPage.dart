import 'dart:async';

import 'package:camera/camera.dart';
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
                    SizedBox(height:270),
                    Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                          child: Container(
                            height: 48,
                            width: 250,
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => TakePictureSide(
                                        blueConnection: false,
                                        camera: widget.camera,
                                        localFront:
                                            "assets/images/SideLeftNavigation.png",
                                        localBack:
                                            "assets/images/SideRightNavigation.png")));
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
                  ],
                ),
              )
        //     Column(children: [
        //   Container(
        //     child: ListView(
        //       children: <Widget>[
        //         Divider(),
        //         SwitchListTile(
        //           title: const Text('Enable Bluetooth'),
        //           value: _bluetoothState.isEnabled,
        //           onChanged: (bool value) {
        //             // Do the request and update with the true value then
        //             future() async {
        //               // async lambda seems to not working
        //               if (value)
        //                 await FlutterBluetoothSerial.instance.requestEnable();
        //               else
        //                 await FlutterBluetoothSerial.instance.requestDisable();
        //             }

        //             future().then((_) {
        //               setState(() {});
        //             });
        //           },
        //         ),
        //         ListTile(title: const Text("Availble Devices")),
        //       ],
        //     ),
        //   ),
        //   DiscoveryPage()
        // ]),
        );
  }

  // void _startChat(BuildContext context, BluetoothDevice server) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) {
  //         return ChatPage(server: server,camera: widget.camera);
  //       },
  //     ),
  //   );
  // }
}
