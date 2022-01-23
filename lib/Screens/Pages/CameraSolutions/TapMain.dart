// @dart=2.9
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cattle_weight/Screens/Pages/CameraSolutions/Position.dart';
import 'package:cattle_weight/Screens/Pages/CameraSolutions/PaintLine.dart';
import 'dart:math';

Positions pos = new Positions();

class TapImage extends StatefulWidget {
  @override
  TapImageState createState() => new TapImageState();
}

class TapImageState extends State<TapImage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Popup Demo'),
        ),
        body: MyWidget());
  }
}

class MyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyWidgetState();
  }
}

class MyWidgetState extends State<MyWidget> {
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
    positionsX.add(0);
    positionsY.add(0);
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
          child: new Image.network(
              'https://live-production.wcms.abc-cdn.net.au/13e45ea9603d827b523b05c24aabe788?impolicy=wcms_crop_resize&cropH=415&cropW=623&xPos=0&yPos=30&width=862&height=575'),
        ),
        new Positioned(
          child: new Text(
              '(${positionsX[index].toInt()} , ${positionsY[index].toInt()})'),
          left: positionsX[index],
          top: positionsY[index],
        ),
        positionsX.length % 2 == 0
            ? new Positioned(
                child: new Text(
                    '(${positionsX[index - 1].toInt()} , ${positionsY[index - 1].toInt()})'),
                left: positionsX[index - 1],
                top: positionsY[index - 1],
              )
            : Container(),
        positionsX.length % 2 == 0
            ? Text(
                "${sqrt(((positionsX[index] - positionsX[index - 1]) * (positionsX[index] - positionsX[index - 1])) + ((positionsY[index] - positionsY[index - 1]) * (positionsY[index] - positionsY[index - 1])))}")
            : Container(),
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

class Coordinates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () => print('tapped!'),
      onTapDown: (TapDownDetails details) => _onTapDown(details),
      onTapUp: (TapUpDetails details) => _onTapUp(details),
    );
  }

  _onTapDown(TapDownDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    // or user the local position method to get the offset
    print(details.localPosition);
    print("tap down " + x.toString() + ", " + y.toString());
  }

  _onTapUp(TapUpDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    // or user the local position method to get the offset
    print(details.localPosition);
    print("tap up " + x.toString() + ", " + y.toString());
  }
}


