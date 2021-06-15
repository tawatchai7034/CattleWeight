import 'package:flutter/material.dart';
import 'package:cattle_weight/convetHex.dart';

// class ที่ใช้ในการแปลงค่าสีจากภายนอกมาใช้ใน flutter
  ConvertHex hex = new ConvertHex();

class AddProfile extends StatelessWidget {
  const AddProfile({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Profile"),
        backgroundColor: Color(hex.hexColor("#007BA4")),
      ),body: Center(
        child: Text("Add Profile page"),
      ),
      );
  }
}