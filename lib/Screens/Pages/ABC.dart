import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothApp extends StatefulWidget {
  const BluetoothApp({ Key? key }) : super(key: key);
  

  @override
  _BluetoothAppState createState() => _BluetoothAppState();
}

class _BluetoothAppState extends State<BluetoothApp> {
  FlutterBlue flutterBlueInstance  = FlutterBlue.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}