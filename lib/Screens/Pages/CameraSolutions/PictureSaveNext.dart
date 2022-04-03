// @dart=2.9
import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:cattle_weight/DataBase/catTime_handler.dart';
import 'package:cattle_weight/model/calculation.dart';
import 'package:cattle_weight/model/catTime.dart';
import 'package:cattle_weight/model/utility.dart';
import 'package:flutter/material.dart';

import 'package:cattle_weight/Screens/Pages/ViewPage.dart';
import 'package:cattle_weight/Screens/Widgets/MainButton.dart';
import 'package:cattle_weight/Screens/Widgets/PictureCameraTop.dart';
import 'package:cattle_weight/convetHex.dart';

ConvertHex hex = new ConvertHex();
CattleCalculation calculate = new CattleCalculation();

class SaveNextCamera extends StatefulWidget {
  final int catTimeID;
  const SaveNextCamera({
    Key key,
    this.catTimeID,
  }) : super(key: key);

  @override
  _SaveNextCameraState createState() => _SaveNextCameraState();
}

class _SaveNextCameraState extends State<SaveNextCamera> {
  CatTimeHelper catTimeHelper;
  Future<CatTimeModel> catTimeData;

  Future loadData() async {
    catTimeData = catTimeHelper.getCatTimeWithCatTimeID(widget.catTimeID);
  }

  @override
  void initState() {
    super.initState();
    catTimeHelper = new CatTimeHelper();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Save page",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Color(hex.hexColor("#007BA4")),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: FutureBuilder(
              future: catTimeData,
              builder: (context, AsyncSnapshot<CatTimeModel> snapshot) {
                if (snapshot.hasData) {
                  double hg = calculate.calHeartGirth(
                      snapshot.data.hearLenghtRear,
                      snapshot.data.hearLenghtSide);

                  return Center(
                    child: ListView(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 240,
                            width: double.infinity,
                            child: Center(
                                child: ListTile(
                              title: RotatedBox(
                                quarterTurns: -1,
                                child: Image.asset(
                                  "assets/images/SideLeftNavigation3.png",
                                  height: 120,
                                  width: 180,
                                ),
                              ),
                              subtitle: Text(
                                "รอบอก: ${hg.toStringAsFixed(3)} ซม.",
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            )),
                            color: Colors.blue,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            height: 240,
                            width: double.infinity,
                            child: Center(
                                child: ListTile(
                              title: RotatedBox(
                                quarterTurns: -1,
                                child: Image.asset(
                                  "assets/images/SideLeftNavigation4.png",
                                  height: 120,
                                  width: 180,
                                ),
                              ),
                              subtitle: Text(
                                "ความยาวลำตัว: ${snapshot.data.bodyLenght.toStringAsFixed(3)} ซม.",
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            )),
                            color: Colors.green,
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MainButton(
                                    onSelected: () async {
                                      double weight = calculate.calWeight(snapshot.data.bodyLenght, hg);

                                      print("Cattle Weight: $weight Kg.");

                                      await catTimeHelper.updateCatTime(
                                          CatTimeModel(
                                              id: snapshot.data.id,
                                              idPro: snapshot.data.idPro,
                                              weight: weight,
                                              bodyLenght:
                                                  snapshot.data.bodyLenght,
                                              heartGirth:
                                                  hg,
                                              hearLenghtSide: snapshot.data.hearLenghtSide,
                                              hearLenghtRear:
                                                  snapshot.data.hearLenghtRear,
                                              hearLenghtTop:
                                                  snapshot.data.hearLenghtTop,
                                              pixelReference:
                                                  snapshot.data.pixelReference,
                                              distanceReference: snapshot
                                                  .data.distanceReference,
                                              imageSide:
                                                  snapshot.data.imageSide,
                                              imageRear:
                                                  snapshot.data.imageRear,
                                              imageTop: snapshot.data.imageTop,
                                              date: DateTime.now()
                                                  .toIso8601String(),
                                              note: ""));
                                      // // Navigator.pushAndRemoveUntil จะไม่สามารถย้อนกลับมายัง Screen เดิมได้
                                      // Navigator.pushAndRemoveUntil(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => CattlePreview(
                                      //               "01",
                                      //               "cattle01",
                                      //               "male",
                                      //               "Brahman",
                                      //               "assets/images/cattle01.jpg",
                                      //               "assets/images/cattle01.jpg",
                                      //               "assets/images/cattle01.jpg",
                                      //               255,
                                      //               255,
                                      //               255,
                                      //             )),
                                      //     (route) => false);
                                    },
                                    title: "คำนวณน้ำหนัก"),
                                SizedBox(
                                  height: 10,
                                ),
                                MainButton(
                                    onSelected: () {
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (context) => TakePictureTop(

                                      //           localFront: widget.localFront,
                                      //           localBack: widget.localBack,
                                      //         )));

                                      // change new camera
                                    },
                                    title: "ถ่ายภาพกระดูกสันหลังโค"),
                              ])
                        ]),
                  );
                } else {
                  return Container();
                }
              }),
        ));
  }
}
