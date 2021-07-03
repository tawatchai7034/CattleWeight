// หน้าเลือกภาพที่จะนำไปใช้คำนวณน้ำหนัก
import 'package:cattle_weight/Screens/Widgets/PictureCamera.dart';
import 'package:cattle_weight/Screens/Widgets/PictureGallory.dart';
import 'package:cattle_weight/model/MediaSource.dart';
import 'package:flutter/material.dart';
import 'package:cattle_weight/convetHex.dart';

ConvertHex hex = new ConvertHex();

class SelectInput extends StatelessWidget {
  const SelectInput({Key? key}) : super(key: key);

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
            height: 10,
          ),
          CameraButton(),
          Center(
              child: Image.asset("assets/images/photo01.png",
                  height: 240, width: 240, fit: BoxFit.cover)),
          SizedBox(
            height: 10,
          ),
          GalloryButton(),
        ],
      ),
      backgroundColor: Color(hex.hexColor("#47B5BE")),
    );
  }
}