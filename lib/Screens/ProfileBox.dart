import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../convetHex.dart';

class ProfileBox extends StatefulWidget {

  const ProfileBox({ Key? key,required this.title,required this.weight,required this.colors,required this.sizes }) : super(key: key);

  final String title;///คำอธิบาย
  final double weight;///จำนวนเงิน
  final String colors;///สีของ Container
  final double sizes;///ขนาดของ Container


  @override
  _ProfileBoxState createState() => _ProfileBoxState();
}

class _ProfileBoxState extends State<ProfileBox> {
    

  ConvertHex hex = new ConvertHex();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                  color: Color(hex.hexColor(widget.colors)),
                  borderRadius: BorderRadius.circular(20)),

              ///ต้องกำหนดขนาดจึงจะแสดงผล
              height: widget.sizes,
              ///width: 100,
              child: Row(
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: 20, color: Color(hex.hexColor('ffffff'))),
                  ),
                  ///Expanded เป็นส่วนขยายความกว้างของ child widget
                  Expanded(
                      child: Text(
                        ///ใช้ intl จัดรูปแบบการแสดงผลตัวเลข
                    '${NumberFormat("#,###.##").format(widget.weight)}',
                    style: TextStyle(
                        fontSize: 20, color: Color(hex.hexColor("ffffff"))),
                        ///ให้ข้อความชิดขวา
                        textAlign: TextAlign.right,
                  )),
                ],
              ),
      
    );
  }
}