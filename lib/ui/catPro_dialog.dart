// @dart=2.9
import 'package:flutter/material.dart';
import 'package:cattle_weight/DataBase/dbHelper.dart';
import 'package:cattle_weight/model/catProfiles.dart';

class CattleProDialog {
  final txtName = TextEditingController();
  final txtSpecies = TextEditingController();

  Widget buildDialog(BuildContext context, CattlePro catPro, bool isNew) {
    DbHelper dbHelper = DbHelper();
    if (!isNew) {
      txtName.text = catPro.name;
      txtSpecies.text = catPro.species.toString();
    }
    return AlertDialog(
        title: Text((isNew) ? 'New shopping list' : 'Edit shopping list'),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        content: SingleChildScrollView(
          child: Column(children: <Widget>[
            TextField(
                controller: txtName,
                decoration: InputDecoration(hintText: 'Cattle Name')),
            TextField(
              controller: txtSpecies,
              // keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(hintText: 'Species of cattle'),
            ),
            RaisedButton(
              child: Text('Save Shopping List'),
              onPressed: () {
                dbHelper.insertCatPro(CattlePro(name: 'cattle02',gender:true,species:'barhman')).then((value) {
                  print("add data completed");
                }).onError((error, stackTrace) {
                  print("Error: " + error.toString());
                });
                // catPro.name = txtName.text;
                // catPro.species = txtSpecies.text;
                // helper.insertCatPro(catPro);
                // Navigator.pop(context);
              },
            ),
          ]),
        ));
  }
}
