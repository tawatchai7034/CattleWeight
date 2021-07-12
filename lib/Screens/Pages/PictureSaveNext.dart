import 'package:flutter/material.dart';
import 'package:cattle_weight/convetHex.dart';

ConvertHex hex = new ConvertHex();

class PictureSave extends StatefulWidget {
  const PictureSave({Key? key}) : super(key: key);

  @override
  _PictureSaveState createState() => _PictureSaveState();
}

class _PictureSaveState extends State<PictureSave> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Save page"),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  child: Center(
                      child: Text(
                    "Heart Girth : 2XX CM.",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                  color: Colors.blue,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 120,
                  width: double.infinity,
                  child: Center(
                      child: Text(
                    "Boar Lenght : 2XX CM.",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                  color: Colors.green,
                ),
                SizedBox(
                  height: 240,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text("บันทึก",
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
              ]),
        ));
  }
}
