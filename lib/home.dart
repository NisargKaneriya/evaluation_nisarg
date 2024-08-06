import 'package:evaluation_nisarg/insert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'database/mydb.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget cancelButton() {
    return TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("Cancel"));
  }

  Widget deleteButton({dynamic snapshot, int? index}) {
    return TextButton(
      child: Text("Delete"),
      onPressed: () async {
        setState(() {
          Mydb().deletestudent(snapshot.data![index]['Enrollno'].toString());
        });
        Navigator.of(context).pop();
      },
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Mydb().copyPasteAssetFileToRoot(),
        builder:  (context, snapshot) {
          if(snapshot.hasData){
              return FutureBuilder(
                  future: Mydb().getstudent(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Row(
                                children: [
                                  Expanded(child: Text(snapshot.data![index]["Enrollno"].toString())),
                                  Expanded(child: Text(snapshot.data![index]["Name"].toString())),
                                  Expanded(child: Text(snapshot.data![index]["Age"].toString())),
                                  Expanded(
                                      child: InkWell(
                                          onTap: () async {
                                            AlertDialog alert = AlertDialog(
                                              title: Text("Delete"),
                                              content: Text(
                                                  "Would you like to Delete data"),
                                              actions: [
                                                cancelButton(),
                                                deleteButton(
                                                    snapshot: snapshot,
                                                    index: index),
                                              ],
                                            );
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return alert;
                                              },
                                            );
                                          },
                                          child:
                                          Icon(Icons.delete_forever_rounded))),
                                  Expanded(
                                      child: InkWell(
                                          onTap: () async {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                                      return Addstudentd(
                                                          snapshot.data![index]);
                                                    })).then((value) {
                                              setState(() {});
                                            });
                                          },
                                          child: Icon(Icons.edit))),
                                ],
                              ),
                            );
                          },);
                    }
                    else {
                      return CircularProgressIndicator();
                    }
                  },);
          }
          else {
            return CircularProgressIndicator();
          }
        }

      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Addstudentd(null);
            })).then((value) {
              setState(() {});
            });
          },
          child: Icon(
            Icons.add_sharp,color: Colors.black,
          ),
        )
    );
  }
}
