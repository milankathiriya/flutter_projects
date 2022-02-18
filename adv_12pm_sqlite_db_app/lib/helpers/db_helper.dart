import 'package:adv_12pm_sqlite_db_app/models/student_model.dart';
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
    String path = join(databasesPath, 'rnw.db');

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE IF NOT EXISTS $TABLE ($COL_ID INTEGER PRIMARY KEY AUTOINCREMENT, $COL_NAME TEXT, $COL_AGE INTEGER, $COL_IMAGE BLOB)');

        print("Table created successfully..");
      },
    );
  }

  Future<int> insert(Student student) async {
    await initDB();

    String sql =
        "INSERT INTO $TABLE($COL_NAME, $COL_AGE, $COL_IMAGE) VALUES(?, ?, ?)";
    List args = [student.name, student.age, student.image];

    return await db!.rawInsert(sql, args);
  }

  Future<List<Student>> fetchAllData() async {
    await initDB();

    String sql = "SELECT * FROM $TABLE";

    List<Map<String, dynamic>> data = await db!.rawQuery(sql);

    return data.map((e) => Student.fromMap(e)).toList();
  }

  Future<int> delete(int? id) async {
    await initDB();

    String sql = "DELETE FROM $TABLE WHERE id=?";
    List args = [id];

    return await db!.rawDelete(sql, args);
  }

  Future<int> update(int? id, Student student) async {
    await initDB();

    String sql = "UPDATE $TABLE SET name=?, age=?, image=? WHERE id=?";
    List args = [student.name, student.age, student.image, id];

    return await db!.rawUpdate(sql, args);
  }

  Future<List<Student>> search(String name) async {
    await initDB();

    String sql = "SELECT * FROM $TABLE WHERE name LIKE '%$name%'";

    List<Map<String, dynamic>> data = await db!.rawQuery(sql);

    return data.map((e) => Student.fromMap(e)).toList();
  }
}
