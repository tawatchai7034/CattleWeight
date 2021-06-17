import 'package:cattle_weight/Screens/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:cattle_weight/convetHex.dart';
import 'package:cattle_weight/DataBase/CattleDB.dart';

ConvertHex hex = new ConvertHex();

class MenuOption extends StatefulWidget {
  const MenuOption({Key? key}) : super(key: key);

  @override
  _MenuOptionState createState() => _MenuOptionState();
}

class _MenuOptionState extends State<MenuOption> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
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

class ProfileBox extends StatelessWidget {
  late int cattleNumber;
  late String cattleName;
  late String gender;
  late String specise;
  late String img;
  late double heartGirth;
  late double bodyLenght;
  late double weight;
  ProfileBox({
    required this.cattleNumber,
    required this.cattleName,
    required this.gender,
    required this.specise,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      // แสดงภาพโค
      leading: Image.asset(img, height: 80, width: 110, fit: BoxFit.fill),
      // แสดงชื่อโค
      title: Text(cattleName),
      // แสดงรายละเอียดต่างๆ
      subtitle: Text(
          'Cattle number: $cattleNumber \nGender : $gender \nSpecise : $specise'),
      trailing: MenuOption(),
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CattleProfilPage(title: cattleName,)));
      },
    ));
  }
}

class DeleteOption extends StatelessWidget {
  const DeleteOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete"),
        backgroundColor: Color(hex.hexColor("#007BA4")),
      ),
      body: Center(
        child: Text("Delete page"),
      ),
    );
  }
}

class EditOption extends StatelessWidget {
  const EditOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
        backgroundColor: Color(hex.hexColor("#007BA4")),
      ),
      body: Center(
        child: Text("Edit page"),
      ),
    );
  }
}
