import 'package:cattle_weight/Screens/Pages/BluetoothPage.dart';
import 'package:flutter/material.dart';
import 'package:cattle_weight/convetHex.dart';

// class ที่ใช้ในการแปลงค่าสีจากภายนอกมาใช้ใน flutter
ConvertHex hex = new ConvertHex();

class ConNextDevice extends StatelessWidget {
  // const ConNextDevice({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Connext Device"),
        //   backgroundColor: Color(hex.hexColor("#007BA4")),
        // ),
        body: FlutterBlueApp()
        );
  }
}
