import 'package:flutter/material.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:cattle_weight/Screens/HomePage.dart';

ConvertHex hex = new ConvertHex();

class FisrtPage extends StatefulWidget {
  const FisrtPage({Key? key}) : super(key: key);

  @override
  _FisrtPageState createState() => _FisrtPageState();
}

class _FisrtPageState extends State<FisrtPage> {
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
                       // กดแลเวให้ไปหน้า FisrtPage/SelectInput
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SelectInput()));
                      },
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
}

// หน้าเลือกภาพที่จะนำไปใช้คำนวณน้ำหนัก
class SelectInput extends StatelessWidget {
  const SelectInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
              child: Image.asset("assets/images/camera01.png",
                  height: 240, width: 240, fit: BoxFit.cover)),
          SizedBox(
            height: 10,
          ),
          Container(
              height: 60,
              width: 240,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: new RaisedButton(
                  onPressed: () {
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => SelectInput()));
                  },
                  child: Text("ถ่ายภาพ",
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
              )),
          Center(
              child: Image.asset("assets/images/photo01.png",
                  height: 240, width: 240, fit: BoxFit.cover)),
          SizedBox(
            height: 10,
          ),
          Container(
              height: 60,
              width: 240,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: new RaisedButton(
                  onPressed: () {
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => SelectInput()));
                  },
                  child: Text("นำเข้าภาพ",
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
              )),
        ],
      ),
      backgroundColor: Color(hex.hexColor("#47B5BE")),
    );
  }
}
