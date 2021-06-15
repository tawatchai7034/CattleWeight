import 'package:flutter/material.dart';
import 'HomePage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color(hex.hexColor("#007BA4")),
      ),body: Center(
        child: Text("Profile page"),
      ),
      );
  }
}