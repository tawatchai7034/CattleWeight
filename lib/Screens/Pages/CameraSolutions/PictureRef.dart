// @dart=2.9
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:cattle_weight/DataBase/catTime_handler.dart';
import 'package:cattle_weight/Screens/Pages/CameraSolutions/PictureHG.dart';
import 'package:cattle_weight/Screens/Widgets/Alerts.dart';
import 'package:cattle_weight/Screens/Widgets/LineAndPosition.dart';
import 'package:cattle_weight/Screens/Widgets/MainButton.dart';
import 'package:cattle_weight/Screens/Widgets/PaintLine.dart';
import 'package:cattle_weight/Screens/Widgets/PaintPoint.dart';
import 'package:cattle_weight/Screens/Widgets/position.dart';
import 'package:cattle_weight/Screens/Widgets/preview.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:cattle_weight/model/catTime.dart';

ConvertHex hex = new ConvertHex();
Positions pos = new Positions();

class PictureRef extends StatefulWidget {
  final File imageFile;
  final String fileName;
  final CatTimeModel catTime;
  const PictureRef({
    Key key,
    this.imageFile,
    this.fileName,
    this.catTime,
  }) : super(key: key);

  @override
  _PictureRefState createState() => _PictureRefState();
}

class _PictureRefState extends State<PictureRef> {
  bool showState = false;
  TextEditingController _textFieldController = TextEditingController();
  List<double> positionsX = [];
  List<double> positionsY = [];
  double pixelDistance = 0;
  int index = 0;
  CatTimeHelper catTimeHelper;
  Future<List<CatTimeModel>> notesList;

  void onTapDown(BuildContext context, TapDownDetails details) {
    print('${details.globalPosition}');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);

    setState(() {
      index++;
      positionsX.add(localOffset.dx);
      positionsY.add(localOffset.dy);
      // Distance calculation
      positionsX.length % 2 == 0
          ? pixelDistance = sqrt(((positionsX[index] - positionsX[index - 1]) *
                  (positionsX[index] - positionsX[index - 1])) +
              ((positionsY[index] - positionsY[index - 1]) *
                  (positionsY[index] - positionsY[index - 1])))
          : pixelDistance = pixelDistance;

      // print("Pixel Distance = ${pixelDistance}");
      pos.setPixelDistance(pixelDistance);
      print("POS  = ${pos.getPixelDistance()}");
    });
  }

  loadData() async {
    notesList = catTimeHelper.getCatTimeListWithCatProID(widget.catTime.idPro);
  }

  @override
  void initState() {
    super.initState();
    catTimeHelper = new CatTimeHelper();
    positionsX.add(100);
    positionsY.add(100);
    loadData();
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'ระบุความยาวของจุดอ้างอิง',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            content: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration:
                  InputDecoration(hintText: "กรุณาระบุความยาวของจุดอ้างอิง"),
            ),
            actions: <Widget>[
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          padding: EdgeInsets.symmetric(
                              horizontal: 28, vertical: 16),
                          textStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('ยกเลิก'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          padding: EdgeInsets.symmetric(
                              horizontal: 28, vertical: 16),
                          textStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        await catTimeHelper.updateCatTime(CatTimeModel(
                            id: widget.catTime.id,
                            idPro: widget.catTime.idPro,
                            bodyLenght: widget.catTime.bodyLenght,
                            heartGirth: widget.catTime.heartGirth,
                            hearLenghtSide: widget.catTime.hearLenghtSide,
                            hearLenghtRear: widget.catTime.hearLenghtRear,
                            hearLenghtTop: widget.catTime.hearLenghtTop,
                            pixelReference: pos.getPixelDistance(),
                            distanceReference:
                                double.parse(_textFieldController.text),
                            imageSide: widget.catTime.imageSide,
                            imageRear: widget.catTime.imageRear,
                            imageTop: widget.catTime.imageTop,
                            date: DateTime.now().toIso8601String(),
                            note: "Update pixel reference"));

                        loadData();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PictureHG(
                                imgPath: widget.imageFile.path,
                                fileName: widget.fileName)));
                      },
                      child: const Text('บันทึก'),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  String codeDialog;
  String valueText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("[1/3] กรุณาระบุจุดอ้างอิง",
              style: TextStyle(
                  fontSize: 24,
                  color: Color(hex.hexColor("ffffff")),
                  fontWeight: FontWeight.bold)),
          backgroundColor: Color(hex.hexColor("#007BA4"))),
      body: new Stack(
        children: [
          new GestureDetector(
            onTapDown: (TapDownDetails details) => onTapDown(context, details),
            child: new Stack(fit: StackFit.loose, children: <Widget>[
              // Hack to expand stack to fill all the space. There must be a better
              // way to do it.
              // new Container(color: Colors.white),
              new RotatedBox(
                quarterTurns: 1,
                child: PreviewScreen(
                  imgPath: widget.imageFile.path,
                  fileName: widget.fileName,
                ),
              ),
              //// Show position (x2,y2)
              // new Positioned(
              //   child: new Text(
              //       '(${positionsX[index].toInt()} , ${positionsY[index].toInt()})'),
              //   left: positionsX[index],
              //   top: positionsY[index],
              // ),
              //// Show position (x1,y1)
              // positionsX.length % 2 == 0
              //     ? new Positioned(
              //         child: new Text(
              //             '(${positionsX[index - 1].toInt()} , ${positionsY[index - 1].toInt()})'),
              //         left: positionsX[index - 1],
              //         top: positionsY[index - 1],
              //       )
              //     : Container(),
              // // Distance calculation
              // positionsX.length % 2 == 0
              //     ? Text(
              //         "${sqrt(((positionsX[index] - positionsX[index - 1]) * (positionsX[index] - positionsX[index - 1])) + ((positionsY[index] - positionsY[index - 1]) * (positionsY[index] - positionsY[index - 1])))}")
              //     : Container(),
              PathCircle(
                x1: positionsX[index],
                y1: positionsY[index],
              ),
              positionsX.length % 2 == 0
                  ? PathCircle(
                      x1: positionsX[index - 1],
                      y1: positionsY[index - 1],
                    )
                  : Container(),
              positionsX.length % 2 == 0
                  ? new PathExample(
                      x1: positionsX[index - 1],
                      y1: positionsY[index - 1],
                      x2: positionsX[index],
                      y2: positionsY[index],
                    )
                  : Container(),

              Padding(
                padding: EdgeInsets.all(20),
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  MainButton(
                      onSelected: () async {
                        // await catTimeHelper.updateCatTime(CatTimeModel(
                        //     id: widget.catTime.id,
                        //     idPro: widget.catTime.idPro,
                        //     bodyLenght: widget.catTime.bodyLenght,
                        //     heartGirth: widget.catTime.heartGirth,
                        //     hearLenghtSide: widget.catTime.hearLenghtSide,
                        //     hearLenghtRear: widget.catTime.hearLenghtRear,
                        //     hearLenghtTop: widget.catTime.hearLenghtTop,
                        //     pixelReference: pos.getPixelDistance(),
                        //     distanceReference: widget.catTime.distanceReference,
                        //     imageSide: widget.catTime.imageSide,
                        //     imageRear: widget.catTime.imageRear,
                        //     imageTop: widget.catTime.imageTop,
                        //     date: DateTime.now().toIso8601String(),
                        //     note: "Update pixel reference"));
                        // loadData();

                        _displayTextInputDialog(
                          context,
                        );
                      },
                      title: "บันทึก"),
                ]),
              ),
            ]),
          ),
          showState
              ? Container()
              : AlertDialog(
                  // backgroundColor: Colors.black,
                  title: Text("กรุณาระบุจุดอ้างอิง",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  content: Image.asset("assets/images/SideLeftNavigation5.png"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        setState(() => showState = !showState);
                      },
                      // => Navigator.pop(context, 'ตกลง'),
                      child: const Text('ตกลง', style: TextStyle(fontSize: 24)),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
