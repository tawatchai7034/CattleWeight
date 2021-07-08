import 'package:flutter/material.dart';
import 'dart:math' as Math;

// กรอบภาพช่วยจัดตำแหน่งโค
//  - https://alex.domenici.net/archive/rotate-and-flip-an-image-in-flutter-with-or-without-animations

class CattleNavigationLine extends StatefulWidget {
  late String front;
  late String back;
  bool showFront = true;

  CattleNavigationLine(this.front, this.back, this.showFront);

  @override
  createState() => _CattleNavigationLineState();
}

class _CattleNavigationLineState extends State<CattleNavigationLine>
    with SingleTickerProviderStateMixin {
  late Image cardFront;
  late Image cardBack;
  // bool showFront = true;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
// ตำแหน่งของภาพที่ต้องการใช้
    cardFront = Image.asset(
      widget.front,
      height: 380,
      width: 280,
      fit: BoxFit.cover,
    );
    cardBack = Image.asset(
      widget.back,
      height: 380,
      width: 280,
      fit: BoxFit.cover,
    );

    // Initialize the animation controller
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000), value: 0);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(cardFront.image, context);
    precacheImage(cardBack.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Transform(
                transform: Matrix4.rotationX((controller.value) * Math.pi / 2),
                alignment: Alignment.center,
                child: Container(
                  height: MediaQuery.of(context).size.height - 220,
                  margin: EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  child: widget.showFront ? cardFront : cardBack,
                ),
              );
            },
          ),
          // FlatButton(
          //   child: Text("flip me"),
          //   onPressed: () async {
          //     // Flip the image
          //     await controller.forward();
          //     setState(() => widget.showFront = !widget.showFront);
          //     await controller.reverse();
          //   },
          // ),
        ],
      ),
    );
  }
}
