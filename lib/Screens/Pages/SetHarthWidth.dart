import 'dart:io';

import 'package:cattle_weight/model/MediaSource.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cattle_weight/convetHex.dart';

ConvertHex hex = new ConvertHex();

class SetHarthWidth extends StatefulWidget {
  late File file;

  SetHarthWidth(this.file);

  @override
  _SetHarthWidthState createState() => _SetHarthWidthState();
}

class _SetHarthWidthState extends State<SetHarthWidth> {
  
  // โหมดแนวนอน
  Widget _landscapeMode(){
    return Scaffold(
      appBar: AppBar(
        title: Text("กำหนดความยาวรอบอกและความยาวลำตัว"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
        body: Center(
      child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: widget.file == null
                    ? Icon(Icons.photo, size: 120)
                    : Image.file(widget.file),
              ),
            ],
          )),
    ),
    backgroundColor: Color(hex.hexColor("#71DFE2")),);
  }

// โหมดแนวตั้ง
  Widget _portraitMode(){
    return Scaffold(
      appBar: AppBar(
        title: Text("กำหนดความยาวรอบอกและความยาวลำตัว"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
        body: Center(
      child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: widget.file == null
                    ? Icon(Icons.photo, size: 120)
                    : Image.file(widget.file),
              ),
            ],
          )),
    ),
    backgroundColor: Color(hex.hexColor("#ffffff")),);
  }
  
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context,orientation){
      if(orientation == Orientation.portrait){
      return _portraitMode();
    }else{
      return _landscapeMode();
    }
    });
  }
}
