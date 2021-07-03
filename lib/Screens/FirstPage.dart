import 'dart:io';

import 'package:cattle_weight/Screens/FirstAddProfile.dart';
import 'package:cattle_weight/Widgets/SelectPicture.dart';
import 'package:flutter/material.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:cattle_weight/Widgets/HomePage.dart';
import 'package:cattle_weight/model/MediaSource.dart';

ConvertHex hex = new ConvertHex();

class FisrtPage extends StatefulWidget {
  const FisrtPage({Key? key}) : super(key: key);

  @override
  _FisrtPageState createState() => _FisrtPageState();
}

class _FisrtPageState extends State<FisrtPage> {

  late File fileMedia;
  late MediaSource source;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 30,
              ),
              // โลโก้แอป
              Center(
                child: Image.asset("assets/images/IconApp.jpg",
                    height: 240, width: 240, fit: BoxFit.cover),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  "Cattle Weight",
                  style: TextStyle(
                      fontSize: 36,
                      color: Color(hex.hexColor("ffffff")),
                      fontFamily: 'boogaloo',
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              // ปุ่มคำนวณน้ำหนักโค
              Container(
                  height: 60,
                  width: 240,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: new RaisedButton(
                      // กดแล้วให้ไปหน้า FisrtPage/SelectInput พร้อบระบุชนิดของสื่เป็น vdo หรือ  image
                      onPressed: () => capture(MediaSource.image),
                      child: Text("คำนวณน้ำหนักโค",
                          style: TextStyle(
                              fontSize: 24,
                              color: Color(hex.hexColor("ffffff")),
                              fontWeight: FontWeight.bold)),
                      color: Color(hex.hexColor("#47B5BE")),
                      // รูปทรงปุ่ม
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        // กรอบปุ่ม
                        side: BorderSide(color: Colors.white),
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              // ปุ่มหน้าประวัติ
              Container(
                  height: 60,
                  width: 240,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: new RaisedButton(
                      // กดแลเวให้ไปหน้า HomePage/TapbarView()
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TapbarView()));
                      },
                      child: Text("หน้าประวัติ",
                          style: TextStyle(
                              fontSize: 24,
                              color: Color(hex.hexColor("ffffff")),
                              fontWeight: FontWeight.bold)),
                      color: Color(hex.hexColor("#47B5BE")),
                      // รูปทรงปุ่ม
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        // กรอบปุ่ม
                        side: BorderSide(color: Colors.white),
                      ),
                    ),
                  )),
            ]),
      ),
      backgroundColor: Color(hex.hexColor("#47B5BE")),
    );
  }

    Future capture(MediaSource source) async {
    setState(() {
      this.source = source;
      var _fileMedia = null;
            this.fileMedia = _fileMedia;
    });

    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SelectInput(),
        settings: RouteSettings(
          arguments: source,
        ),
      ),
    );

    if (result == null) {
      return;
    } else {
      setState(() {
        fileMedia = result;
      });
    }
  }
}

