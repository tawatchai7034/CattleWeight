import 'package:cattle_weight/DataBase/CattleDB.dart';
import 'package:cattle_weight/DataBase/ProfileDB.dart';
import 'package:cattle_weight/Screens/AddProfile.dart';
import 'package:cattle_weight/Screens/HomePage.dart';
import 'package:cattle_weight/Screens/ProfileBox.dart';
import 'package:flutter/material.dart';
import 'CattleBox.dart';
import 'package:cattle_weight/convetHex.dart';
import 'ChartPage.dart';

ConvertHex hex = new ConvertHex();

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<CattleDB> cattle = [
    CattleDB("01", "cattle01", "male", "Brahman", "assets/images/cattle01.jpg",
        10, 20, 30),
    CattleDB("01", "cattle01", "male", "Brahman", "assets/images/cattle01.jpg",
        20, 30, 40),
    CattleDB("01", "cattle01", "male", "Brahman", "assets/images/cattle01.jpg",
        30, 40, 50),
    CattleDB("01", "cattle01", "male", "Brahman", "assets/images/cattle01.jpg",
        20, 30, 40),
    CattleDB("01", "cattle01", "male", "Brahman", "assets/images/cattle01.jpg",
        20, 30, 40),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color(hex.hexColor("#007BA4")),
      ),
      body: ListView.separated(
          // สร้าง card widget ตามจำนวนโคที่อยู่ใน dataBase
          itemBuilder: (BuildContext context, int index) {
            CattleDB listCattle = cattle[index];
            return CattleBox(
              cattleNumber: listCattle.cattleNumber,
              cattleName: listCattle.cattleName,
              gender: listCattle.gender,
              specise: listCattle.specise,
              img: listCattle.img,
              heartGirth: listCattle.heartGirth,
              bodyLenght: listCattle.bodyLenght,
              weight: listCattle.weight,
            );
            // CattleBox(
            //     cattleNumber: listCattle.cattleNumber,
            //     cattleName: listCattle.cattleName,
            //     gender: listCattle.gender,
            //     specise: listCattle.specise,
            //     img: listCattle.img,
            //     heartGirth: listCattle.heartGirth,
            //     bodyLenght: listCattle.bodyLenght,
            //     weight: listCattle.weight);
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: cattle.length),
    );
  }
}

class TapbarView_Profile extends StatefulWidget {
  const TapbarView_Profile({Key? key}) : super(key: key);

  @override
  _TapbarView_ProfileState createState() => _TapbarView_ProfileState();
}

// widget ที่แสดงส่วนของ TapฺBarView โดยดึงข้อมูลมาจาก MyHomePage
class _TapbarView_ProfileState extends State<TapbarView_Profile> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      ///จำนวนเมนู
      length: 3,
      child: Scaffold(
        backgroundColor: Color(hex.hexColor('#FFC909')),

        ///กำหนดให้แต่ละ tapBar แสดงอะไร
        body: TabBarView(
          children: [
            // หน้าแอปที่ต้องการให้ทำงานเมื่อกดเมนู
            ProfilePage(),
            CattleVegetative(),
            AddProfile()
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            // ตั้งค่าเมนูภายใน  TapBar View
            Tab(icon: Icon(Icons.list), text: "ประวัติโค"),
            Tab(
                icon: Icon(Icons.bar_chart_rounded),
                text: "อัตราการเจริญเติบโต"),
            Tab(
              icon: Icon(Icons.add),
              text: "เพิ่มประวัติโค",
            ),
          ],
        ),
      ),
    );
  }
}
