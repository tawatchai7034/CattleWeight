// @dart=2.9
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cattle_weight/Screens/Widgets/PaintPoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cattle_weight/Screens/Widgets/PaintLine.dart';
import 'package:cattle_weight/Screens/Widgets/position.dart';
import 'package:cattle_weight/Screens/Widgets/preview.dart';

Positions pos = new Positions();

class LineAndPosition extends StatefulWidget {
  final String imgPath;
  final String fileName;
  const LineAndPosition({this.imgPath, this.fileName});

  @override
  LineAndPositionState createState() => new LineAndPositionState();
}

class LineAndPositionState extends State<LineAndPosition> {
  List<double> positionsX = [];
  List<double> positionsY = [];
  double posx = 100.0;
  double posy = 100.0;
  int index = 0;

  void onTapDown(BuildContext context, TapDownDetails details) {
    print('${details.globalPosition}');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
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
    positionsX.add(100);
    positionsY.add(100);
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
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
        //// Distance calculation
        // positionsX.length % 2 == 0
        //     ? Text(
        //         "${sqrt(((positionsX[index] - positionsX[index - 1]) * (positionsX[index] - positionsX[index - 1])) + ((positionsY[index] - positionsY[index - 1]) * (positionsY[index] - positionsY[index - 1])))}")
        //     : Container(),
        PathCircle(
          x1: positionsX[index],
          y1: positionsY[index],
        ),
        positionsX.length % 2 == 0 ?
        PathCircle(
          x1: positionsX[index-1],
          y1: positionsY[index-1],
        ):Container(),
        positionsX.length % 2 == 0
            ? new PathExample(
                x1: positionsX[index - 1],
                y1: positionsY[index - 1],
                x2: positionsX[index],
                y2: positionsY[index],
              )
            : Container(),
      ]),
    );
  }
}

