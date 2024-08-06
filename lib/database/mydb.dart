import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Mydb {
  Future<Database> initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'student.db');
    return await openDatabase(databasePath);
  }

  Future<bool> copyPasteAssetFileToRoot() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "student.db");

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data = await rootBundle.load(
          join('assets/database', 'student.db'));
      List<int> bytes = data.buffer.asUint8List(
          data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
      print("asf");
      return true;
    }
    return false;
  }
  Future<List<Map<String, dynamic>>>getstudent() async{
    Database db=await initDatabase();
    List<Map<String, Object?>> data = await db.rawQuery('select * from studentinfo');
    return data;
  }

  Future<void>deletestudent(String a)async{
    Database db = await initDatabase();
    await db.rawDelete("delete from studentinfo where Enrollno='$a'");
  }

  Future<int>insertstudent(Map<String, Object?> map) async{
    Database db = await initDatabase();
    var res =await db.insert("studentinfo", map);
    return res;
  }

  Future<int> editstudent(Map<String,Object?> map,id) async {
    Database db = await initDatabase();
    var res =await db.update("studentinfo", map,where: "Enrollno = ?",whereArgs: [id]);
    return res;
  }
}


