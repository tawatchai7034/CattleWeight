import 'package:flutter/material.dart';
import 'package:cattle_weight/convetHex.dart';

// class ที่ใช้ในการแปลงค่าสีจากภายนอกมาใช้ใน flutter
ConvertHex hex = new ConvertHex();
final formKey = GlobalKey<FormState>();

class AddProfile extends StatelessWidget {
  ///controller ใช้ดึงข้อมูลที่กรอกเข้ามา (Input)
  final titleController = TextEditingController(); //รับค่าชื่อรายการ
  final amountController = TextEditingController(); //รับตัวเลขจำนวนเงิน

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Profile",
          style: TextStyle(fontSize: 24, fontFamily: 'boogaloo'),
        ),
        backgroundColor: Color(hex.hexColor("#007BA4")),
      ),
      body: ListView(
        children: [
          Center(
            child: Image.asset("assets/images/IconApp.jpg",
                height: 240, width: 360, fit: BoxFit.cover),
          ),
          MyCustomForm()
        ],
      ),
      backgroundColor: Color(hex.hexColor("ffffff")),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  String dropdownGender = 'กรุณาเลือกเพศ';
  String dropdownSpecise = 'กรุณาเลือกสายพันธุ์โค';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // ระบุชื่อโค
        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'กรุณาระบุชื่อโค',
              labelText: 'ชื่อโค',
            ),
          ),
        ),
        // เลือกเพศ
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(children: [
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: dropdownGender,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 80,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    width: 100,
                    color: Colors.black,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownGender = newValue!;
                      print(dropdownGender);
                    });
                  },
                  items: <String>['กรุณาเลือกเพศ', 'เพศผู้', 'เพศเมีย']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ]),
        ),
        // เลือกสายพันธุ์โค
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(children: [
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: dropdownSpecise,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 80,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    width: 100,
                    color: Colors.black,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownSpecise = newValue!;
                      print(dropdownSpecise);
                    });
                  },
                  items: <String>['กรุณาเลือกสายพันธุ์โค', 'Brahman']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ]),
        ),
        // ปุ้มบันทึก
        Center(
          child: Container(
              height: 60,
              width: 360,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: new RaisedButton(
                  // กดแลเวให้ไปหน้า FisrtPage/SelectInput
                  onPressed: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => SelectInput()));
                  },
                  child: Text("บันทึก",
                      style: TextStyle(
                          fontSize: 24,
                          color: Color(hex.hexColor("ffffff")),
                          fontWeight: FontWeight.bold)),
                  color: Color(hex.hexColor("#47B5BE")),
                  // รูปทรงปุ่ม
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0),
                    // กรอบปุ่ม
                    side: BorderSide(color: Colors.white),
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
