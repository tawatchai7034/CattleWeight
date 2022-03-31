import 'package:cattle_weight/DataBase/catImage_handler.dart';
import 'package:cattle_weight/DataBase/catPro_handler.dart';
import 'package:cattle_weight/DataBase/catTime_handler.dart';
import 'package:cattle_weight/model/catPro.dart';
import 'package:cattle_weight/Screens/Pages/catPro_Create.dart';
import 'package:cattle_weight/Screens/Pages/catPro_Edit.dart';
import 'package:cattle_weight/Screens/Pages/catTime_screen.dart';
import 'package:flutter/material.dart';

class CatProScreen extends StatefulWidget {
  const CatProScreen({Key? key}) : super(key: key);

  @override
  _CatProScreenState createState() => _CatProScreenState();
}

class _CatProScreenState extends State<CatProScreen> {
  CatProHelper? dbHelper;
  CatTimeHelper? dbCatTime;
  CatImageHelper? dbImage;
  late Future<List<CatProModel>> notesList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = new CatProHelper();
    dbCatTime = new CatTimeHelper();
    dbImage = new CatImageHelper();
    loadData();
  }

  loadData() async {
    notesList = dbHelper!.getCatProList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cattle SQL"), centerTitle: true, actions: [
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
                builder: (context, AsyncSnapshot<List<CatProModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        reverse: false,
                        shrinkWrap: true,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CatTimeScreen(
                                      catPro: snapshot.data![index])));
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
                                  // delete row in catpro table with snapshot.data![index].id!
                                  dbHelper!
                                      .deleteCatPro(snapshot.data![index].id!);

                                  // delete row in cattime table with snapshot.data![index].id!
                                  dbCatTime!.deleteCatTimeWithIdPro(
                                      snapshot.data![index].id!);

                                  // delete cattle Image in images table
                                  dbImage!.deleteWithIDPro(
                                      snapshot.data![index].id!);

                                  notesList = dbHelper!.getCatProList();
                                  snapshot.data!.remove(snapshot.data![index]);
                                });
                              },
                              key: ValueKey<int>(snapshot.data![index].id!),
                              child: Card(
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  title: Text(
                                      snapshot.data![index].name.toString()),
                                  subtitle: Text(
                                      "Gender: ${snapshot.data![index].gender.toString()}\nSpecies: ${snapshot.data![index].species.toString()}"),
                                  trailing: IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CatProFormEdit(
                                                        catPro: snapshot
                                                            .data![index])));

                                        // dbHelper!.updateCatPro(CatProModel(
                                        //   id: snapshot.data![index].id!,
                                        //   name: "cattle01",
                                        //   gender: "female",
                                        //   species: "barhman",
                                        // ));

                                        // setState(() {
                                        //   notesList = dbHelper!.getCatProList();
                                        // });
                                      },
                                      icon: Icon(Icons.edit)),
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CatProFormCreate()));
            // dbHelper!
            //     .insert(CatProModel(
            //   name: "cattle02",
            //   gender: "male",
            //   species: "angus",
            // ))
            //     .then((value) {
            //   print("Add data completed");
            //   setState(() {
            //     notesList = dbHelper!.getCatProList();
            //   });
            //   notesList = dbHelper!.getCatProList();
            // }).onError((error, stackTrace) {
            //   print("Error: " + error.toString());
            // });
          },
          child: const Icon(Icons.add)),
    );
  }
}
