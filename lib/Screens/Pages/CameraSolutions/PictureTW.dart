import 'package:camera/camera.dart';
import 'package:cattle_weight/Screens/Pages/CameraSolutions/PictureSaveNext.dart';
import 'package:cattle_weight/Screens/Widgets/MainButton.dart';
import 'package:cattle_weight/Screens/Widgets/PictureCameraRear.dart';
import 'package:cattle_weight/Screens/Widgets/preview.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:flutter/material.dart';

import 'dart:ffi';
import 'dart:math';
import 'package:cattle_weight/Screens/Pages/CameraSolutions/Position.dart';
import 'package:cattle_weight/Screens/Pages/CameraSolutions/PaintLine.dart';

ConvertHex hex = new ConvertHex();

Positions pos = new Positions();

class PictureTW extends StatefulWidget {
  final CameraDescription camera;
  final String imgPath;
  final String fileName;
  const PictureTW(
      {Key? key,
      required this.camera,
      required this.imgPath,
      required this.fileName})
      : super(key: key);

  @override
  _PictureTWState createState() => _PictureTWState();
}

class _PictureTWState extends State<PictureTW> {
  bool showState = false;

  List<double> positionsX = [];
  List<double> positionsY = [];
  int index = 0;

  void onTapDown(BuildContext context, TapDownDetails details) {
    print('${details.globalPosition}');
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    final Offset localOffset = box!.globalToLocal(details.globalPosition);
    setState(() {
      index++;
      // posx = localOffset.dx;
      // posy = localOffset.dy;
      // pos.setX1(localOffset.dx);
      // pos.setY1(localOffset.dy);
      positionsX.add(localOffset.dx);
      positionsY.add(localOffset.dy);
    });
  }

  @override
  void initState() {
    super.initState();
    positionsX.add(0);
    positionsY.add(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("[2/2] กรุณาระบุความกว้างกระดูกก้นกบของโค",
                style: TextStyle(
                    fontSize: 24,
                    color: Color(hex.hexColor("ffffff")),
                    fontWeight: FontWeight.bold)),
            backgroundColor: Color(hex.hexColor("#007BA4"))),
        body: new GestureDetector(
          onTapDown: (TapDownDetails details) => onTapDown(context, details),
          child: new Stack(fit: StackFit.expand, children: <Widget>[
            // Hack to expand stack to fill all the space. There must be a better
            // way to do it.
            // new Container(color: Colors.white),
            new RotatedBox(
              quarterTurns: 1,
              child: PreviewScreen(
                imgPath: widget.imgPath,
                fileName: widget.fileName,
              ),
            ),
            // Show data of position
            // new Positioned(
            //   child: new Text(
            //       '(${positionsX[index].toInt()} , ${positionsY[index].toInt()})'),
            //   left: positionsX[index],
            //   top: positionsY[index],
            // ),
            // positionsX.length % 2 == 0
            //     ? new Positioned(
            //         child: new Text(
            //             '(${positionsX[index - 1].toInt()} , ${positionsY[index - 1].toInt()})'),
            //         left: positionsX[index - 1],
            //         top: positionsY[index - 1],
            //       )
            //     : Container(),
            // //Distance
            // positionsX.length % 2 == 0
            //     ? Text(
            //         "${sqrt(((positionsX[index] - positionsX[index - 1]) * (positionsX[index] - positionsX[index - 1])) + ((positionsY[index] - positionsY[index - 1]) * (positionsY[index] - positionsY[index - 1])))}",
            //         style: TextStyle(fontSize: 24, color: Colors.white))
            //     : Container(),
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
                    onSelected: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PictureSaveNext(
                              camera: widget.camera,
                              localFront: "assets/images/TopLeftNavigation.png",
                              localBack:
                                  "assets/images/TopRightNavigation.png")));
                    },
                    title: "บันทึก"),
              ]),
            ),
            showState
                ? Container()
                : AlertDialog(
                    // backgroundColor: Colors.black,
                    title: Text("กรุณาระบุความกว้างกระดูกก้นกบของโค",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold)),
                    content: Image.asset("assets/images/RearNavigation3.png"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          setState(() => showState = !showState);
                        },
                        // => Navigator.pop(context, 'ตกลง'),
                        child:
                            const Text('ตกลง', style: TextStyle(fontSize: 24)),
                      ),
                    ],
                  ),
          ]),
        ));
  }
}
