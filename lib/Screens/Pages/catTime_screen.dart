import 'package:cattle_weight/DataBase/catImage_handler.dart';
import 'package:cattle_weight/DataBase/catPro_handler.dart';
import 'package:cattle_weight/DataBase/catTime_handler.dart';
import 'package:cattle_weight/Screens/Pages/addPhotoCattles.dart';
import 'package:cattle_weight/model/catPro.dart';
import 'package:cattle_weight/model/catTime.dart';
import 'package:cattle_weight/Screens/Pages/catImage_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CatTimeScreen extends StatefulWidget {
  final CatProModel catPro;
  const CatTimeScreen({Key? key, required this.catPro}) : super(key: key);

  @override
  _CatTimeScreenState createState() => _CatTimeScreenState();
}

class _CatTimeScreenState extends State<CatTimeScreen> {
  CatTimeHelper? dbHelper;
  CatProHelper? catProHelper;
  CatImageHelper? dbImage;
  late Future<List<CatTimeModel>> notesList;
  final formatDay = DateFormat('dd/MM/yyyy hh:mm a');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = new CatTimeHelper();
    catProHelper = new CatProHelper();
    dbImage = new CatImageHelper();
    loadData();
    // NotesModel(title: "User00",age: 22,description: "Default user",email: "User@exemple.com");
  }

  loadData() async {
    notesList = dbHelper!.getCatTimeListWithCatProID(widget.catPro.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("${widget.catPro.name}"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    loadData();
                  });
                },
                icon: Icon(Icons.refresh)),
          ]),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: notesList,
                builder: (context, AsyncSnapshot<List<CatTimeModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        reverse: false,
                        shrinkWrap: true,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CatImageScreen(
                                      idPro: widget.catPro.id!,
                                      idTime: snapshot.data![index].id!)));
                            },
                            child: Dismissible(
                              direction: DismissDirection.endToStart,
                              background: Container(
                                  color: Colors.red,
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Icon(Icons.delete_forever)),
                              onDismissed: (DismissDirection direction) {
                                setState(() {
                                  // delete row in cattime table with snapshot.data![index].id!
                                  dbHelper!
                                      .deleteCatTime(snapshot.data![index].id!);

                                  // delete cattle Image in images table
                                  dbImage!.deleteWithIDTime(
                                      snapshot.data![index].id!);

                                  notesList = dbHelper!
                                      .getCatTimeListWithCatProID(
                                          widget.catPro.id!);
                                  snapshot.data!.remove(snapshot.data![index]);
                                });
                              },
                              key: ValueKey<int>(snapshot.data![index].id!),
                              child: Card(
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  title: Text(formatDay.format(DateTime.parse(
                                      snapshot.data![index].date))),
                                  subtitle: Text(
                                      snapshot.data![index].note.toString()),
                                  trailing: IconButton(
                                      onPressed: () {
                                        // dbHelper!.updateCatTime(CatTimeModel(
                                        //     id: snapshot.data![index].id!,
                                        //     idPro: widget.catPro.id!,
                                        //     bodyLenght: 10,
                                        //     heartGirth: 10,
                                        //     hearLenghtSide: 10,
                                        //     hearLenghtRear: 10,
                                        //     hearLenghtTop: 10,
                                        //     pixelReference: 10,
                                        //     distanceReference: 10,
                                        //     imageSide: 10,
                                        //     imageRear: 10,
                                        //     imageTop: 10,
                                        //     date: DateTime.now()
                                        //         .toIso8601String(),
                                        //     note: "New update"));

                                        // setState(() {
                                        //   notesList = dbHelper!
                                        //       .getCatTimeListWithCatProID(
                                        //           widget.catPro.id!);
                                        // });

                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddPhotoCattles(
                                                        idPro:
                                                            widget.catPro.id!,
                                                        idTime: snapshot
                                                            .data![index]
                                                            .id!,
                                                        catTime:snapshot.data![index])));
                                      },
                                      icon: Icon(Icons.edit)),
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            dbHelper!
                .insert(CatTimeModel(
                    idPro: widget.catPro.id!,
                    weight: 0,
                    bodyLenght: 0,
                    heartGirth: 0,
                    hearLenghtSide: 0,
                    hearLenghtRear: 0,
                    hearLenghtTop: 0,
                    pixelReference: 0,
                    distanceReference: 0,
                    imageSide: '',
                    imageRear: '',
                    imageTop: '',
                    date: DateTime.now().toIso8601String(),
                    note: "New create"))
                .then((value) {
              print("Add data completed");
              setState(() {
                notesList =
                    dbHelper!.getCatTimeListWithCatProID(widget.catPro.id!);
              });
              notesList =
                  dbHelper!.getCatTimeListWithCatProID(widget.catPro.id!);
            }).onError((error, stackTrace) {
              print("Error: " + error.toString());
            });
          },
          child: const Icon(Icons.add)),
    );
  }
}
