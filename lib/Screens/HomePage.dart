import 'package:flutter/material.dart';
import 'ProfileBox.dart';
import 'package:cattle_weight/DataBase/ProfileDB.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ProfileDB> profile = [
    ProfileDB(01, "cattle01", "male", "Brahman","assets/images/cattle01.jpg"),
    ProfileDB(02, "cattle02", "female", "Brahman","assets/images/cattle02.jpg"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: 
        ///ฝึกสร้าง ListView ใช้แสดงรายการจำนวนมาก
          ListView.builder(

              ///listView จะแสดงรายการให้อย่างไม่มีสิ้นสุดแต่สามารถกำหนดจำนวนได้ด้วย itemCount
              itemCount: profile.length,
              itemBuilder: (BuildContext context, int index) {
                ///เรียกข้อมูลจาก database ที่เก็บรายการอาหารมาแสดงผล
                ProfileDB listProfile = profile[index];
                return ListTile(
                    leading: Image.asset(
                      listProfile.img,
                      height: 180,
                      width: 200,
                      colorBlendMode: BlendMode.darken,
                      fit: BoxFit.fitWidth,
                    ),
                    subtitle:
                        Text("Cattle number ${listProfile.cattleNumber}"),
                    title: Text(
                      listProfile.cattleName,
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: (){
                      // print("เมนู\t"+listFood.name+"\tราคา\t"+listFood.price);
                    },);
              }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
