import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:cattle_weight/Screens/Pages/BlueAndCameraSolution/PictureRef.dart';
// import 'package:cattle_weight/Screens/Pages/SelectPicture.dart';
import 'package:cattle_weight/Screens/Widgets/CattleNavigationLine.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'package:cattle_weight/Bluetooth/BlueMassgae.dart';
// import 'package:cattle_weight/Screens/Widgets/PictureCameraSide.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

// Messege Management
BleMessage BM = new BleMessage();
// ConvertHex convert color code from web
ConvertHex hex = new ConvertHex();

class BlueAndCameraSide extends StatefulWidget {
  final BluetoothDevice server;
  final CameraDescription camera;

  const BlueAndCameraSide({
    Key? key,
    required this.server,
    required this.camera,
  }) : super(key: key);

  @override
  _BlueAndCameraSide createState() => new _BlueAndCameraSide();
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _BlueAndCameraSide extends State<BlueAndCameraSide> {
  static final clientID = 0;
  var connection; //BluetoothConnection

  List<_Message> messages = [];
  String _messageBuffer = '';

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;
  bool isDisconnecting = false;

  String formatedTime(int secTime) {
    String getParsedTime(String time) {
      if (time.length <= 1) return "0$time";
      return time;
    }

    int min = secTime ~/ 60;
    int sec = secTime % 60;

    String parsedTime =
        getParsedTime(min.toString()) + " : " + getParsedTime(sec.toString());

    return parsedTime;
  }

  @override
  void initState() {
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection.input.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected()) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Row> list = messages.map((_message) {
      return Row(
        children: <Widget>[
          Container(
            child: Text(
                (text) {
                  return text == '/shrug' ? '¯\\_(ツ)_/¯' : text;
                }(_message.text.trim()),
                style: TextStyle(color: Colors.white)),
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            width: 222.0,
            decoration: BoxDecoration(
                color:
                    _message.whom == clientID ? Colors.blueAccent : Colors.grey,
                borderRadius: BorderRadius.circular(7.0)),
          ),
        ],
        mainAxisAlignment: _message.whom == clientID
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
      );
    }).toList();

    return Scaffold(
      // appBar: AppBar(
      //     backgroundColor: Color(hex.hexColor("#47B5BE")),
      //     title: (isConnecting
      //         ? Text('Connecting to  ${widget.server.name} ...',
      //             style: TextStyle(fontSize: 24, fontFamily: 'boogaloo'))
      //         : isConnected()
      //             ? Text('Device : ${widget.server.name}',
      //                 style: TextStyle(fontSize: 24, fontFamily: 'boogaloo'))
      //             : Text('Device name : ${widget.server.name}',
      //                 style: TextStyle(fontSize: 24, fontFamily: 'boogaloo')))),
      body: BlueParamitor(
        height: BM.getHeight(),
        distance: BM.getDistance(),
        axisX: BM.getAxisX(),
        axisY: BM.getAxisY(),
        axisZ: BM.getAxisZ(),
        battery: BM.getBattery(),
        camera: widget.camera,
        blueConnect: isConnected(),
      ),
    );
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        messages.add(
          _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(
                    0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        _messageBuffer = dataString.substring(index);
        // Class  BleMessage = BM
        BM.setMessage(dataString.substring(0, index));
        BM.printMessage();
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  void _sendMessage(String text) async {
    text = text.trim();
    textEditingController.clear();

    if (text.length > 0) {
      try {
        connection.output.add(utf8.encode(text + "\r\n"));
        await connection.output.allSent;

        setState(() {
          messages.add(_Message(clientID, text));
        });

        Future.delayed(Duration(milliseconds: 333)).then((_) {
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 333),
              curve: Curves.easeOut);
        });
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }

  bool isConnected() {
    return connection != null && connection.isConnected;
  }
}

class BlueParamitor extends StatefulWidget {
  final double height;
  final double distance;
  final double axisX;
  final double axisY;
  final double axisZ;
  final double battery;
  final CameraDescription camera;
  final bool blueConnect;
  const BlueParamitor(
      {Key? key, required this.camera,
      required this.height,
      required this.distance,
      required this.axisX,
      required this.axisY,
      required this.axisZ,
      required this.battery,
      required this.blueConnect,})
      : super(key: key);

  @override
  _BlueParamitorState createState() => _BlueParamitorState();
}

class _BlueParamitorState extends State<BlueParamitor> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          BlueTakePictureSide(
            height:widget.height,
            distance: widget.distance,
            axisX: widget.axisX,
            axisY: widget.axisY,
            axisZ: widget.axisZ,
            battery: widget.battery,
            blueConnect: widget.blueConnect,
            camera: widget.camera,
            localFront: "assets/images/SideLeftNavigation.png",
            localBack: "assets/images/SideRightNavigation.png",
          ),
          ShowBlueParamitor(blueConnection: widget.blueConnect,)
        ],
      ),
    );
  }
}

class ShowBlueParamitor extends StatefulWidget {
  final bool blueConnection;
  const ShowBlueParamitor({Key? key,required this.blueConnection}) : super(key: key);

  @override
  _ShowBlueParamitorState createState() => _ShowBlueParamitorState();
}

class _ShowBlueParamitorState extends State<ShowBlueParamitor> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 70, 20, 5),
      child: RotationTransition(
        turns: new AlwaysStoppedAnimation(90 / 360),
        child: Opacity(
          opacity: 0.6,
          child: Container(
            // margin:EdgeInsets.only(left: 30, top: 0, right: 30, bottom: 50),
            height: 150,
            width: 120,
            child: Center(
              child: Text(
                "Height = ${BM.getHeight()}\nDistance = ${BM.distance}\nAxisX = ${BM.axisY}\nAxisY = ${BM.axisY}\nAxisZ = ${BM.axisZ}\nBattery = ${BM.battery} % Connect = ${widget.blueConnection}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            decoration: BoxDecoration(
              border: ((BM.distance > 200 && BM.distance < 400) &&
                      (BM.axisY >= 80 && BM.axisY <= 90) &&
                      (BM.axisZ >= 180 && BM.axisZ <= 190))
                  ? Border.all(
                      color:
                          Colors.green, //                   <--- border color
                      width: 5.0,
                    )
                  : Border.all(
                      color: Colors.red, //                   <--- border color
                      width: 5.0,
                    ),
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// A screen that allows users to take a picture using a given camera.
class BlueTakePictureSide extends StatefulWidget {
  final double height;
  final double distance;
  final double axisX;
  final double axisY;
  final double axisZ;
  final double battery;
  final bool blueConnect;
  final CameraDescription camera;
  final String localFront;
  final String localBack;

  const BlueTakePictureSide(
      {Key? key,
      required this.height,
      required this.distance,
      required this.axisX,
      required this.axisY,
      required this.axisZ,
      required this.battery,
      required this.blueConnect,
      required this.camera,
      required this.localFront,
      required this.localBack})
      : super(key: key);

  @override
  BlueTakePictureSideState createState() => BlueTakePictureSideState();
}

class BlueTakePictureSideState extends State<BlueTakePictureSide>
    with SingleTickerProviderStateMixin {
  // camera
  late CameraController controller;
  late Future<void> _initializeControllerFuture;

  // กรอบภาพ
  bool showFront = true;
  bool showState = false;
  late AnimationController controllerAnimated;

  @override
  void initState() {
    super.initState();
   
    // To display the current output from the Camera,
    // create a CameraController.
    controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = controller.initialize();
    // Initialize the animation controller
    controllerAnimated = AnimationController(
        vsync: this, duration: Duration(milliseconds: 300), value: 0);
    
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ควบคุมขนาดของ CameraPreview
    final mediaSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ถ่ายภาพด้านข้างโค',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Phoenix.rebirth(context);
              },
              icon: Icon(Icons.home))
        ],
        backgroundColor: Color(hex.hexColor("#007BA4")),
      ),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: Center(
        child: ListView(children: [
          Stack(
            children: [
              FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If the Future is complete, display the preview.
                    return ClipRect(
                      clipper: _MediaSizeClipper(mediaSize),
                      child: Transform.scale(
                        scale: 1 /
                            (controller.value.aspectRatio *
                                mediaSize.aspectRatio),
                        alignment: Alignment.topCenter,
                        child: CameraPreview(controller),
                      ),
                    );
                  } else {
                    // Otherwise, display a loading indicator.
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              showState
                  ? Container()
                  : CattleNavigationLine(
                      front: widget.localFront,
                      back: widget.localBack,
                      imageHeight: 380,
                      imageWidth: 280,
                      showFront: showFront)
            ],
          ),
          Row(children: [
            Expanded(
                child: IconButton(
              onPressed: () async {
                // Flip the image
                await controllerAnimated.forward();
                setState(() => showFront = !showFront);
                await controllerAnimated.reverse();
              },
              icon: Icon(Icons.compare_arrows),
              color: Colors.white,
              iconSize: 40,
            )),
            Expanded(
              child: FloatingActionButton(
                // Provide an onPressed callback.
                onPressed: () async {
                  // Take the Picture in a try / catch block. If anything goes wrong,
                  // catch the error.
                  try {
                    // Ensure that the camera is initialized.
                    await _initializeControllerFuture;

                    // Attempt to take a picture and get the file `image`
                    // where it was saved.
                    final image = await controller.takePicture();
                    String imageName = DateTime.now().toString() + ".jpg";

                    // If the picture was taken, display it on a new screen.
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => BluePictureRef(
                                height: widget.height,
                                distance: widget.distance,
                                axisX: widget.axisX,
                                axisY: widget.axisY,
                                axisZ: widget.axisZ,
                                battery: widget.battery,
                                blueConnect: widget.blueConnect,
                                camera: widget.camera,
                                imgPath: image.path,
                                fileName: imageName,
                              )),
                    );
                  } catch (e) {
                    // If an error occurs, log the error to the console.
                    print(e);
                  }
                },
                child: const Icon(Icons.camera_alt),
              ),
            ),
            Expanded(
                child: IconButton(
              onPressed: () {
                setState(() => showState = !showState);
              },
              //Icons.compare_outlined
              // Icons.browser_not_supported
              icon: Icon(Icons.compare_outlined),
              color: Colors.white,
              iconSize: 40,
            )),
          ]),
        ]),
      ),
    );
  }
}

// widget ที่ใช้ควมคุมการแสดง camera preview ให้เต็มหน้าจอ
class _MediaSizeClipper extends CustomClipper<Rect> {
  final Size mediaSize;
  const _MediaSizeClipper(this.mediaSize);
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, mediaSize.width, mediaSize.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}

