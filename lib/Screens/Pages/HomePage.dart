import 'package:camera/camera.dart';
import 'package:cattle_weight/Bluetooth/MainPage.dart';
import 'package:cattle_weight/Screens/Pages/SelectPicture.dart';
import 'package:cattle_weight/Screens/Widgets/Search.dart';
import 'package:cattle_weight/model/catProfiles.dart';
import 'package:flutter/material.dart';
import 'package:cattle_weight/Screens/Widgets/ProfileBox.dart';
import 'package:cattle_weight/DataBase/ProfileDB.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:cattle_weight/DataBase/dbHelper.dart';
import 'package:cattle_weight/ui/catPro_dialog.dart';

// class ที่ใช้ในการแปลงค่าสีจากภายนอกมาใช้ใน flutter
ConvertHex hex = new ConvertHex();

// widget ที่แสดงส่วนของ card widget ที่ภายในจะประกอบด้วยข้อมูลโปรไฟล์ของโคแต่ละตัว
class HistoryList extends StatefulWidget {
  final CameraDescription camera;
  HistoryList({Key? key, required this.camera}) : super(key: key);

  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  List<String> cities = [];
  DbHelper dbHelper = new DbHelper();
  CattleProDialog dialog = new CattleProDialog();
  List<CattlePro>? catProList;

//  สร้าง DateBase จำลองขึ้นมา
  List<ProfileDB> profile = [
    ProfileDB(01, "cattle01", "male", "Brahman", "assets/images/cattle01.jpg"),
    ProfileDB(
        02, "cattle02", "female", "Brahman", "assets/images/cattle02.jpg"),
  ];

  @override
  void initState() {
    dialog = CattleProDialog();
    loadData();
    super.initState();
  }

 loadData() async {
   await dbHelper.initDatabase();
    catProList =await dbHelper.getListCattlePro();
    setState(() {
      catProList = catProList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cattle Weight",
          style: TextStyle(
            fontFamily: "boogaloo",
            fontSize: 24,
          ),
        ),

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
      body: ListView.builder(
        itemCount: (CattlePro != null)? catProList?.length:0,
        itemBuilder: (BuildContext context,int index){
        return ListTile(title: Text(catProList![index].name),
        subtitle: Text("gender: ${catProList![index].gender}\tspicies: ${catProList![index]..species}"),
        trailing: IconButton(icon:Icon( Icons.edit),onPressed: (){},)
        );
      }),
      // ListView.separated(
      //     // สร้าง card widget ตามจำนวนโคที่อยู่ใน dataBase
      //     itemBuilder: (BuildContext context, int index) {
      //       ProfileDB listProfile = profile[index];
      //       return ProfileBox(
      //         cattleNumber: listProfile.cattleNumber,
      //         cattleName: listProfile.cattleName,
      //         gender: listProfile.gender,
      //         specise: listProfile.specise,
      //         img: listProfile.img,
      //         camera: widget.camera,
      //       );
      //     },
      //     separatorBuilder: (BuildContext context, int index) =>
      //         const Divider(),
      //     itemCount: profile.length),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dbHelper
              .insertCatPro(CattlePro(name: 'cattle02',gender:true,species:'barhman'))
              .then((value) {
            print("add data completed");
          }).onError((error, stackTrace) {
            print("Error: " + error.toString());
          });
          // showDialog(
          //   context: context,
          //   builder: (BuildContext context) =>
          //       dialog.buildDialog(context, CattlePro(000, '', true, ''), true),
          // );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class CattleHistory extends StatefulWidget {
  final CameraDescription camera;
  const CattleHistory({Key? key, required this.camera}) : super(key: key);

  @override
  _CattleHistoryState createState() => _CattleHistoryState();
}

// widget ที่แสดงส่วนของ TapฺBarView โดยดึงข้อมูลมาจาก MyHomePage
class _CattleHistoryState extends State<CattleHistory> {
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
            HistoryList(
              camera: widget.camera,
            ),
            BlueMainPage(
              camera: widget.camera,
            ),
            // DiscoveryPage(),
            // TimeCounter(),
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
