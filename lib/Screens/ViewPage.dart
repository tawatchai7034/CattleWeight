import 'package:flutter/material.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

// class ที่ใช้ในการแปลงค่าสีจากภายนอกมาใช้ใน flutter
ConvertHex hex = new ConvertHex();
class CattleData extends StatelessWidget {
  final String cattleNumber;
  final String cattleName;
  final String gender;
  final String specise;
  final String img1;
  final String img2;
  final String img3;
  final double heartGirth;
  final double bodyLenght;
  final double weight;

  CattleData(
      this.cattleNumber,
      this.cattleName,
      this.gender,
      this.specise,
      this.img1,
      this.img2,
      this.img3,
      this.heartGirth,
      this.bodyLenght,
      this.weight);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cattleName),
        backgroundColor: Color(hex.hexColor("#007BA4")),
      ),
      body: ListView(children: [
        ImageSlideshow(
          width: double.infinity,
          height: 200,
          initialPage: 0,
          indicatorColor: Color(hex.hexColor("#FAA41B")),
          indicatorBackgroundColor: Colors.grey,
          children: [
            Image.asset(img1, fit: BoxFit.cover),
            Image.asset(img2, fit: BoxFit.cover),
            Image.asset(img3, fit: BoxFit.cover)
          ],
        ),
        Container(
            child: 
            ListTile(
              title: Text(cattleName,style: TextStyle(fontSize: 30),),
              // แสดงรายละเอียดต่างๆ
              subtitle: Text(
                  'Cattle number: ${cattleNumber} \nGender : ${gender} \nSpecise : ${specise} \nHeart girth : ${heartGirth} \nBody width : ${bodyLenght} \nWeight : ${weight}'
                  ,style: TextStyle(fontSize: 25),),
            ),
            ),
      ]),
    );
  }
}
