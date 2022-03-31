import 'dart:convert';
import 'dart:io';

import 'package:cattle_weight/Camera/camera_screen.dart';
import 'package:cattle_weight/DataBase/catImage_handler.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:cattle_weight/model/image.dart';
import 'package:cattle_weight/model/utility.dart';

class CatImageScreen extends StatefulWidget {
  final int idPro;
  final int idTime;
  const CatImageScreen({Key? key, required this.idPro, required this.idTime})
      : super(key: key);

  @override
  State<CatImageScreen> createState() => _CatImageScreenState();
}

class _CatImageScreenState extends State<CatImageScreen> {
  late Future<File> imageFile;
  late Image image;
  CatImageHelper? ImageHelper;
  late List<ImageModel> images;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    images = [];
    ImageHelper = CatImageHelper();
    refreshImages();
  }

  refreshImages() {
    ImageHelper!.getCatTimePhotos(widget.idTime).then((imgs) {
      setState(() {
        images.clear();
        images.addAll(imgs);
      });
    });
  }

  // Future<void> pickImageFromGallery() async{
  //   final pickedImage = await _picker.pickImage(source: ImageSource.gallery).then((imgFile) {
  //     final file = File(imgFile!.path);
  //     String imgString = Utility.base64String(file.readAsBytesSync());
  //     ImageModel photo = ImageModel(
  //         idPro: widget.idPro, idTime: widget.idTime, imagePath: imgString);
  //     ImageHelper!.save(photo);
  //     refreshImages();
  //   });
  // }

  final picker = ImagePicker();
  // Implementing the image picker
  Future<void> pickImageFromGallery() async {
    final pickedImage =
        await picker.getImage(source: ImageSource.gallery).then((imgFile) {
      final file = File(imgFile!.path);
      String imgString = Utility.base64String(file.readAsBytesSync());
      ImageModel photo = ImageModel(
          idPro: widget.idPro, idTime: widget.idTime, imagePath: imgString);
      ImageHelper!.save(photo);
      refreshImages();
    });
  }

  gridView() {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: images.map((photo) {
          return InkWell(
              onTap: () {
                print("photo id: ${photo.id}");
                ImageHelper!.delete(photo);
                refreshImages();
              },
              child: Utility.imageFromBase64String(photo.imagePath));
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Flutter Save Image"),
        actions: <Widget>[
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.photo),
                onPressed: () {
                  pickImageFromGallery();
                },
              ),
              IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CameraScreen(
                            idPro: widget.idPro,
                            idTime: widget.idTime,
                          )));
                },
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: gridView(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            refreshImages();
          });
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
