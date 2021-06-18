import 'package:flutter/material.dart';
import 'package:cattle_weight/convetHex.dart';
import 'CattleBox.dart';
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
        actions: [MenuBar_View()],
      ),
      body: ListView(children: [
        // นำภาพมาแสดงผล
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
        SizedBox(
          height: 15,
        ),
        Container(
          child: ListTile(
            title: Text(
              cattleName,
              style: TextStyle(fontSize: 20),
            ),
            // แสดงรายละเอียดต่างๆ
            subtitle: Text(
              'Cattle number: ${cattleNumber} \nGender : ${gender} \nSpecise : ${specise} \nHeart girth : ${heartGirth} \nBody width : ${bodyLenght} \nWeight : ${weight}',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        SizedBox(
          height: 120,
        ),
        // ปุ่มบันทึกหน้าจอ
        Container(
          height: 60,
            child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: new RaisedButton(
            onPressed: () {print("บันทึกหน้าจอ");},
            child: Text(
              "บันทึกหน้าจอ",
              style:
                  TextStyle(fontSize: 20, color: Color(hex.hexColor("ffffff"))),
            ),
            color: Color(hex.hexColor("#FAA41B")),
            // สีปุ่มเมื่อกด
            splashColor: Color(hex.hexColor("#FFC909")),
            // กำหนดรูปร่างของปุ่ม
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0),
              // side: BorderSide(color: Colors.black),
            ),
          ),
        )),
      ]),
    );
  }
}

class MenuBar_View extends StatelessWidget {
  const MenuBar_View ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: Icon(Icons.menu),
        // เมื่อเลือกเมนูแล้วจะส่งไปทำงานที่หังก์ชัน onSelected
        onSelected: (item) => onSelected(context, item),
        itemBuilder: (context) => [
              PopupMenuItem<int>(
                  value: 0,
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text("Delete"),
                  )),
              PopupMenuItem<int>(
                  value: 1,
                  child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text("Edit"),
                  ))
            ]);
  }
}

void onSelected(BuildContext context, int item) {
  switch (item) {
    case 0:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => DeleteOption()));
      break;
    case 1:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => EditOption()));
      break;
  }
}




