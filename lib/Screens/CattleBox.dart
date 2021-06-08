import 'package:flutter/material.dart';
import 'package:cattle_weight/convetHex.dart';

class CattleBox extends StatelessWidget {
  late int cattleNumber;
  late String cattleName;
  late String gender;
  late String specise;
  late String img;
  CattleBox({required this.cattleNumber,required this.cattleName,required this.gender,required this.specise,required this.img}) ;

  ConvertHex hex = new ConvertHex();

  @override
  Widget build(BuildContext context) {
    return Card( 
      child: ListTile(
        leading: Image.asset(img,height: 80,width: 110,fit: BoxFit.fill),
        title: Text(cattleName),
        subtitle: Text('cattle number : $cattleNumber \nGender : $gender \nSpecise : $specise'),
        trailing: Icon(Icons.more_vert),
      ));
  }
}

