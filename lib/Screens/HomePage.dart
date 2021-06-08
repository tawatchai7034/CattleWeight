import 'package:flutter/material.dart';
import 'ProfileBox.dart';
import 'package:cattle_weight/DataBase/ProfileDB.dart';
import 'package:cattle_weight/convetHex.dart';
import 'CattleBox.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ConvertHex hex = new ConvertHex();
  List<ProfileDB> profile = [
    ProfileDB(01, "cattle01", "male", "Brahman", "assets/images/cattle01.jpg"),
    ProfileDB(02, "cattle02", "female", "Brahman", "assets/images/cattle02.jpg"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color(hex.hexColor("#007BA4")),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(hex.hexColor("#FFC909")),
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
