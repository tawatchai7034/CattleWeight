import 'package:camera/camera.dart';
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

class PictureBL extends StatefulWidget {
  final bool blueConnection;
  final CameraDescription camera;
  final String imgPath;
  final String fileName;
  const PictureBL(
      {Key? key,
      required this.blueConnection,
      required this.camera,
      required this.imgPath,
      required this.fileName})
      : super(key: key);

  @override
  _PictureBLState createState() => _PictureBLState();
}

class _PictureBLState extends State<PictureBL> {
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
            title: Text("[3/3] กรุณาระบุความยาวลำตัวโค",
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
                Container(
                  height: 50,
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TakePictureRear(
                              blueConnection: widget.blueConnection,
                              camera: widget.camera,
                              localFront: "assets/images/RearNavigation.png",
                              localBack: "assets/images/RearNavigation.png")));
                    },
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
            ),
            showState
                ? Container()
                : AlertDialog(
                    // backgroundColor: Colors.black,
                    title: Text("กรุณาระบุความยาวลำตัวโค",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold)),
                    content:
                        Image.asset("assets/images/SideLeftNavigation4.png"),
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
