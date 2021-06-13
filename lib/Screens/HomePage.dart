import 'package:cattle_weight/Screens/Search.dart';
import 'package:flutter/material.dart';
import 'ProfileBox.dart';
import 'package:cattle_weight/DataBase/ProfileDB.dart';
import 'package:cattle_weight/convetHex.dart';
import 'CattleBox.dart';

  ConvertHex hex = new ConvertHex();
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  List<ProfileDB> profile = [
    ProfileDB(01, "cattle01", "male", "Brahman", "assets/images/cattle01.jpg"),
    ProfileDB(
        02, "cattle02", "female", "Brahman", "assets/images/cattle02.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color(hex.hexColor("#007BA4")),
        // search icon
        actions: [
          IconButton(onPressed: (){
            // รอ ฟังชันก์
            // showSearch(context: context,delegate: Search());
          }, icon: Icon(Icons.search))
        ],
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            ProfileDB listProfile = profile[index];
            return CattleBox(
              cattleNumber: listProfile.cattleNumber,
              cattleName: listProfile.cattleName,
              gender: listProfile.gender,
              specise: listProfile.specise,
              img: listProfile.img,
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: profile.length),
    );
  }
}

class TapbarView extends StatefulWidget {
  const TapbarView({ Key? key }) : super(key: key);

  @override
  _TapbarViewState createState() => _TapbarViewState();
}

class _TapbarViewState extends State<TapbarView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        ///จำนวนเมนู
        length: 2,
        child: Scaffold(
          backgroundColor: Color(hex.hexColor('#FFC909')),

          ///กำหนดให้แต่ละ tapBar แสดงอะไร
          body: TabBarView(
            children: [
              // หน้าแอปที่ต้องการให้ทำงานเมื่อกดเมนู
              MyHomePage(title: "Cattle Weight"),
              MyHomePage(title: "Cattle Weight")
            ],
          ),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.add),
                text:"เพิ่มโค",
              ),
              Tab(
                 icon: Icon(Icons.bar_chart_rounded),
               text: "อัตราการเจริญเติบโต")
            ],
          ),
        ),
      );
  }
}
