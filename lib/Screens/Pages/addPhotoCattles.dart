// หน้าเลือกภาพที่จะนำไปใช้คำนวณน้ำหนัก
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cattle_weight/Camera/camera_screen.dart';
import 'package:cattle_weight/DataBase/catImage_handler.dart';
import 'package:cattle_weight/Screens/Pages/BlueAndCameraSolution/BluetoothPage.dart';
import 'package:cattle_weight/Screens/Pages/catImage_screen.dart';
import 'package:cattle_weight/Screens/Widgets/MainButton.dart';
import 'package:cattle_weight/Screens/Pages/GallorySolutions/AddProfile.dart';
import 'package:cattle_weight/model/image.dart';
import 'package:cattle_weight/model/imageNavidation.dart';
import 'package:cattle_weight/model/utility.dart';
import 'package:flutter/material.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:image_picker/image_picker.dart';

ConvertHex hex = new ConvertHex();

class AddPhotoCattles extends StatefulWidget {
  final int idPro;
  final int idTime;

  const AddPhotoCattles({required this.idPro, required this.idTime});

  @override
  State<AddPhotoCattles> createState() => _AddPhotoCattlesState();
}

class _AddPhotoCattlesState extends State<AddPhotoCattles> {
  late Future<File> imageFile;

  late Image image;
  

  CatImageHelper? ImageHelper;

  late List<ImageModel> images;
    ImageNavidation line = new ImageNavidation();

  @override
  void initState() {
    super.initState();
    images = [];
    ImageHelper = CatImageHelper();
    refreshImages();
  }

  refreshImages() {
    ImageHelper!.getCatTimePhotos(widget.idTime).then((imgs) {
      setState(() {
        images.clear();
        images.addAll(imgs);
      });
    });
  }

  final picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    final pickedImage =
        await picker.getImage(source: ImageSource.gallery).then((imgFile) {
      if (imgFile == null) {
        Navigator.pop(context);
      } else {
        final file = File(imgFile.path);
        String imgString = Utility.base64String(file.readAsBytesSync());
        ImageModel photo = ImageModel(
            idPro: widget.idPro, idTime: widget.idTime, imagePath: imgString);
        ImageHelper!.save(photo);
        refreshImages();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                CatImageScreen(idPro: widget.idPro, idTime: widget.idTime)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
              child: Image.asset("assets/images/camera01.png",
                  height: 240, width: 240, fit: BoxFit.cover)),
          SizedBox(
            height: 5,
          ),
          // ปุ่มถ่ายภาพ
          MainButton(
              onSelected: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CameraScreen(
                          idPro: widget.idPro,
                          idTime: widget.idTime,
                          localFront: line.sideLeft,
                          localBack: line.sideRight
                        )));
              },
              title: "ถ่ายภาพ"),
          Center(
              child: Image.asset("assets/images/photo01.png",
                  height: 240, width: 240, fit: BoxFit.cover)),
          SizedBox(
            height: 5,
          ),
          MainButton(
              onSelected: () {
                pickImageFromGallery();
              },
              title: "นำเข้าภาพ"),
        ],
      ),
      backgroundColor: Color(hex.Blue()),
    );
  }
}
