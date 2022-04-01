import 'dart:io';
import 'package:cattle_weight/Bluetooth/BlueMassgae.dart';
import 'package:cattle_weight/Screens/Pages/CameraSolutions/AddProfile.dart';
import 'package:cattle_weight/Screens/Pages/CameraSolutions/PictureRef.dart';
import 'package:cattle_weight/Screens/Pages/CameraSolutions/PictureRefRear.dart';
import 'package:cattle_weight/Screens/Pages/CameraSolutions/PictureTW.dart';
import 'package:cattle_weight/Screens/Pages/SelectPicture.dart';
import 'package:cattle_weight/Screens/Widgets/CattleNavigationLine.dart';
import 'package:cattle_weight/Screens/Widgets/preview.dart';
import 'package:cattle_weight/main.dart';
import 'package:flutter/material.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:cattle_weight/model/MediaSource.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';

ConvertHex hex = new ConvertHex();

// Messege Management
BleMessage BM = new BleMessage();

// reference
// camera :
//  - https://youtu.be/BAgLOAGga2o
//  - https://flutter.dev/docs/cookbook/plugins/picture-using-camera

// วิธีใช้ stack widget
//  - https://api.flutter.dev/flutter/widgets/Stack-class.html

class CameraButton extends StatefulWidget {
  final CameraDescription camera;
  const CameraButton(this.camera);

  @override
  _CameraButtonState createState() => _CameraButtonState();
}

class _CameraButtonState extends State<CameraButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 240,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: new RaisedButton(
          onPressed: () {
            // RestartWidget.restartApp(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddProfile()));
            //  Phoenix.rebirth(context);
            // mainCamera();
            // pickCameraMedia(context);
          },
          child: Text("ถ่ายภาพ",
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
    );
  }

// image_picker
  Future pickCameraMedia(BuildContext context) async {
    final source = ModalRoute.of(context)!.settings.arguments as MediaSource;

    final getMedia = source == MediaSource.image
        ? ImagePicker().getImage
        : ImagePicker().getVideo;

    final media = await getMedia(source: ImageSource.camera);
    final file = File(media!.path);

    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => SetHarthWidth(file)));
  }
}

// A screen that allows users to take a picture using a given camera.
class TakePictureRear extends StatefulWidget {
  final bool blueConnection;
  final CameraDescription camera;
  final String localFront;
  final String localBack;

  const TakePictureRear(
      {Key? key,
      required this.blueConnection,
      required this.camera,
      required this.localFront,
      required this.localBack})
      : super(key: key);

  @override
  TakePictureRearState createState() => TakePictureRearState();
}

class TakePictureRearState extends State<TakePictureRear>
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
          'ถ่ายภาพโคด้านหลังโค',
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
                      showFront: showFront),
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
                          builder: (context) => PictureRef2(
                                // camera: widget.camera,
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
