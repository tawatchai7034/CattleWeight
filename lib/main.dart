// @dart=2.9
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:cattle_weight/Screens/Pages/FirstPage.dart';
import 'package:cattle_weight/Screens/Widgets/PictureCamera.dart';
import 'package:cattle_weight/Screens/Widgets/RestartApp.dart';
import 'package:cattle_weight/Screens/Widgets/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:cattle_weight/Screens/Pages/HomePage.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'convetHex.dart';
import 'package:cattle_weight/Screens/Pages/FirstPage.dart';


ConvertHex hex = new ConvertHex();

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // Obtain a list of the available cameras on the device.
//   final cameras = await availableCameras();
//   runApp(MyApp(cameras: cameras));
// }

// class MyApp extends StatelessWidget {
//   final List<CameraDescription> cameras;
//   const MyApp({Key key, this.cameras}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Camera App',
//       home: CameraScreen(cameras: cameras,),
//     );
//   }
// }


void main() async   {
 // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp( Phoenix(child: new MyApp(firstCamera)));
}

class MyApp extends StatelessWidget {
   final CameraDescription camera;

  const MyApp(this.camera);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // กำหนด font เริ่มต้น
          fontFamily: 'TH-Niramit-AS',
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: 
        // CameraScreen(cameras: cameras)
        FisrtPage(camera)
        );
  }
}
