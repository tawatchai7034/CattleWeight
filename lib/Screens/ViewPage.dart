import 'package:flutter/material.dart';
import 'package:cattle_weight/convetHex.dart';

// class ที่ใช้ในการแปลงค่าสีจากภายนอกมาใช้ใน flutter
  ConvertHex hex = new ConvertHex();

class ViewCattle extends StatefulWidget {
  const ViewCattle({ Key? key }) : super(key: key);

  @override
  _ViewCattleState createState() => _ViewCattleState();
}

class _ViewCattleState extends State<ViewCattle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View"),
        backgroundColor: Color(hex.hexColor("#007BA4")),
      ),body: Center(
        child: Text("View page"),
      ),
      );
  }
}