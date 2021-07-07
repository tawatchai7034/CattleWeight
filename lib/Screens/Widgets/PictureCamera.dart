import 'dart:io';
import 'dart:math' as Math;
import 'package:cattle_weight/Screens/Pages/SetHarthWidth.dart';
import 'package:cattle_weight/Screens/Widgets/preview.dart';
import 'package:flutter/material.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:cattle_weight/model/MediaSource.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';

ConvertHex hex = new ConvertHex();

// reference
// camera :
//  - https://youtu.be/BAgLOAGga2o
//  - https://flutter.dev/docs/cookbook/plugins/picture-using-camera
// กรอบภาพช่วยจัดตำแหน่งโค
//  - https://alex.domenici.net/archive/rotate-and-flip-an-image-in-flutter-with-or-without-animations
// วิธีใช้ stack widget
//  - https://api.flutter.dev/flutter/widgets/Stack-class.html

class CameraButton extends StatefulWidget {
  const CameraButton({Key? key}) : super(key: key);

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
              mainCamera();
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
        ));
  }

// image_picker
  Future pickCameraMedia(BuildContext context) async {
    final source = ModalRoute.of(context)!.settings.arguments as MediaSource;

    final getMedia = source == MediaSource.image
        ? ImagePicker().getImage
        : ImagePicker().getVideo;

    final media = await getMedia(source: ImageSource.camera);
    final file = File(media!.path);

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SetHarthWidth(file)));
  }
}

Future<void> mainCamera() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        // Pass the appropriate camera to the TakePictureScreen widget.
        camera: firstCamera,
      ),
    ),
  );
}

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen>
    with SingleTickerProviderStateMixin {
  // camera
  late CameraController controller;
  late Future<void> _initializeControllerFuture;

  // กรอบภาพ
  late Image cardFront;
  late Image cardBack;
  bool showFront = true;
  late AnimationController controllerAnimated;

  @override
  void initState() {
    super.initState();
    // ตำแหน่งของกรอบภาพ
    cardFront = Image.asset(
      "assets/images/SideLeftNavigation.png",
      height: 380,
      width: 280,
      fit: BoxFit.cover,
    );
    cardBack = Image.asset(
      "assets/images/SideRightNavigation.png",
      height: 380,
      width: 280,
      fit: BoxFit.cover,
    );

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

// animeted
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(cardFront.image, context);
    precacheImage(cardBack.image, context);
  }

  @override
  Widget build(BuildContext context) {
    // ควบคุมขนาดของ CameraPreview
    final mediaSize = MediaQuery.of(context).size;
   
    return Scaffold(
      appBar: AppBar(title: const Text('ถ่ายภาพโค')),
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
                        scale: 1 / (controller.value.aspectRatio * mediaSize.aspectRatio),
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
              AnimatedBuilder(
                animation: controllerAnimated,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.rotationX(
                        (controllerAnimated.value) * Math.pi / 2),
                    alignment: Alignment.center,
                    child: Container(
                      height: MediaQuery.of(context).size.height - 200,
                      margin: EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      child: showFront ? cardFront : cardBack,
                    ),
                  );
                },
              ),
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
                    icon: Icon(Icons.circle_outlined))),
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
                    String imageName = DateTime.now().toString()+".jpg";


                    // If the picture was taken, display it on a new screen.
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                        PreviewScreen(imgPath: image.path, fileName: imageName)
                        //  DisplayPictureScreen(
                        //   // Pass the automatically generated path to
                        //   // the DisplayPictureScreen widget.
                        //   imagePath: image.path,
                        // ),
                      ),
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
                    onPressed: () {}, icon: Icon(Icons.dangerous_outlined)))
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


