import 'package:adv_6pm_sqlite_app/models/student_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper dbHelper = DBHelper._();

  Database? db;

  final String dbName = "rnw.db";
  final String tableName = "students";
  final String colId = "id";
  final String colName = "name";
  final String colAge = "age";
  final String colImage = "image";

  Future<Database?> initDB() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, dbName);

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        String sql =
            "CREATE TABLE $tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colAge INTEGER, $colImage BLOB)";

        await db.execute(sql);

        print("Table created successfully..");
      },
    );

    return db;
  }

  Future<int> insert(Student s) async {
    await initDB();

    String sql =
        "INSERT INTO $tableName($colName, $colAge, $colImage) VALUES(?, ?, ?)";
    List args = [s.name, s.age, s.image];

    return await db!.rawInsert(sql, args);
  }

  Future<List<Student>> fetchAllData() async {
    await initDB();

    String sql = "SELECT * FROM $tableName";
    List<Map<String, dynamic>> data = await db!.rawQuery(sql);

    return data.map((e) => Student.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    await initDB();

    String sql = "DELETE FROM $tableName WHERE id=?";
    List args = [id];

    return await db!.rawDelete(sql, args);
  }

  Future<int> update(Student student, int? id) async {
    await initDB();

    String sql = "UPDATE $tableName SET name=?, age=?, image=? WHERE id=?";
    List args = [student.name, student.age, student.image, id];

    return await db!.rawUpdate(sql, args);
  }

  Future<List<Student>> search(String val) async {
    await initDB();

    String sql = "SELECT * FROM $tableName WHERE name LIKE '%$val%'";

    List<Map<String, dynamic>> data = await db!.rawQuery(sql);

    return data.map((e) => Student.fromMap(e)).toList();
  }
}
