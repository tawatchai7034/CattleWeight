// @dart=2.9
import 'package:cattle_weight/Screens/Pages/FirstPage.dart';
import 'package:flutter/material.dart';
import 'package:cattle_weight/Screens/Pages/HomePage.dart';
import 'convetHex.dart';
import 'package:cattle_weight/Screens/Pages/FirstPage.dart';

ConvertHex hex = new ConvertHex();
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // กำหนด font เริ่มต้น
        fontFamily: 'TH-Niramit-AS',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FisrtPage()
      //  TapbarView()
    );
  }
}
