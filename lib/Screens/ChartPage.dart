import 'package:flutter/material.dart';
import 'package:cattle_weight/convetHex.dart';

// class ที่ใช้ในการแปลงค่าสีจากภายนอกมาใช้ใน flutter
  ConvertHex hex = new ConvertHex();

class CattleVegetative extends StatefulWidget {
  const CattleVegetative({ Key? key }) : super(key: key);

  @override
  _CattleVegetativeState createState() => _CattleVegetativeState();
}

class _CattleVegetativeState extends State<CattleVegetative> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chart"),
        backgroundColor: Color(hex.hexColor("#007BA4")),
      ),body: Center(
        child: Text("Chart page"),
      ),
      );
  }
}