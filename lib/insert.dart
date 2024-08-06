import 'package:flutter/material.dart';
import 'database/mydb.dart';

class Addstudentd extends StatefulWidget {
  Map<String,Object?>? map;


  Addstudentd(map){
    this.map=map;
  }



  @override
  State<Addstudentd> createState() => _AddstudentdState();
}

class _AddstudentdState extends State<Addstudentd> {
  @override
  var enrollnoIdController = TextEditingController();
  var nameController = TextEditingController();
  var ageIdController = TextEditingController();

  void initState() {
    nameController.text =
    widget.map == null ? '' : widget.map!["Name"].toString();
    enrollnoIdController.text =
    widget.map == null ? '' : widget.map!["Enrollno"].toString();
    ageIdController.text =
    widget.map == null ? '' : widget.map!["Age"].toString();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Student Ragistraion"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,color: Colors.black,
            ),
            color: Colors.white,
          ),
        ),
        body: Card(
          child: Column(
            children: [
              Container(
                child: TextFormField(
                  controller: enrollnoIdController,
                  decoration: InputDecoration(hintText: "Enter enrollment"),
                ),
              ),
              Container(
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: "Enter Name"),
                ),
              ),
              Container(
                child: TextFormField(
                  controller: ageIdController,
                  decoration: InputDecoration(hintText: "Enter Age"),
                ),
              ),
              Center(
                child: Container(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (widget.map == null) {
                        insertstudent()
                            .then((value) => Navigator.of(context).pop(true));
                      } else {
                        editstudent(widget.map!["Enrollno"].toString())
                            .then((value) => Navigator.of(context).pop(true));
                      }
                    },
                    child: Text("Submit"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
  Future<int> insertstudent() async {
    Map<String, Object?> map = Map<String, Object?>();
    map["Name"] = nameController.text;
    map["Enrollno"] = enrollnoIdController.text;
    map["Age"] = ageIdController.text;

    var res = await Mydb().insertstudent(map);
    return res;
  }
  Future<int> editstudent(id) async {
    Map<String, Object?> map = Map<String, Object?>();
    map["Name"] = nameController.text;
    map["Enrollno"] = enrollnoIdController.text;
    map["Age"] = ageIdController.text;
    var res = await Mydb().editstudent(map, id);
    return res;
  }
}
