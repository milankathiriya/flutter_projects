import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper dbHelper = DBHelper._();

  final String TABLE = "students";
  final String COL_ID = "id";
  final String COL_NAME = "name";
  final String COL_AGE = "age";
  final String COL_IMAGE = "image";

  Database? db;

  initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'chinook.db');

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "chinook.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);

      print("DB write successfully in device...");
    } else {
      print("Opening existing database");
    }
// open the database
    db = await openDatabase(path, readOnly: true);
  }

  fetchAllData() async {
    await initDB();

    String sql = "SELECT * FROM albums";

    List<Map<String, dynamic>> data = await db!.rawQuery(sql);

    print(data);
  }

  //
  // Future<int> insert(Student student) async {
  //   await initDB();
  //
  //   String sql =
  //       "INSERT INTO $TABLE($COL_NAME, $COL_AGE, $COL_IMAGE) VALUES(?, ?, ?)";
  //   List args = [student.name, student.age, student.image];
  //
  //   return await db!.rawInsert(sql, args);
  // }
  //
  // Future<List<Student>> fetchAllData() async {
  //   await initDB();
  //
  //   String sql = "SELECT * FROM $TABLE";
  //
  //   List<Map<String, dynamic>> data = await db!.rawQuery(sql);
  //
  //   return data.map((e) => Student.fromMap(e)).toList();
  // }
  //
  // Future<int> delete(int? id) async {
  //   await initDB();
  //
  //   String sql = "DELETE FROM $TABLE WHERE id=?";
  //   List args = [id];
  //
  //   return await db!.rawDelete(sql, args);
  // }
  //
  // Future<int> update(int? id, Student student) async {
  //   await initDB();
  //
  //   String sql = "UPDATE $TABLE SET name=?, age=?, image=? WHERE id=?";
  //   List args = [student.name, student.age, student.image, id];
  //
  //   return await db!.rawUpdate(sql, args);
  // }
  //
  // Future<List<Student>> search(String name) async {
  //   await initDB();
  //
  //   String sql = "SELECT * FROM $TABLE WHERE name LIKE '%$name%'";
  //
  //   List<Map<String, dynamic>> data = await db!.rawQuery(sql);
  //
  //   return data.map((e) => Student.fromMap(e)).toList();
  // }
}
