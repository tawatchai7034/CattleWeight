import 'dart:async';

import 'package:flutter/material.dart';

class TimeViews extends StatefulWidget {
  const TimeViews({Key? key}) : super(key: key);

  @override
  _TimeViewsState createState() => _TimeViewsState();
}

class _TimeViewsState extends State<TimeViews> {
  DateTime timeNow = DateTime.now();
  int lastDebounceTime = 0; // the last time the output pin was toggled
  int debounceDelay = DateTime.now().second.toInt();
  late Timer _timer;
  int _start = 10;
  Duration duration = Duration();

  void addTime(){
    final addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds +addSeconds;
      duration = Duration(seconds:seconds);
    });
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    // _timer = new Timer.periodic(
    //   oneSec,
    //   (Timer timer) {
    //     if (_start == 0) {
    //       setState(() {
    //         _start = 10;
    //         timer.cancel();
    //       });
    //     } else {
    //       setState(() {
    //         _start--;
    //       });
    //     }
    //   },
    // );
    _timer = Timer.periodic(Duration(seconds: 1), (timer) => addTime());
  }

  void resetTimer() {
    setState(() {
      _start = 10;
    });  
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String toDigits(int n)=> n.toString().padLeft(2,'0');
    final minutes =toDigits(duration.inMinutes.remainder(60));
    final seconds =toDigits(duration.inSeconds.remainder(60));
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("${duration.inSeconds}",style: TextStyle(fontSize: 24)),
            Text("$minutes : $seconds",style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }

}
