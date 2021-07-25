import 'package:camera/camera.dart';
import 'package:cattle_weight/Screens/Pages/ABC.dart';
import 'package:cattle_weight/Screens/Pages/BluetoothPage.dart';
import 'package:cattle_weight/Screens/Pages/SelectPicture.dart';
import 'package:cattle_weight/Screens/Widgets/Search.dart';
import 'package:flutter/material.dart';
import 'package:cattle_weight/Screens/Widgets/ProfileBox.dart';
import 'package:cattle_weight/DataBase/ProfileDB.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'ConDevice.dart';
import 'FirstPage.dart';

// class ที่ใช้ในการแปลงค่าสีจากภายนอกมาใช้ใน flutter
ConvertHex hex = new ConvertHex();

// widget ที่แสดงส่วนของ card widget ที่ภายในจะประกอบด้วยข้อมูลโปรไฟล์ของโคแต่ละตัว
class MyHomePage extends StatefulWidget {
  final CameraDescription camera;
  MyHomePage({Key? key,required this.camera}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> cities = [];

//  สร้าง DateBase จำลองขึ้นมา
  List<ProfileDB> profile = [
    ProfileDB(01, "cattle01", "male", "Brahman", "assets/images/cattle01.jpg"),
    ProfileDB(
        02, "cattle02", "female", "Brahman", "assets/images/cattle02.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cattle Weight",style: TextStyle(fontFamily: "boogaloo",fontSize: 24, ),),
 
        backgroundColor: Color(hex.hexColor("#007BA4")),
        // search icon
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
              icon: Icon(Icons.search)),
               IconButton(
              onPressed: () {
                Phoenix.rebirth(context);
              },
              icon: Icon(Icons.home))
        ],
      ),
      // drawer: Drawer(),
      body: ListView.separated(
          // สร้าง card widget ตามจำนวนโคที่อยู่ใน dataBase
          itemBuilder: (BuildContext context, int index) {
            ProfileDB listProfile = profile[index];
            return ProfileBox(
              cattleNumber: listProfile.cattleNumber,
              cattleName: listProfile.cattleName,
              gender: listProfile.gender,
              specise: listProfile.specise,
              img: listProfile.img,
              camera: widget.camera,
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: profile.length),
    );
  }
}

class TapbarView extends StatefulWidget {
  final CameraDescription camera;
  const TapbarView({Key? key,required this.camera}) : super(key: key);

  @override
  _TapbarViewState createState() => _TapbarViewState();
}

// widget ที่แสดงส่วนของ TapฺBarView โดยดึงข้อมูลมาจาก MyHomePage
class _TapbarViewState extends State<TapbarView> {
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
            MyHomePage(camera: widget.camera,),
            // ConNextDevice(),
            // FlutterBlueApp(),
            TestBluetooth(),
            SelectInput(widget.camera)
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            // ตั้งค่าเมนูภายใน  TapBar View
            Tab(icon: Icon(Icons.list), text: "ประวัติ"),
            Tab(icon: Icon(Icons.device_unknown), text: "ทดสอบอุปกรณ์"),
            Tab(
              icon: Icon(Icons.add),
              text: "เพิ่มโค",
            ),
          ],
        ),
      ),
    );
  }
}


